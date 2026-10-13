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

abstract class MemberSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MemberSummary._({
    required this.profileId,
    required this.displayName,
    required this.role,
    required this.isActive,
    required this.joinedAt,
    required this.workoutsLast30Days,
  });

  factory MemberSummary({
    required int profileId,
    required String displayName,
    required String role,
    required bool isActive,
    required DateTime joinedAt,
    required int workoutsLast30Days,
  }) = _MemberSummaryImpl;

  factory MemberSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return MemberSummary(
      profileId: jsonSerialization['profileId'] as int,
      displayName: jsonSerialization['displayName'] as String,
      role: jsonSerialization['role'] as String,
      isActive: _is.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      joinedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
      workoutsLast30Days: jsonSerialization['workoutsLast30Days'] as int,
    );
  }

  int profileId;

  String displayName;

  String role;

  bool isActive;

  DateTime joinedAt;

  int workoutsLast30Days;

  /// Returns a shallow copy of this [MemberSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MemberSummary copyWith({
    int? profileId,
    String? displayName,
    String? role,
    bool? isActive,
    DateTime? joinedAt,
    int? workoutsLast30Days,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MemberSummary',
      'profileId': profileId,
      'displayName': displayName,
      'role': role,
      'isActive': isActive,
      'joinedAt': joinedAt.toJson(),
      'workoutsLast30Days': workoutsLast30Days,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MemberSummary',
      'profileId': profileId,
      'displayName': displayName,
      'role': role,
      'isActive': isActive,
      'joinedAt': joinedAt.toJson(),
      'workoutsLast30Days': workoutsLast30Days,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _MemberSummaryImpl extends MemberSummary {
  _MemberSummaryImpl({
    required int profileId,
    required String displayName,
    required String role,
    required bool isActive,
    required DateTime joinedAt,
    required int workoutsLast30Days,
  }) : super._(
         profileId: profileId,
         displayName: displayName,
         role: role,
         isActive: isActive,
         joinedAt: joinedAt,
         workoutsLast30Days: workoutsLast30Days,
       );

  /// Returns a shallow copy of this [MemberSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MemberSummary copyWith({
    int? profileId,
    String? displayName,
    String? role,
    bool? isActive,
    DateTime? joinedAt,
    int? workoutsLast30Days,
  }) {
    return MemberSummary(
      profileId: profileId ?? this.profileId,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      joinedAt: joinedAt ?? this.joinedAt,
      workoutsLast30Days: workoutsLast30Days ?? this.workoutsLast30Days,
    );
  }
}
