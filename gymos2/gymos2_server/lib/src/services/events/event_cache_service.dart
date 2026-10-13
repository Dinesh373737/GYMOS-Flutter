import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import 'external_event_provider.dart';
import 'parse_allevents_provider.dart';

typedef ExternalDiscovery = ({
  List<ExternalEventCache> events,
  String state,
  String status,
  List<String> supportedCities,
});

/// Serves external events from the database cache and refreshes them from the
/// configured provider when they expire. Failures fall back to clearly labeled
/// cached rows; nothing is ever fabricated.
class EventCacheService {
  /// Test hook for supplying a fake provider (or `null` for "unconfigured").
  static ExternalEventProvider? Function(Session session)? providerOverride;

  static final _inFlight = <String, Future<void>>{};
  static final _backoffUntil = <String, DateTime>{};
  static final _lastAttempt = <String, DateTime>{};

  static Duration get ttl => Duration(
    minutes:
        int.tryParse(
          Platform.environment['EXTERNAL_EVENTS_CACHE_TTL_MINUTES'] ?? '',
        )?.clamp(15, 1440) ??
        360,
  );

  static ExternalEventProvider? provider(Session s) {
    final override = providerOverride;
    if (override != null) return override(s);
    final key =
        s.serverpod.getPassword('ALLEVENTS_API_KEY') ??
        Platform.environment['ALLEVENTS_API_KEY'];
    if (key == null || key.trim().isEmpty) return null;
    return ParseAllEventsProvider(key.trim());
  }

  static const _aliases = {
    'nyc': 'New York',
    'ny': 'New York',
    'new york city': 'New York',
    'manhattan': 'New York',
    'brooklyn': 'New York',
    'tokio': 'Tokyo',
    'greater london': 'London',
  };

  /// Maps free-text city input onto a city the provider can search.
  static String? canonicalCity(String input, List<String> supported) {
    final text = input.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
    if (text.isEmpty) return null;
    final alias = _aliases[text];
    for (final city in supported) {
      if (city.toLowerCase() == text || city == alias) return city;
    }
    if (supported.isEmpty) {
      return text
          .split(' ')
          .map((w) => w.isEmpty ? w : w[0].toUpperCase() + w.substring(1))
          .join(' ');
    }
    return null;
  }

  static Future<ExternalDiscovery> discover(
    Session s,
    String city, {
    bool allowRefresh = true,
  }) async {
    final source = provider(s);
    if (source == null) {
      return (
        events: const <ExternalEventCache>[],
        state: 'unconfigured',
        status:
            'External events are not configured on this server. Community events still work.',
        supportedCities: const <String>[],
      );
    }

    final supported = source.supportedCities;
    final canonical = canonicalCity(city, supported);
    if (canonical == null) {
      return (
        events: const <ExternalEventCache>[],
        state: 'unsupported',
        status:
            '${source.displayName} listings are available for ${supported.join(', ')}. Your community events are unaffected.',
        supportedCities: supported,
      );
    }

    final key = canonical.toLowerCase();
    final now = DateTime.now().toUtc();
    var rows = await _rows(s, source.id, key, now);
    final fresh =
        rows.isNotEmpty && rows.every((r) => r.expiresAt.isAfter(now));
    final attempted = _lastAttempt[key];
    final recentlyEmpty =
        rows.isEmpty &&
        attempted != null &&
        now.difference(attempted) < ttl &&
        (_backoffUntil[key]?.isBefore(now) ?? true);

    if (fresh || recentlyEmpty || !allowRefresh) {
      return (
        events: rows,
        state: rows.isEmpty && !recentlyEmpty ? 'unavailable' : 'cached',
        status: rows.isEmpty
            ? recentlyEmpty
                  ? 'No upcoming fitness listings from ${source.displayName} in $canonical right now.'
                  : 'Nothing is cached for $canonical yet.'
            : 'Cached ${source.displayName} listings for $canonical. Source links open the original page.',
        supportedCities: supported,
      );
    }

    final backoff = _backoffUntil[key];
    String? failure;
    if (backoff != null && backoff.isAfter(now)) {
      failure = '${source.displayName} is temporarily unavailable.';
    } else {
      try {
        await refresh(s, source, canonical);
      } on ExternalProviderException catch (e) {
        failure = e.message;
      }
    }

    rows = await _rows(s, source.id, key, now);
    if (failure == null) {
      return (
        events: rows,
        state: 'live',
        status: rows.isEmpty
            ? 'No upcoming fitness listings from ${source.displayName} in $canonical right now.'
            : 'Fresh ${source.displayName} listings for $canonical. Source links open the original page.',
        supportedCities: supported,
      );
    }
    return (
      events: rows,
      state: rows.isEmpty ? 'unavailable' : 'stale',
      status: rows.isEmpty
          ? '$failure Nothing is cached for $canonical yet.'
          : '$failure Showing previously cached listings.',
      supportedCities: supported,
    );
  }

