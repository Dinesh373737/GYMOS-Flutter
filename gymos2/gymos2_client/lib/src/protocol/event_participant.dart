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

abstract class EventParticipant
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EventParticipant._({
    this.id,
    required this.eventId,
    required this.userId,
    required this.joinedAt,
    required this.status,
  });

  factory EventParticipant({
    int? id,
    required int eventId,
    required int userId,
    required DateTime joinedAt,
    required String status,
  }) = _EventParticipantImpl;

  factory EventParticipant.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventParticipant(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      userId: jsonSerialization['userId'] as int,
      joinedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
      status: jsonSerialization['status'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int eventId;

  int userId;

  DateTime joinedAt;

  String status;

  /// Returns a shallow copy of this [EventParticipant]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EventParticipant copyWith({
    int? id,
    int? eventId,
    int? userId,
    DateTime? joinedAt,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventParticipant',
      if (id != null) 'id': id,
      'eventId': eventId,
      'userId': userId,
      'joinedAt': joinedAt.toJson(),
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventParticipant',
      if (id != null) 'id': id,
      'eventId': eventId,
      'userId': userId,
      'joinedAt': joinedAt.toJson(),
      'status': status,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventParticipantImpl extends EventParticipant {
  _EventParticipantImpl({
    int? id,
    required int eventId,
    required int userId,
    required DateTime joinedAt,
    required String status,
  }) : super._(
         id: id,
         eventId: eventId,
         userId: userId,
         joinedAt: joinedAt,
         status: status,
       );

  /// Returns a shallow copy of this [EventParticipant]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EventParticipant copyWith({
    Object? id = _Undefined,
    int? eventId,
    int? userId,
    DateTime? joinedAt,
    String? status,
  }) {
    return EventParticipant(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      joinedAt: joinedAt ?? this.joinedAt,
      status: status ?? this.status,
    );
  }
}
