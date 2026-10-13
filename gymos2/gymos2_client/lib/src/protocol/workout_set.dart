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

abstract class WorkoutSet
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WorkoutSet._({
    this.id,
    required this.sessionId,
    required this.exerciseId,
    required this.setNumber,
    this.reps,
    this.weightKg,
    this.durationSec,
    this.rpe,
    required this.completedAt,
  });

  factory WorkoutSet({
    int? id,
    required int sessionId,
    required int exerciseId,
    required int setNumber,
    int? reps,
    double? weightKg,
    int? durationSec,
    double? rpe,
    required DateTime completedAt,
  }) = _WorkoutSetImpl;

  factory WorkoutSet.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutSet(
      id: jsonSerialization['id'] as int?,
      sessionId: jsonSerialization['sessionId'] as int,
      exerciseId: jsonSerialization['exerciseId'] as int,
      setNumber: jsonSerialization['setNumber'] as int,
      reps: jsonSerialization['reps'] as int?,
      weightKg: (jsonSerialization['weightKg'] as num?)?.toDouble(),
      durationSec: jsonSerialization['durationSec'] as int?,
      rpe: (jsonSerialization['rpe'] as num?)?.toDouble(),
      completedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['completedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int sessionId;

  int exerciseId;

  int setNumber;

  int? reps;

  double? weightKg;

  int? durationSec;

  double? rpe;

  DateTime completedAt;

  /// Returns a shallow copy of this [WorkoutSet]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WorkoutSet copyWith({
    int? id,
    int? sessionId,
    int? exerciseId,
    int? setNumber,
    int? reps,
    double? weightKg,
    int? durationSec,
    double? rpe,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutSet',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'exerciseId': exerciseId,
      'setNumber': setNumber,
      if (reps != null) 'reps': reps,
      if (weightKg != null) 'weightKg': weightKg,
      if (durationSec != null) 'durationSec': durationSec,
      if (rpe != null) 'rpe': rpe,
      'completedAt': completedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutSet',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'exerciseId': exerciseId,
      'setNumber': setNumber,
      if (reps != null) 'reps': reps,
      if (weightKg != null) 'weightKg': weightKg,
      if (durationSec != null) 'durationSec': durationSec,
      if (rpe != null) 'rpe': rpe,
      'completedAt': completedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutSetImpl extends WorkoutSet {
  _WorkoutSetImpl({
    int? id,
    required int sessionId,
    required int exerciseId,
    required int setNumber,
    int? reps,
    double? weightKg,
    int? durationSec,
    double? rpe,
    required DateTime completedAt,
  }) : super._(
         id: id,
         sessionId: sessionId,
         exerciseId: exerciseId,
         setNumber: setNumber,
         reps: reps,
         weightKg: weightKg,
         durationSec: durationSec,
         rpe: rpe,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [WorkoutSet]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WorkoutSet copyWith({
    Object? id = _Undefined,
    int? sessionId,
    int? exerciseId,
    int? setNumber,
    Object? reps = _Undefined,
    Object? weightKg = _Undefined,
    Object? durationSec = _Undefined,
    Object? rpe = _Undefined,
    DateTime? completedAt,
  }) {
    return WorkoutSet(
      id: id is int? ? id : this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseId: exerciseId ?? this.exerciseId,
      setNumber: setNumber ?? this.setNumber,
      reps: reps is int? ? reps : this.reps,
      weightKg: weightKg is double? ? weightKg : this.weightKg,
      durationSec: durationSec is int? ? durationSec : this.durationSec,
      rpe: rpe is double? ? rpe : this.rpe,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