  /// Fetches [city] from [source] and replaces its cached rows. Concurrent
  /// callers for the same city share one provider request.
  static Future<void> refresh(
    Session s,
    ExternalEventProvider source,
    String city,
  ) {
    final key = city.toLowerCase();
    // The block body matters: returning the removed future would make the
    // refresh wait on itself.
    return _inFlight[key] ??= _refresh(s, source, city, key).whenComplete(() {
      _inFlight.remove(key);
    });
  }

  static Future<void> _refresh(
    Session s,
    ExternalEventProvider source,
    String city,
    String key,
  ) async {
    final now = DateTime.now().toUtc();
    _lastAttempt[key] = now;
    final List<ExternalEventListing> listings;
    try {
      listings = await source.search(city, now: now);
    } on ExternalProviderException catch (e) {
      _backoffUntil[key] = now.add(e.retryAfter);
      s.log(
        'External events refresh failed for $city: ${e.message}',
        level: LogLevel.warning,
      );
      rethrow;
    }
    _backoffUntil.remove(key);

    final expires = now.add(ttl);
    await s.db.transaction((tx) async {
      final existing = {
        for (final row in await ExternalEventCache.db.find(
          s,
          where: (t) => t.provider.equals(source.id) & t.queryKey.equals(key),
          transaction: tx,
        ))
          row.providerEventId: row,
      };
      for (final l in listings) {
        final old = existing.remove(l.providerEventId);
        final row = ExternalEventCache(
          id: old?.id,
          provider: source.id,
          providerEventId: l.providerEventId,
          queryKey: key,
          title: l.title,
          category: l.category,
          startsAt: l.startsAt,
          endsAt: l.endsAt,
          latitude: l.latitude,
          longitude: l.longitude,
          venueLabel: l.venueLabel,
          organizerName: l.organizerName,
          imageUrl: l.imageUrl,
          sourceUrl: l.sourceUrl,
          rawHash: l.rawHash,
          fetchedAt: now,
          expiresAt: expires,
        );
        if (old == null) {
          await ExternalEventCache.db.insertRow(s, row, transaction: tx);
        } else {
          await ExternalEventCache.db.updateRow(s, row, transaction: tx);
        }
      }
      if (existing.isNotEmpty) {
        await ExternalEventCache.db.delete(
          s,
          existing.values.toList(),
          transaction: tx,
        );
      }
    });
    s.log('Cached ${listings.length} external events for $city.');
  }

  /// Refreshes cities that already have cached rows and removes listings that
  /// have ended. Used by the recurring future call.
  static Future<int> housekeeping(Session s) async {
    final now = DateTime.now().toUtc();
    final cutoff = now.subtract(const Duration(days: 1));
    final removed = await ExternalEventCache.db.deleteWhere(
      s,
      where: (t) =>
          (t.endsAt < cutoff) | (t.endsAt.equals(null) & (t.startsAt < cutoff)),
    );
    final source = provider(s);
    if (source == null) return removed.length;
    final keys = (await ExternalEventCache.db.find(
      s,
      where: (t) => t.provider.equals(source.id) & (t.expiresAt < now),
    )).map((r) => r.queryKey).toSet();
    for (final key in keys) {
      final city = canonicalCity(key, source.supportedCities);
      if (city == null) continue;
      try {
        await refresh(s, source, city);
      } on ExternalProviderException {
        // Logged in refresh; stale rows remain available and labeled.
      }
    }
    return removed.length;
  }

  static Future<List<ExternalEventCache>> _rows(
    Session s,
    String provider,
    String key,
    DateTime now,
  ) => ExternalEventCache.db.find(
    s,
    where: (t) =>
        t.provider.equals(provider) &
        t.queryKey.equals(key) &
        ((t.endsAt > now) |
            (t.endsAt.equals(null) &
                (t.startsAt > now.subtract(const Duration(hours: 3))))),
    orderBy: (t) => t.startsAt,
    limit: 40,
  );

  /// Clears in-memory refresh state. Tests use this between cases.
  static void reset() {
    _inFlight.clear();
    _backoffUntil.clear();
    _lastAttempt.clear();
  }
}
