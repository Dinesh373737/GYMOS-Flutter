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

abstract class ExerciseMuscle
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ExerciseMuscle._({
    this.id,
    required this.exerciseId,
    required this.muscleGroupId,
    required this.contribution,
  });

  factory ExerciseMuscle({
    int? id,
    required int exerciseId,
    required int muscleGroupId,
    required double contribution,
  }) = _ExerciseMuscleImpl;

  factory ExerciseMuscle.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseMuscle(
      id: jsonSerialization['id'] as int?,
      exerciseId: jsonSerialization['exerciseId'] as int,
      muscleGroupId: jsonSerialization['muscleGroupId'] as int,
      contribution: (jsonSerialization['contribution'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int exerciseId;

  int muscleGroupId;

  double contribution;

  /// Returns a shallow copy of this [ExerciseMuscle]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ExerciseMuscle copyWith({
    int? id,
    int? exerciseId,
    int? muscleGroupId,
    double? contribution,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseMuscle',
      if (id != null) 'id': id,
      'exerciseId': exerciseId,
      'muscleGroupId': muscleGroupId,
      'contribution': contribution,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExerciseMuscle',
      if (id != null) 'id': id,
      'exerciseId': exerciseId,
      'muscleGroupId': muscleGroupId,
      'contribution': contribution,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseMuscleImpl extends ExerciseMuscle {
  _ExerciseMuscleImpl({
    int? id,
    required int exerciseId,
    required int muscleGroupId,
    required double contribution,
  }) : super._(
         id: id,
         exerciseId: exerciseId,
         muscleGroupId: muscleGroupId,
         contribution: contribution,
       );

  /// Returns a shallow copy of this [ExerciseMuscle]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ExerciseMuscle copyWith({
    Object? id = _Undefined,
    int? exerciseId,
    int? muscleGroupId,
    double? contribution,
  }) {
    return ExerciseMuscle(
      id: id is int? ? id : this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      muscleGroupId: muscleGroupId ?? this.muscleGroupId,
      contribution: contribution ?? this.contribution,
    );
  }
}
