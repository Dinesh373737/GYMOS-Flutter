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

abstract class CommunityEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CommunityEvent._({
    this.id,
    required this.societyId,
    required this.organizerUserId,
    required this.title,
    required this.description,
    required this.category,
    required this.startsAt,
    required this.endsAt,
    required this.latitude,
    required this.longitude,
    required this.venueLabel,
    required this.capacity,
    required this.status,
    required this.isDemo,
  });

  factory CommunityEvent({
    int? id,
    required int societyId,
    required int organizerUserId,
    required String title,
    required String description,
    required String category,
    required DateTime startsAt,
    required DateTime endsAt,
    required double latitude,
    required double longitude,
    required String venueLabel,
    required int capacity,
    required String status,
    required bool isDemo,
  }) = _CommunityEventImpl;

  factory CommunityEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommunityEvent(
      id: jsonSerialization['id'] as int?,
      societyId: jsonSerialization['societyId'] as int,
      organizerUserId: jsonSerialization['organizerUserId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      category: jsonSerialization['category'] as String,
      startsAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      venueLabel: jsonSerialization['venueLabel'] as String,
      capacity: jsonSerialization['capacity'] as int,
      status: jsonSerialization['status'] as String,
      isDemo: _isc.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int societyId;

  int organizerUserId;

  String title;

  String description;

  String category;

  DateTime startsAt;

  DateTime endsAt;

  double latitude;

  double longitude;

  String venueLabel;

  int capacity;

  String status;

  bool isDemo;

  /// Returns a shallow copy of this [CommunityEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CommunityEvent copyWith({
    int? id,
    int? societyId,
    int? organizerUserId,
    String? title,
    String? description,
    String? category,
    DateTime? startsAt,
    DateTime? endsAt,
    double? latitude,
    double? longitude,
    String? venueLabel,
    int? capacity,
    String? status,
    bool? isDemo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommunityEvent',
      if (id != null) 'id': id,
      'societyId': societyId,
      'organizerUserId': organizerUserId,
      'title': title,
      'description': description,
      'category': category,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'latitude': latitude,
      'longitude': longitude,
      'venueLabel': venueLabel,
      'capacity': capacity,
      'status': status,
      'isDemo': isDemo,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CommunityEvent',
      if (id != null) 'id': id,
      'societyId': societyId,
      'organizerUserId': organizerUserId,
      'title': title,
      'description': description,
      'category': category,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'latitude': latitude,
      'longitude': longitude,
      'venueLabel': venueLabel,
      'capacity': capacity,
      'status': status,
      'isDemo': isDemo,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommunityEventImpl extends CommunityEvent {
  _CommunityEventImpl({
    int? id,
    required int societyId,
    required int organizerUserId,
    required String title,
    required String description,
    required String category,
    required DateTime startsAt,
    required DateTime endsAt,
    required double latitude,
    required double longitude,
    required String venueLabel,
    required int capacity,
    required String status,
    required bool isDemo,
  }) : super._(
         id: id,
         societyId: societyId,
         organizerUserId: organizerUserId,
         title: title,
         description: description,
         category: category,
         startsAt: startsAt,
         endsAt: endsAt,
         latitude: latitude,
         longitude: longitude,
         venueLabel: venueLabel,
         capacity: capacity,
         status: status,
         isDemo: isDemo,
       );

  /// Returns a shallow copy of this [CommunityEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CommunityEvent copyWith({
    Object? id = _Undefined,
    int? societyId,
    int? organizerUserId,
    String? title,
    String? description,
    String? category,
    DateTime? startsAt,
    DateTime? endsAt,
    double? latitude,
    double? longitude,
    String? venueLabel,
    int? capacity,
    String? status,
    bool? isDemo,
  }) {
    return CommunityEvent(
      id: id is int? ? id : this.id,
      societyId: societyId ?? this.societyId,
      organizerUserId: organizerUserId ?? this.organizerUserId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      venueLabel: venueLabel ?? this.venueLabel,
      capacity: capacity ?? this.capacity,
      status: status ?? this.status,
      isDemo: isDemo ?? this.isDemo,
    );
  }
}
