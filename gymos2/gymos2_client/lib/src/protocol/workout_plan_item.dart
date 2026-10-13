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

abstract class WorkoutPlanItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WorkoutPlanItem._({
    this.id,
    required this.planId,
    required this.exerciseId,
    required this.orderIndex,
    required this.targetSets,
    required this.targetRepsText,
    this.suggestedWeight,
    required this.restSeconds,
    required this.rationale,
  });

  factory WorkoutPlanItem({
    int? id,
    required int planId,
    required int exerciseId,
    required int orderIndex,
    required int targetSets,
    required String targetRepsText,
    double? suggestedWeight,
    required int restSeconds,
    required String rationale,
  }) = _WorkoutPlanItemImpl;

  factory WorkoutPlanItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutPlanItem(
      id: jsonSerialization['id'] as int?,
      planId: jsonSerialization['planId'] as int,
      exerciseId: jsonSerialization['exerciseId'] as int,
      orderIndex: jsonSerialization['orderIndex'] as int,
      targetSets: jsonSerialization['targetSets'] as int,
      targetRepsText: jsonSerialization['targetRepsText'] as String,
      suggestedWeight: (jsonSerialization['suggestedWeight'] as num?)
          ?.toDouble(),
      restSeconds: jsonSerialization['restSeconds'] as int,
      rationale: jsonSerialization['rationale'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int planId;

  int exerciseId;

  int orderIndex;

  int targetSets;

  String targetRepsText;

  double? suggestedWeight;

  int restSeconds;

  String rationale;

  /// Returns a shallow copy of this [WorkoutPlanItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WorkoutPlanItem copyWith({
    int? id,
    int? planId,
    int? exerciseId,
    int? orderIndex,
    int? targetSets,
    String? targetRepsText,
    double? suggestedWeight,
    int? restSeconds,
    String? rationale,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutPlanItem',
      if (id != null) 'id': id,
      'planId': planId,
      'exerciseId': exerciseId,
      'orderIndex': orderIndex,
      'targetSets': targetSets,
      'targetRepsText': targetRepsText,
      if (suggestedWeight != null) 'suggestedWeight': suggestedWeight,
      'restSeconds': restSeconds,
      'rationale': rationale,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutPlanItem',
      if (id != null) 'id': id,
      'planId': planId,
      'exerciseId': exerciseId,
      'orderIndex': orderIndex,
      'targetSets': targetSets,
      'targetRepsText': targetRepsText,
      if (suggestedWeight != null) 'suggestedWeight': suggestedWeight,
      'restSeconds': restSeconds,
      'rationale': rationale,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutPlanItemImpl extends WorkoutPlanItem {
  _WorkoutPlanItemImpl({
    int? id,
    required int planId,
    required int exerciseId,
    required int orderIndex,
    required int targetSets,
    required String targetRepsText,
    double? suggestedWeight,
    required int restSeconds,
    required String rationale,
  }) : super._(
         id: id,
         planId: planId,
         exerciseId: exerciseId,
         orderIndex: orderIndex,
         targetSets: targetSets,
         targetRepsText: targetRepsText,
         suggestedWeight: suggestedWeight,
         restSeconds: restSeconds,
         rationale: rationale,
       );

  /// Returns a shallow copy of this [WorkoutPlanItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WorkoutPlanItem copyWith({
    Object? id = _Undefined,
    int? planId,
    int? exerciseId,
    int? orderIndex,
    int? targetSets,
    String? targetRepsText,
    Object? suggestedWeight = _Undefined,
    int? restSeconds,
    String? rationale,
  }) {
    return WorkoutPlanItem(
      id: id is int? ? id : this.id,
      planId: planId ?? this.planId,
      exerciseId: exerciseId ?? this.exerciseId,
      orderIndex: orderIndex ?? this.orderIndex,
      targetSets: targetSets ?? this.targetSets,
      targetRepsText: targetRepsText ?? this.targetRepsText,
      suggestedWeight: suggestedWeight is double?
          ? suggestedWeight
          : this.suggestedWeight,
      restSeconds: restSeconds ?? this.restSeconds,
      rationale: rationale ?? this.rationale,
    );
  }
}
