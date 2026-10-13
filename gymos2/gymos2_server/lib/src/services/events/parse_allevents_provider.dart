import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'external_event_provider.dart';

/// Reads allevents.in listings through the third-party Parse.bot wrapper. This
/// is not the official AllEvents developer API: the wrapper only searches the
/// cities it declares and returns display-formatted local times.
class ParseAllEventsProvider implements ExternalEventProvider {
  static const _base =
      'https://api.parse.bot/scraper/3fe3d7da-7728-4b0d-b7e7-c0c4db6fa853';

  // Two provider categories cover the fitness-relevant listings; each request
  // costs one Parse.bot credit, so the list is intentionally short.
  static const _categories = ['sports', 'health-wellness'];

  final String apiKey;
  final http.Client transport;
  final Duration timeout;

  ParseAllEventsProvider(
    this.apiKey, {
    http.Client? transport,
    this.timeout = const Duration(seconds: 25),
  }) : transport = transport ?? http.Client();

  @override
  String get id => 'allevents';

  @override
  String get displayName => 'AllEvents';

  @override
  List<String> get supportedCities => const ['London', 'New York', 'Tokyo'];

  @override
  Future<List<ExternalEventListing>> search(
    String city, {
    DateTime? now,
  }) async {
    final batches = await Future.wait([
      for (final category in _categories) _fetch(city, category),
    ]);
    final seen = <String>{};
    final listings = <ExternalEventListing>[];
    for (final raw in batches.expand((b) => b)) {
      final listing = normalize(raw, city, now: now ?? DateTime.now().toUtc());
      if (listing != null && seen.add(listing.providerEventId)) {
        listings.add(listing);
      }
    }
    listings.sort((a, b) => a.startsAt.compareTo(b.startsAt));
    return listings;
  }

  Future<List<Map<String, dynamic>>> _fetch(
    String city,
    String category,
  ) async {
    final http.Response response;
    try {
      response = await transport
          .get(
            Uri.parse('$_base/search_events').replace(
              queryParameters: {
                'city': city,
                'category': category,
                'limit': '16',
              },
            ),
            headers: {'X-API-Key': apiKey, 'Accept': 'application/json'},
          )
          .timeout(timeout);
    } on TimeoutException {
      throw const ExternalProviderException(
        'AllEvents did not respond in time.',
      );
    } catch (_) {
      throw const ExternalProviderException('AllEvents could not be reached.');
    }

    switch (response.statusCode) {
      case 200:
        break;
      case 401:
        throw const ExternalProviderException(
          'The event provider rejected the configured credential.',
          retryAfter: Duration(hours: 1),
        );
      case 402:
        throw const ExternalProviderException(
          'The event provider quota is used up for now.',
          retryAfter: Duration(hours: 6),
        );
      case 429:
        final seconds = int.tryParse(response.headers['retry-after'] ?? '');
        throw ExternalProviderException(
          'The event provider is rate limiting requests.',
          retryAfter: Duration(seconds: (seconds ?? 600).clamp(60, 21600)),
        );
      default:
        throw const ExternalProviderException(
          'The event provider is temporarily unavailable.',
          retryAfter: Duration(minutes: 15),
        );
    }

    try {
      final body = jsonDecode(response.body);
      if (body is! Map || body['status'] != 'success') {
        throw const FormatException();
      }
      final events = (body['data'] as Map?)?['events'];
      if (events is! List) return const [];
      return [
        for (final e in events)
          if (e is Map) Map<String, dynamic>.from(e),
      ];
    } catch (_) {
      throw const ExternalProviderException(
        'The event provider returned an unexpected response.',
      );
    }
  }

