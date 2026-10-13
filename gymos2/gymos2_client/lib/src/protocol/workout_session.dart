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

abstract class WorkoutSession
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WorkoutSession._({
    this.id,
    required this.userId,
    required this.planId,
    required this.title,
    required this.startedAt,
    this.endedAt,
    this.durationMin,
    required this.notes,
    this.perceivedEffort,
  });

  factory WorkoutSession({
    int? id,
    required int userId,
    required int planId,
    required String title,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMin,
    required String notes,
    double? perceivedEffort,
  }) = _WorkoutSessionImpl;

  factory WorkoutSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutSession(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      planId: jsonSerialization['planId'] as int,
      title: jsonSerialization['title'] as String,
      startedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      durationMin: jsonSerialization['durationMin'] as int?,
      notes: jsonSerialization['notes'] as String,
      perceivedEffort: (jsonSerialization['perceivedEffort'] as num?)
          ?.toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int planId;

  String title;

  DateTime startedAt;

  DateTime? endedAt;

  int? durationMin;

  String notes;

  double? perceivedEffort;

  /// Returns a shallow copy of this [WorkoutSession]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WorkoutSession copyWith({
    int? id,
    int? userId,
    int? planId,
    String? title,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMin,
    String? notes,
    double? perceivedEffort,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutSession',
      if (id != null) 'id': id,
      'userId': userId,
      'planId': planId,
      'title': title,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (durationMin != null) 'durationMin': durationMin,
      'notes': notes,
      if (perceivedEffort != null) 'perceivedEffort': perceivedEffort,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutSession',
      if (id != null) 'id': id,
      'userId': userId,
      'planId': planId,
      'title': title,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (durationMin != null) 'durationMin': durationMin,
      'notes': notes,
      if (perceivedEffort != null) 'perceivedEffort': perceivedEffort,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutSessionImpl extends WorkoutSession {
  _WorkoutSessionImpl({
    int? id,
    required int userId,
    required int planId,
    required String title,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMin,
    required String notes,
    double? perceivedEffort,
  }) : super._(
         id: id,
         userId: userId,
         planId: planId,
         title: title,
         startedAt: startedAt,
         endedAt: endedAt,
         durationMin: durationMin,
         notes: notes,
         perceivedEffort: perceivedEffort,
       );

  /// Returns a shallow copy of this [WorkoutSession]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WorkoutSession copyWith({
    Object? id = _Undefined,
    int? userId,
    int? planId,
    String? title,
    DateTime? startedAt,
    Object? endedAt = _Undefined,
    Object? durationMin = _Undefined,
    String? notes,
    Object? perceivedEffort = _Undefined,
  }) {
    return WorkoutSession(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      planId: planId ?? this.planId,
      title: title ?? this.title,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      durationMin: durationMin is int? ? durationMin : this.durationMin,
      notes: notes ?? this.notes,
      perceivedEffort: perceivedEffort is double?
          ? perceivedEffort
          : this.perceivedEffort,
    );
  }
}
