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

abstract class UserProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UserProfile._({
    this.id,
    required this.authUserId,
    required this.displayName,
    required this.role,
    required this.societyId,
    required this.experienceLevel,
    required this.primaryGoal,
    required this.preferredWorkoutDuration,
    required this.onboardingComplete,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile({
    int? id,
    required String authUserId,
    required String displayName,
    required String role,
    required int societyId,
    required String experienceLevel,
    required String primaryGoal,
    required int preferredWorkoutDuration,
    required bool onboardingComplete,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserProfileImpl;

  factory UserProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      role: jsonSerialization['role'] as String,
      societyId: jsonSerialization['societyId'] as int,
      experienceLevel: jsonSerialization['experienceLevel'] as String,
      primaryGoal: jsonSerialization['primaryGoal'] as String,
      preferredWorkoutDuration:
          jsonSerialization['preferredWorkoutDuration'] as int,
      onboardingComplete: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['onboardingComplete'],
      ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String authUserId;

  String displayName;

  String role;

  int societyId;

  String experienceLevel;

  String primaryGoal;

  int preferredWorkoutDuration;

  bool onboardingComplete;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UserProfile copyWith({
    int? id,
    String? authUserId,
    String? displayName,
    String? role,
    int? societyId,
    String? experienceLevel,
    String? primaryGoal,
    int? preferredWorkoutDuration,
    bool? onboardingComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId,
      'displayName': displayName,
      'role': role,
      'societyId': societyId,
      'experienceLevel': experienceLevel,
      'primaryGoal': primaryGoal,
      'preferredWorkoutDuration': preferredWorkoutDuration,
      'onboardingComplete': onboardingComplete,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId,
      'displayName': displayName,
      'role': role,
      'societyId': societyId,
      'experienceLevel': experienceLevel,
      'primaryGoal': primaryGoal,
      'preferredWorkoutDuration': preferredWorkoutDuration,
      'onboardingComplete': onboardingComplete,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserProfileImpl extends UserProfile {
  _UserProfileImpl({
    int? id,
    required String authUserId,
    required String displayName,
    required String role,
    required int societyId,
    required String experienceLevel,
    required String primaryGoal,
    required int preferredWorkoutDuration,
    required bool onboardingComplete,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         displayName: displayName,
         role: role,
         societyId: societyId,
         experienceLevel: experienceLevel,
         primaryGoal: primaryGoal,
         preferredWorkoutDuration: preferredWorkoutDuration,
         onboardingComplete: onboardingComplete,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UserProfile copyWith({
    Object? id = _Undefined,
    String? authUserId,
    String? displayName,
    String? role,
    int? societyId,
    String? experienceLevel,
    String? primaryGoal,
    int? preferredWorkoutDuration,
    bool? onboardingComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      societyId: societyId ?? this.societyId,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      primaryGoal: primaryGoal ?? this.primaryGoal,
      preferredWorkoutDuration:
          preferredWorkoutDuration ?? this.preferredWorkoutDuration,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
