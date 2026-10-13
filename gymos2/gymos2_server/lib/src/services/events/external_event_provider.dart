/// A normalized listing returned by an external event source. Providers map
/// their own payloads into this shape so the cache and UI never depend on a
/// specific vendor format.
class ExternalEventListing {
  final String providerEventId;
  final String title;
  final String category;
  final DateTime startsAt;
  final DateTime? endsAt;
  final double? latitude;
  final double? longitude;
  final String venueLabel;
  final String? organizerName;
  final String? imageUrl;
  final String sourceUrl;
  final String rawHash;

  const ExternalEventListing({
    required this.providerEventId,
    required this.title,
    required this.category,
    required this.startsAt,
    required this.sourceUrl,
    required this.rawHash,
    this.venueLabel = '',
    this.endsAt,
    this.latitude,
    this.longitude,
    this.organizerName,
    this.imageUrl,
  });
}

/// Raised when a provider cannot currently answer. [retryAfter] lets the cache
/// back off instead of hammering a rate-limited or failing upstream.
class ExternalProviderException implements Exception {
  final String message;
  final Duration retryAfter;

  const ExternalProviderException(
    this.message, {
    this.retryAfter = const Duration(minutes: 10),
  });

  @override
  String toString() => 'ExternalProviderException: $message';
}

abstract interface class ExternalEventProvider {
  /// Stable provider identifier persisted with cached rows.
  String get id;

  /// Human-readable source name shown next to listings.
  String get displayName;

  /// Canonical city names the provider can search, or empty when any city is
  /// accepted.
  List<String> get supportedCities;

  /// Returns fitness-relevant upcoming events for a canonical [city].
  Future<List<ExternalEventListing>> search(String city, {DateTime? now});
}
