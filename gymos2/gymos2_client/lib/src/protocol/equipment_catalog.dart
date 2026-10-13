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

abstract class EquipmentCatalog
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EquipmentCatalog._({
    this.id,
    required this.name,
    required this.category,
    required this.description,
  });

  factory EquipmentCatalog({
    int? id,
    required String name,
    required String category,
    required String description,
  }) = _EquipmentCatalogImpl;

  factory EquipmentCatalog.fromJson(Map<String, dynamic> jsonSerialization) {
    return EquipmentCatalog(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      category: jsonSerialization['category'] as String,
      description: jsonSerialization['description'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String category;

  String description;

  /// Returns a shallow copy of this [EquipmentCatalog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EquipmentCatalog copyWith({
    int? id,
    String? name,
    String? category,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EquipmentCatalog',
      if (id != null) 'id': id,
      'name': name,
      'category': category,
      'description': description,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EquipmentCatalog',
      if (id != null) 'id': id,
      'name': name,
      'category': category,
      'description': description,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EquipmentCatalogImpl extends EquipmentCatalog {
  _EquipmentCatalogImpl({
    int? id,
    required String name,
    required String category,
    required String description,
  }) : super._(
         id: id,
         name: name,
         category: category,
         description: description,
       );

  /// Returns a shallow copy of this [EquipmentCatalog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EquipmentCatalog copyWith({
    Object? id = _Undefined,
    String? name,
    String? category,
    String? description,
  }) {
    return EquipmentCatalog(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }
}
