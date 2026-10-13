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
import 'package:serverpod/serverpod.dart' as _is;

abstract class ExercisePoint
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ExercisePoint._({
    required this.sessionId,
    required this.day,
    required this.topWeightKg,
    required this.volumeKg,
    required this.totalReps,
    required this.sets,
  });

  factory ExercisePoint({
    required int sessionId,
    required DateTime day,
    required double topWeightKg,
    required double volumeKg,
    required int totalReps,
    required int sets,
  }) = _ExercisePointImpl;

  factory ExercisePoint.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExercisePoint(
      sessionId: jsonSerialization['sessionId'] as int,
      day: _is.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      topWeightKg: (jsonSerialization['topWeightKg'] as num).toDouble(),
      volumeKg: (jsonSerialization['volumeKg'] as num).toDouble(),
      totalReps: jsonSerialization['totalReps'] as int,
      sets: jsonSerialization['sets'] as int,
    );
  }

  int sessionId;

  DateTime day;

  double topWeightKg;

  double volumeKg;

  int totalReps;

  int sets;

  /// Returns a shallow copy of this [ExercisePoint]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ExercisePoint copyWith({
    int? sessionId,
    DateTime? day,
    double? topWeightKg,
    double? volumeKg,
    int? totalReps,
    int? sets,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExercisePoint',
      'sessionId': sessionId,
      'day': day.toJson(),
      'topWeightKg': topWeightKg,
      'volumeKg': volumeKg,
      'totalReps': totalReps,
      'sets': sets,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExercisePoint',
      'sessionId': sessionId,
      'day': day.toJson(),
      'topWeightKg': topWeightKg,
      'volumeKg': volumeKg,
      'totalReps': totalReps,
      'sets': sets,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ExercisePointImpl extends ExercisePoint {
  _ExercisePointImpl({
    required int sessionId,
    required DateTime day,
    required double topWeightKg,
    required double volumeKg,
    required int totalReps,
    required int sets,
  }) : super._(
         sessionId: sessionId,
         day: day,
         topWeightKg: topWeightKg,
         volumeKg: volumeKg,
         totalReps: totalReps,
         sets: sets,
       );

  /// Returns a shallow copy of this [ExercisePoint]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ExercisePoint copyWith({
    int? sessionId,
    DateTime? day,
    double? topWeightKg,
    double? volumeKg,
    int? totalReps,
    int? sets,
  }) {
    return ExercisePoint(
      sessionId: sessionId ?? this.sessionId,
      day: day ?? this.day,
      topWeightKg: topWeightKg ?? this.topWeightKg,
      volumeKg: volumeKg ?? this.volumeKg,
      totalReps: totalReps ?? this.totalReps,
      sets: sets ?? this.sets,
    );
  }
}
