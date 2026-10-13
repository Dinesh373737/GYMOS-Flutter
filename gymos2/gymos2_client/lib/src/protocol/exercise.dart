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

abstract class Exercise
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Exercise._({
    this.id,
    required this.name,
    required this.slug,
    required this.instructions,
    required this.difficulty,
    required this.movementPattern,
    required this.exerciseType,
    required this.defaultDurationMin,
    required this.isActive,
  });

  factory Exercise({
    int? id,
    required String name,
    required String slug,
    required String instructions,
    required String difficulty,
    required String movementPattern,
    required String exerciseType,
    required int defaultDurationMin,
    required bool isActive,
  }) = _ExerciseImpl;

  factory Exercise.fromJson(Map<String, dynamic> jsonSerialization) {
    return Exercise(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      slug: jsonSerialization['slug'] as String,
      instructions: jsonSerialization['instructions'] as String,
      difficulty: jsonSerialization['difficulty'] as String,
      movementPattern: jsonSerialization['movementPattern'] as String,
      exerciseType: jsonSerialization['exerciseType'] as String,
      defaultDurationMin: jsonSerialization['defaultDurationMin'] as int,
      isActive: _isc.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String slug;

  String instructions;

  String difficulty;

  String movementPattern;

  String exerciseType;

  int defaultDurationMin;

  bool isActive;

  /// Returns a shallow copy of this [Exercise]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Exercise copyWith({
    int? id,
    String? name,
    String? slug,
    String? instructions,
    String? difficulty,
    String? movementPattern,
    String? exerciseType,
    int? defaultDurationMin,
    bool? isActive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Exercise',
      if (id != null) 'id': id,
      'name': name,
      'slug': slug,
      'instructions': instructions,
      'difficulty': difficulty,
      'movementPattern': movementPattern,
      'exerciseType': exerciseType,
      'defaultDurationMin': defaultDurationMin,
      'isActive': isActive,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Exercise',
      if (id != null) 'id': id,
      'name': name,
      'slug': slug,
      'instructions': instructions,
      'difficulty': difficulty,
      'movementPattern': movementPattern,
      'exerciseType': exerciseType,
      'defaultDurationMin': defaultDurationMin,
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseImpl extends Exercise {
  _ExerciseImpl({
    int? id,
    required String name,
    required String slug,
    required String instructions,
    required String difficulty,
    required String movementPattern,
    required String exerciseType,
    required int defaultDurationMin,
    required bool isActive,
  }) : super._(
         id: id,
         name: name,
         slug: slug,
         instructions: instructions,
         difficulty: difficulty,
         movementPattern: movementPattern,
         exerciseType: exerciseType,
         defaultDurationMin: defaultDurationMin,
         isActive: isActive,
       );

  /// Returns a shallow copy of this [Exercise]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Exercise copyWith({
    Object? id = _Undefined,
    String? name,
    String? slug,
    String? instructions,
    String? difficulty,
    String? movementPattern,
    String? exerciseType,
    int? defaultDurationMin,
    bool? isActive,
  }) {
    return Exercise(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      instructions: instructions ?? this.instructions,
      difficulty: difficulty ?? this.difficulty,
      movementPattern: movementPattern ?? this.movementPattern,
      exerciseType: exerciseType ?? this.exerciseType,
      defaultDurationMin: defaultDurationMin ?? this.defaultDurationMin,
      isActive: isActive ?? this.isActive,
    );
  }
}
