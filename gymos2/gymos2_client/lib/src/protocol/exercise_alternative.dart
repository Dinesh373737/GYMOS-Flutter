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

abstract class ExerciseAlternative
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ExerciseAlternative._({
    this.id,
    required this.sourceExerciseId,
    required this.alternativeExerciseId,
    required this.similarityScore,
    required this.notes,
  });

  factory ExerciseAlternative({
    int? id,
    required int sourceExerciseId,
    required int alternativeExerciseId,
    required double similarityScore,
    required String notes,
  }) = _ExerciseAlternativeImpl;

  factory ExerciseAlternative.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseAlternative(
      id: jsonSerialization['id'] as int?,
      sourceExerciseId: jsonSerialization['sourceExerciseId'] as int,
      alternativeExerciseId: jsonSerialization['alternativeExerciseId'] as int,
      similarityScore: (jsonSerialization['similarityScore'] as num).toDouble(),
      notes: jsonSerialization['notes'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int sourceExerciseId;

  int alternativeExerciseId;

  double similarityScore;

  String notes;

  /// Returns a shallow copy of this [ExerciseAlternative]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ExerciseAlternative copyWith({
    int? id,
    int? sourceExerciseId,
    int? alternativeExerciseId,
    double? similarityScore,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseAlternative',
      if (id != null) 'id': id,
      'sourceExerciseId': sourceExerciseId,
      'alternativeExerciseId': alternativeExerciseId,
      'similarityScore': similarityScore,
      'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExerciseAlternative',
      if (id != null) 'id': id,
      'sourceExerciseId': sourceExerciseId,
      'alternativeExerciseId': alternativeExerciseId,
      'similarityScore': similarityScore,
      'notes': notes,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseAlternativeImpl extends ExerciseAlternative {
  _ExerciseAlternativeImpl({
    int? id,
    required int sourceExerciseId,
    required int alternativeExerciseId,
    required double similarityScore,
    required String notes,
  }) : super._(
         id: id,
         sourceExerciseId: sourceExerciseId,
         alternativeExerciseId: alternativeExerciseId,
         similarityScore: similarityScore,
         notes: notes,
       );

  /// Returns a shallow copy of this [ExerciseAlternative]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ExerciseAlternative copyWith({
    Object? id = _Undefined,
    int? sourceExerciseId,
    int? alternativeExerciseId,
    double? similarityScore,
    String? notes,
  }) {
    return ExerciseAlternative(
      id: id is int? ? id : this.id,
      sourceExerciseId: sourceExerciseId ?? this.sourceExerciseId,
      alternativeExerciseId:
          alternativeExerciseId ?? this.alternativeExerciseId,
      similarityScore: similarityScore ?? this.similarityScore,
      notes: notes ?? this.notes,
    );
  }
}
