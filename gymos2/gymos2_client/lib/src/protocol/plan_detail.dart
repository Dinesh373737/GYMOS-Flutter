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
import 'package:gymos2_client/src/protocol/protocol.dart' as _ihoj8lp7;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'exercise.dart' as _ij3o2h1q;
import 'workout_plan.dart' as _ibmdzv6r;
import 'workout_plan_item.dart' as _ikhy8p9s;

abstract class PlanDetail
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PlanDetail._({
    required this.plan,
    required this.items,
    required this.exercises,
  });

  factory PlanDetail({
    required _ibmdzv6r.WorkoutPlan plan,
    required List<_ikhy8p9s.WorkoutPlanItem> items,
    required List<_ij3o2h1q.Exercise> exercises,
  }) = _PlanDetailImpl;

  factory PlanDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlanDetail(
      plan: _ihoj8lp7.Protocol().deserialize<_ibmdzv6r.WorkoutPlan>(
        jsonSerialization['plan'],
      ),
      items: _ihoj8lp7.Protocol().deserialize<List<_ikhy8p9s.WorkoutPlanItem>>(
        jsonSerialization['items'],
      ),
      exercises: _ihoj8lp7.Protocol().deserialize<List<_ij3o2h1q.Exercise>>(
        jsonSerialization['exercises'],
      ),
    );
  }

  _ibmdzv6r.WorkoutPlan plan;

  List<_ikhy8p9s.WorkoutPlanItem> items;

  List<_ij3o2h1q.Exercise> exercises;

  /// Returns a shallow copy of this [PlanDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PlanDetail copyWith({
    _ibmdzv6r.WorkoutPlan? plan,
    List<_ikhy8p9s.WorkoutPlanItem>? items,
    List<_ij3o2h1q.Exercise>? exercises,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlanDetail',
      'plan': plan.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'exercises': exercises.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlanDetail',
      'plan': plan.toJsonForProtocol(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'exercises': exercises.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _PlanDetailImpl extends PlanDetail {
  _PlanDetailImpl({
    required _ibmdzv6r.WorkoutPlan plan,
    required List<_ikhy8p9s.WorkoutPlanItem> items,
    required List<_ij3o2h1q.Exercise> exercises,
  }) : super._(
         plan: plan,
         items: items,
         exercises: exercises,
       );

  /// Returns a shallow copy of this [PlanDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PlanDetail copyWith({
    _ibmdzv6r.WorkoutPlan? plan,
    List<_ikhy8p9s.WorkoutPlanItem>? items,
    List<_ij3o2h1q.Exercise>? exercises,
  }) {
    return PlanDetail(
      plan: plan ?? this.plan.copyWith(),
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      exercises:
          exercises ?? this.exercises.map((e0) => e0.copyWith()).toList(),
    );
  }
}