  /// Maps one wrapper result to a listing, or returns null when it is not a
  /// fitness activity or lacks the data needed to show it honestly.
  static ExternalEventListing? normalize(
    Map<String, dynamic> raw,
    String city, {
    required DateTime now,
  }) {
    final id = '${raw['event_id'] ?? ''}'.trim();
    final title = _clean('${raw['name'] ?? ''}', 160);
    final url = '${raw['event_url'] ?? ''}'.trim();
    if (id.isEmpty || title.isEmpty || !url.startsWith('https://')) {
      return null;
    }

    final category = classify(
      title: title,
      categories: _strings(raw['categories']),
      tags: _strings(raw['tags']),
    );
    if (category == null) return null;

    final start = parseDisplayTime(
      '${raw['start_time_display'] ?? ''}',
      city,
      now: now,
    );
    if (start == null) return null;
    var end = parseDisplayTime(
      '${raw['end_time_display'] ?? ''}',
      city,
      now: start,
    );
    if (end != null && end.isBefore(start)) end = null;
    if ((end ?? start).isBefore(now)) return null;

    final venue = raw['venue'] is Map
        ? Map<String, dynamic>.from(raw['venue'] as Map)
        : const <String, dynamic>{};
    var lat = double.tryParse('${venue['latitude'] ?? ''}');
    var lng = double.tryParse('${venue['longitude'] ?? ''}');
    if (lat == null ||
        lng == null ||
        !lat.isFinite ||
        !lng.isFinite ||
        lat.abs() > 90 ||
        lng.abs() > 180 ||
        (lat == 0 && lng == 0)) {
      lat = null;
      lng = null;
    }

    final organizer = raw['organizer'] is Map
        ? _clean('${(raw['organizer'] as Map)['name'] ?? ''}', 120)
        : '';
    final image = '${raw['banner_url'] ?? ''}'.trim();

    return ExternalEventListing(
      providerEventId: id,
      title: title,
      category: category,
      startsAt: start,
      endsAt: end,
      latitude: lat,
      longitude: lng,
      venueLabel: _clean(
        '${raw['location'] ?? venue['full_address'] ?? ''}',
        200,
      ),
      organizerName: organizer.isEmpty ? null : organizer,
      imageUrl: image.startsWith('https://') ? image : null,
      sourceUrl: url,
      rawHash: _fnv1a(jsonEncode(raw)),
    );
  }

  static const _keywords = {
    'running': [
      'marathon',
      'half marathon',
      'run',
      'running',
      'runners',
      '5k',
      '10k',
      'parkrun',
      'jog',
      'trail race',
    ],
    'cycling': ['cycling', 'cycle', 'bike', 'biking', 'bicycle', 'velo'],
    'yoga': ['yoga', 'pilates', 'vinyasa', 'ashtanga'],
    'fitness': [
      'fitness',
      'workout',
      'bootcamp',
      'boot camp',
      'hiit',
      'crossfit',
      'calisthenics',
      'strength',
      'gym',
      'zumba',
      'spin class',
    ],
    'sports': [
      'football',
      'soccer',
      'tennis',
      'basketball',
      'climbing',
      'bouldering',
      'swim',
      'swimming',
      'hiking',
      'hike',
      'boxing',
      'martial',
      'triathlon',
      'rowing',
      'badminton',
      'volleyball',
      'cricket',
      'rugby',
      'skating',
    ],
  };

  /// Chooses a GymOS category from text and provider tags. Generic "sports"
  /// or "wellness" tags alone do not qualify spectator or spa events.
  static String? classify({
    required String title,
    required List<String> categories,
    required List<String> tags,
  }) {
    final text = ' ${[title, ...tags].join(' ').toLowerCase()} ';
    bool mentions(String word) => RegExp(
      '(^|[^a-z0-9])${RegExp.escape(word)}([^a-z0-9]|\$)',
    ).hasMatch(text);
    for (final entry in _keywords.entries) {
      if (entry.value.any(mentions)) return entry.key;
    }
    final slugs = categories.map((c) => c.toLowerCase()).toSet();
    if (slugs.contains('marathons')) return 'running';
    if (slugs.contains('yoga') || slugs.contains('pilates')) return 'yoga';
    if (slugs.contains('fitness')) return 'fitness';
    return null;
  }

  static const _months = {
    'jan': 1,
    'feb': 2,
    'mar': 3,
    'apr': 4,
    'may': 5,
    'jun': 6,
    'jul': 7,
    'aug': 8,
    'sep': 9,
    'oct': 10,
    'nov': 11,
    'dec': 12,
  };

