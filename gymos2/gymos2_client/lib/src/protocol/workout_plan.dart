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

abstract class WorkoutPlan
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WorkoutPlan._({
    this.id,
    required this.userId,
    required this.title,
    required this.createdByType,
    required this.target,
    required this.plannedDurationMin,
    required this.createdAt,
    required this.status,
  });

  factory WorkoutPlan({
    int? id,
    required int userId,
    required String title,
    required String createdByType,
    required String target,
    required int plannedDurationMin,
    required DateTime createdAt,
    required String status,
  }) = _WorkoutPlanImpl;

  factory WorkoutPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutPlan(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      createdByType: jsonSerialization['createdByType'] as String,
      target: jsonSerialization['target'] as String,
      plannedDurationMin: jsonSerialization['plannedDurationMin'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      status: jsonSerialization['status'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String title;

  String createdByType;

  String target;

  int plannedDurationMin;

  DateTime createdAt;

  String status;

  /// Returns a shallow copy of this [WorkoutPlan]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WorkoutPlan copyWith({
    int? id,
    int? userId,
    String? title,
    String? createdByType,
    String? target,
    int? plannedDurationMin,
    DateTime? createdAt,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutPlan',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'createdByType': createdByType,
      'target': target,
      'plannedDurationMin': plannedDurationMin,
      'createdAt': createdAt.toJson(),
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutPlan',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'createdByType': createdByType,
      'target': target,
      'plannedDurationMin': plannedDurationMin,
      'createdAt': createdAt.toJson(),
      'status': status,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutPlanImpl extends WorkoutPlan {
  _WorkoutPlanImpl({
    int? id,
    required int userId,
    required String title,
    required String createdByType,
    required String target,
    required int plannedDurationMin,
    required DateTime createdAt,
    required String status,
  }) : super._(
         id: id,
         userId: userId,
         title: title,
         createdByType: createdByType,
         target: target,
         plannedDurationMin: plannedDurationMin,
         createdAt: createdAt,
         status: status,
       );

  /// Returns a shallow copy of this [WorkoutPlan]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WorkoutPlan copyWith({
    Object? id = _Undefined,
    int? userId,
    String? title,
    String? createdByType,
    String? target,
    int? plannedDurationMin,
    DateTime? createdAt,
    String? status,
  }) {
    return WorkoutPlan(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      createdByType: createdByType ?? this.createdByType,
      target: target ?? this.target,
      plannedDurationMin: plannedDurationMin ?? this.plannedDurationMin,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}
