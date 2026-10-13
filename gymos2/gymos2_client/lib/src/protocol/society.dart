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

abstract class Society
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Society._({
    this.id,
    required this.name,
    required this.addressLabel,
    required this.inviteCode,
    required this.createdBy,
    required this.createdAt,
    required this.isActive,
  });

  factory Society({
    int? id,
    required String name,
    required String addressLabel,
    required String inviteCode,
    required String createdBy,
    required DateTime createdAt,
    required bool isActive,
  }) = _SocietyImpl;

  factory Society.fromJson(Map<String, dynamic> jsonSerialization) {
    return Society(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      addressLabel: jsonSerialization['addressLabel'] as String,
      inviteCode: jsonSerialization['inviteCode'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      isActive: _isc.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String addressLabel;

  String inviteCode;

  String createdBy;

  DateTime createdAt;

  bool isActive;

  /// Returns a shallow copy of this [Society]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Society copyWith({
    int? id,
    String? name,
    String? addressLabel,
    String? inviteCode,
    String? createdBy,
    DateTime? createdAt,
    bool? isActive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Society',
      if (id != null) 'id': id,
      'name': name,
      'addressLabel': addressLabel,
      'inviteCode': inviteCode,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'isActive': isActive,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Society',
      if (id != null) 'id': id,
      'name': name,
      'addressLabel': addressLabel,
      'inviteCode': inviteCode,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SocietyImpl extends Society {
  _SocietyImpl({
    int? id,
    required String name,
    required String addressLabel,
    required String inviteCode,
    required String createdBy,
    required DateTime createdAt,
    required bool isActive,
  }) : super._(
         id: id,
         name: name,
         addressLabel: addressLabel,
         inviteCode: inviteCode,
         createdBy: createdBy,
         createdAt: createdAt,
         isActive: isActive,
       );

  /// Returns a shallow copy of this [Society]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Society copyWith({
    Object? id = _Undefined,
    String? name,
    String? addressLabel,
    String? inviteCode,
    String? createdBy,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return Society(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      addressLabel: addressLabel ?? this.addressLabel,
      inviteCode: inviteCode ?? this.inviteCode,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