  /// Parses wrapper times such as "Fri, 16 Oct at 11:00 am" in the city's
  /// local time and returns UTC. The year is omitted by the provider, so the
  /// closest occurrence that is not long past is used.
  static DateTime? parseDisplayTime(
    String text,
    String city, {
    required DateTime now,
  }) {
    final m = RegExp(
      r'(\d{1,2})\s+([A-Za-z]{3})[a-z]*\.?(?:\s+(\d{4}))?\s+at\s+(\d{1,2}):(\d{2})\s*([ap]m)',
      caseSensitive: false,
    ).firstMatch(text);
    if (m == null) return null;
    final month = _months[m.group(2)!.toLowerCase()];
    final day = int.parse(m.group(1)!);
    var hour = int.parse(m.group(4)!);
    final minute = int.parse(m.group(5)!);
    if (month == null || day > 31 || hour > 12 || minute > 59) return null;
    final pm = m.group(6)!.toLowerCase() == 'pm';
    if (hour == 12) hour = 0;
    if (pm) hour += 12;

    DateTime toUtc(int year) {
      final local = DateTime.utc(year, month, day, hour, minute);
      return local.subtract(Duration(hours: utcOffsetHours(city, local)));
    }

    final explicitYear = int.tryParse(m.group(3) ?? '');
    if (explicitYear != null) return toUtc(explicitYear);
    final candidate = toUtc(now.toUtc().year);
    return candidate.isBefore(now.toUtc().subtract(const Duration(days: 60)))
        ? toUtc(now.toUtc().year + 1)
        : candidate;
  }

  /// Standard/daylight offsets for the supported cities. [local] is a wall
  /// clock time expressed as a UTC DateTime.
  static int utcOffsetHours(String city, DateTime local) {
    DateTime nthSunday(int year, int month, int n) {
      var d = DateTime.utc(year, month, 1);
      while (d.weekday != DateTime.sunday) {
        d = d.add(const Duration(days: 1));
      }
      return d.add(Duration(days: 7 * (n - 1)));
    }

    DateTime lastSunday(int year, int month) {
      var d = DateTime.utc(
        year,
        month + 1,
        1,
      ).subtract(const Duration(days: 1));
      while (d.weekday != DateTime.sunday) {
        d = d.subtract(const Duration(days: 1));
      }
      return d;
    }

    final y = local.year;
    switch (city) {
      case 'London':
        final start = lastSunday(y, 3).add(const Duration(hours: 1));
        final end = lastSunday(y, 10).add(const Duration(hours: 2));
        return !local.isBefore(start) && local.isBefore(end) ? 1 : 0;
      case 'New York':
        final start = nthSunday(y, 3, 2).add(const Duration(hours: 2));
        final end = nthSunday(y, 11, 1).add(const Duration(hours: 2));
        return !local.isBefore(start) && local.isBefore(end) ? -4 : -5;
      case 'Tokyo':
        return 9;
      default:
        return 0;
    }
  }

  static List<String> _strings(Object? value) => value is List
      ? [
          for (final v in value)
            if ('$v'.trim().isNotEmpty) '$v'.trim(),
        ]
      : const [];

  static const _entities = {
    'amp': '&',
    'quot': '"',
    'apos': "'",
    'lt': '<',
    'gt': '>',
    'nbsp': ' ',
  };

  static String _clean(String value, int max) {
    final text = value
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAllMapped(RegExp(r'&(#x?[0-9a-fA-F]+|[a-z]+);'), (m) {
          final code = m.group(1)!;
          if (!code.startsWith('#')) return _entities[code] ?? m.group(0)!;
          final n = code.startsWith('#x')
              ? int.tryParse(code.substring(2), radix: 16)
              : int.tryParse(code.substring(1));
          return n == null || n < 32 || n > 0x10FFFF
              ? ''
              : String.fromCharCode(n);
        })
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    return text.length > max ? text.substring(0, max) : text;
  }

  static String _fnv1a(String input) {
    var hash = 0xcbf29ce484222325;
    for (final unit in utf8.encode(input)) {
      hash ^= unit;
      hash *= 0x100000001b3;
    }
    return hash.toUnsigned(64).toRadixString(16).padLeft(16, '0');
  }

  void close() => transport.close();
}
