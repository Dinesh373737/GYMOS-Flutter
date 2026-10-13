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

abstract class SocietyMembership
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SocietyMembership._({
    this.id,
    required this.societyId,
    required this.userId,
    required this.role,
    required this.joinedAt,
    required this.isActive,
  });

  factory SocietyMembership({
    int? id,
    required int societyId,
    required int userId,
    required String role,
    required DateTime joinedAt,
    required bool isActive,
  }) = _SocietyMembershipImpl;

  factory SocietyMembership.fromJson(Map<String, dynamic> jsonSerialization) {
    return SocietyMembership(
      id: jsonSerialization['id'] as int?,
      societyId: jsonSerialization['societyId'] as int,
      userId: jsonSerialization['userId'] as int,
      role: jsonSerialization['role'] as String,
      joinedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
      isActive: _isc.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int societyId;

  int userId;

  String role;

  DateTime joinedAt;

  bool isActive;

  /// Returns a shallow copy of this [SocietyMembership]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SocietyMembership copyWith({
    int? id,
    int? societyId,
    int? userId,
    String? role,
    DateTime? joinedAt,
    bool? isActive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SocietyMembership',
      if (id != null) 'id': id,
      'societyId': societyId,
      'userId': userId,
      'role': role,
      'joinedAt': joinedAt.toJson(),
      'isActive': isActive,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SocietyMembership',
      if (id != null) 'id': id,
      'societyId': societyId,
      'userId': userId,
      'role': role,
      'joinedAt': joinedAt.toJson(),
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SocietyMembershipImpl extends SocietyMembership {
  _SocietyMembershipImpl({
    int? id,
    required int societyId,
    required int userId,
    required String role,
    required DateTime joinedAt,
    required bool isActive,
  }) : super._(
         id: id,
         societyId: societyId,
         userId: userId,
         role: role,
         joinedAt: joinedAt,
         isActive: isActive,
       );

  /// Returns a shallow copy of this [SocietyMembership]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SocietyMembership copyWith({
    Object? id = _Undefined,
    int? societyId,
    int? userId,
    String? role,
    DateTime? joinedAt,
    bool? isActive,
  }) {
    return SocietyMembership(
      id: id is int? ? id : this.id,
      societyId: societyId ?? this.societyId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
