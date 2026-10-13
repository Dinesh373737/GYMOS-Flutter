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

abstract class ExerciseEquipment
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ExerciseEquipment._({
    this.id,
    required this.exerciseId,
    required this.equipmentId,
    required this.required,
  });

  factory ExerciseEquipment({
    int? id,
    required int exerciseId,
    required int equipmentId,
    required bool required,
  }) = _ExerciseEquipmentImpl;

  factory ExerciseEquipment.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseEquipment(
      id: jsonSerialization['id'] as int?,
      exerciseId: jsonSerialization['exerciseId'] as int,
      equipmentId: jsonSerialization['equipmentId'] as int,
      required: _isc.BoolJsonExtension.fromJson(jsonSerialization['required']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int exerciseId;

  int equipmentId;

  bool required;

  /// Returns a shallow copy of this [ExerciseEquipment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ExerciseEquipment copyWith({
    int? id,
    int? exerciseId,
    int? equipmentId,
    bool? required,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseEquipment',
      if (id != null) 'id': id,
      'exerciseId': exerciseId,
      'equipmentId': equipmentId,
      'required': required,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExerciseEquipment',
      if (id != null) 'id': id,
      'exerciseId': exerciseId,
      'equipmentId': equipmentId,
      'required': required,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseEquipmentImpl extends ExerciseEquipment {
  _ExerciseEquipmentImpl({
    int? id,
    required int exerciseId,
    required int equipmentId,
    required bool required,
  }) : super._(
         id: id,
         exerciseId: exerciseId,
         equipmentId: equipmentId,
         required: required,
       );

  /// Returns a shallow copy of this [ExerciseEquipment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ExerciseEquipment copyWith({
    Object? id = _Undefined,
    int? exerciseId,
    int? equipmentId,
    bool? required,
  }) {
    return ExerciseEquipment(
      id: id is int? ? id : this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      equipmentId: equipmentId ?? this.equipmentId,
      required: required ?? this.required,
    );
  }
}
