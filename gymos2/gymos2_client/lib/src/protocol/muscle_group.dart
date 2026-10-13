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

abstract class MuscleGroup
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MuscleGroup._({
    this.id,
    required this.name,
    required this.bodyArea,
  });

  factory MuscleGroup({
    int? id,
    required String name,
    required String bodyArea,
  }) = _MuscleGroupImpl;

  factory MuscleGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return MuscleGroup(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      bodyArea: jsonSerialization['bodyArea'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String bodyArea;

  /// Returns a shallow copy of this [MuscleGroup]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MuscleGroup copyWith({
    int? id,
    String? name,
    String? bodyArea,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MuscleGroup',
      if (id != null) 'id': id,
      'name': name,
      'bodyArea': bodyArea,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MuscleGroup',
      if (id != null) 'id': id,
      'name': name,
      'bodyArea': bodyArea,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MuscleGroupImpl extends MuscleGroup {
  _MuscleGroupImpl({
    int? id,
    required String name,
    required String bodyArea,
  }) : super._(
         id: id,
         name: name,
         bodyArea: bodyArea,
       );

  /// Returns a shallow copy of this [MuscleGroup]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MuscleGroup copyWith({
    Object? id = _Undefined,
    String? name,
    String? bodyArea,
  }) {
    return MuscleGroup(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      bodyArea: bodyArea ?? this.bodyArea,
    );
  }
}
