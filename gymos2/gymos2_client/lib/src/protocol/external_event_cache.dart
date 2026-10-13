/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class ExternalEventCache
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ExternalEventCache._({
    this.id,
    required this.provider,
    required this.providerEventId,
    required this.queryKey,
    required this.title,
    required this.category,
    required this.startsAt,
    this.endsAt,
    this.latitude,
    this.longitude,
    required this.venueLabel,
    this.organizerName,
    this.imageUrl,
    required this.sourceUrl,
    required this.rawHash,
    required this.fetchedAt,
    required this.expiresAt,
  });

  factory ExternalEventCache({
    int? id,
    required String provider,
    required String providerEventId,
    required String queryKey,
    required String title,
    required String category,
    required DateTime startsAt,
    DateTime? endsAt,
    double? latitude,
    double? longitude,
    required String venueLabel,
    String? organizerName,
    String? imageUrl,
    required String sourceUrl,
    required String rawHash,
    required DateTime fetchedAt,
    required DateTime expiresAt,
  }) = _ExternalEventCacheImpl;

  factory ExternalEventCache.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExternalEventCache(
      id: jsonSerialization['id'] as int?,
      provider: jsonSerialization['provider'] as String,
      providerEventId: jsonSerialization['providerEventId'] as String,
      queryKey: jsonSerialization['queryKey'] as String,
      title: jsonSerialization['title'] as String,
      category: jsonSerialization['category'] as String,
      startsAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: jsonSerialization['endsAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      latitude: (jsonSerialization['latitude'] as num?)?.toDouble(),
      longitude: (jsonSerialization['longitude'] as num?)?.toDouble(),
      venueLabel: jsonSerialization['venueLabel'] as String,
      organizerName: jsonSerialization['organizerName'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      sourceUrl: jsonSerialization['sourceUrl'] as String,
      rawHash: jsonSerialization['rawHash'] as String,
      fetchedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String provider;

  String providerEventId;

  String queryKey;

  String title;

  String category;

  DateTime startsAt;

  DateTime? endsAt;

  double? latitude;

  double? longitude;

  String venueLabel;

  String? organizerName;

  String? imageUrl;

  String sourceUrl;

  String rawHash;

  DateTime fetchedAt;

  DateTime expiresAt;

  /// Returns a shallow copy of this [ExternalEventCache]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ExternalEventCache copyWith({
    int? id,
    String? provider,
    String? providerEventId,
    String? queryKey,
    String? title,
    String? category,
    DateTime? startsAt,
    DateTime? endsAt,
    double? latitude,
    double? longitude,
    String? venueLabel,
    String? organizerName,
    String? imageUrl,
    String? sourceUrl,
    String? rawHash,
    DateTime? fetchedAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExternalEventCache',
      if (id != null) 'id': id,
      'provider': provider,
      'providerEventId': providerEventId,
      'queryKey': queryKey,
      'title': title,
      'category': category,
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      'venueLabel': venueLabel,
      if (organizerName != null) 'organizerName': organizerName,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'sourceUrl': sourceUrl,
      'rawHash': rawHash,
      'fetchedAt': fetchedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExternalEventCache',
      if (id != null) 'id': id,
      'provider': provider,
      'providerEventId': providerEventId,
      'queryKey': queryKey,
      'title': title,
      'category': category,
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      'venueLabel': venueLabel,
      if (organizerName != null) 'organizerName': organizerName,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'sourceUrl': sourceUrl,
      'rawHash': rawHash,
      'fetchedAt': fetchedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExternalEventCacheImpl extends ExternalEventCache {
  _ExternalEventCacheImpl({
    int? id,
    required String provider,
    required String providerEventId,
    required String queryKey,
    required String title,
    required String category,
    required DateTime startsAt,
    DateTime? endsAt,
    double? latitude,
    double? longitude,
    required String venueLabel,
    String? organizerName,
    String? imageUrl,
    required String sourceUrl,
    required String rawHash,
    required DateTime fetchedAt,
    required DateTime expiresAt,
  }) : super._(
         id: id,
         provider: provider,
         providerEventId: providerEventId,
         queryKey: queryKey,
         title: title,
         category: category,
         startsAt: startsAt,
         endsAt: endsAt,
         latitude: latitude,
         longitude: longitude,
         venueLabel: venueLabel,
         organizerName: organizerName,
         imageUrl: imageUrl,
         sourceUrl: sourceUrl,
         rawHash: rawHash,
         fetchedAt: fetchedAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [ExternalEventCache]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ExternalEventCache copyWith({
    Object? id = _Undefined,
    String? provider,
    String? providerEventId,
    String? queryKey,
    String? title,
    String? category,
    DateTime? startsAt,
    Object? endsAt = _Undefined,
    Object? latitude = _Undefined,
    Object? longitude = _Undefined,
    String? venueLabel,
    Object? organizerName = _Undefined,
    Object? imageUrl = _Undefined,
    String? sourceUrl,
    String? rawHash,
    DateTime? fetchedAt,
    DateTime? expiresAt,
  }) {
    return ExternalEventCache(
      id: id is int? ? id : this.id,
      provider: provider ?? this.provider,
      providerEventId: providerEventId ?? this.providerEventId,
      queryKey: queryKey ?? this.queryKey,
      title: title ?? this.title,
      category: category ?? this.category,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt is DateTime? ? endsAt : this.endsAt,
      latitude: latitude is double? ? latitude : this.latitude,
      longitude: longitude is double? ? longitude : this.longitude,
      venueLabel: venueLabel ?? this.venueLabel,
      organizerName: organizerName is String?
          ? organizerName
          : this.organizerName,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      rawHash: rawHash ?? this.rawHash,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
