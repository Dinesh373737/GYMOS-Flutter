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
import 'plan_detail.dart' as _ijosjbbk;
import 'workout_session.dart' as _ic5tnsvc;
import 'workout_set.dart' as _ia8z1hbl;

abstract class SessionDetail
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SessionDetail._({
    required this.session,
    required this.sets,
    required this.plan,
    this.previousSets,
  });

  factory SessionDetail({
    required _ic5tnsvc.WorkoutSession session,
    required List<_ia8z1hbl.WorkoutSet> sets,
    required _ijosjbbk.PlanDetail plan,
    List<_ia8z1hbl.WorkoutSet>? previousSets,
  }) = _SessionDetailImpl;

  factory SessionDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return SessionDetail(
      session: _ihoj8lp7.Protocol().deserialize<_ic5tnsvc.WorkoutSession>(
        jsonSerialization['session'],
      ),
      sets: _ihoj8lp7.Protocol().deserialize<List<_ia8z1hbl.WorkoutSet>>(
        jsonSerialization['sets'],
      ),
      plan: _ihoj8lp7.Protocol().deserialize<_ijosjbbk.PlanDetail>(
        jsonSerialization['plan'],
      ),
      previousSets: jsonSerialization['previousSets'] == null
          ? null
          : _ihoj8lp7.Protocol().deserialize<List<_ia8z1hbl.WorkoutSet>>(
              jsonSerialization['previousSets'],
            ),
    );
  }

  _ic5tnsvc.WorkoutSession session;

  List<_ia8z1hbl.WorkoutSet> sets;

  _ijosjbbk.PlanDetail plan;

  List<_ia8z1hbl.WorkoutSet>? previousSets;

  /// Returns a shallow copy of this [SessionDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SessionDetail copyWith({
    _ic5tnsvc.WorkoutSession? session,
    List<_ia8z1hbl.WorkoutSet>? sets,
    _ijosjbbk.PlanDetail? plan,
    List<_ia8z1hbl.WorkoutSet>? previousSets,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SessionDetail',
      'session': session.toJson(),
      'sets': sets.toJson(valueToJson: (v) => v.toJson()),
      'plan': plan.toJson(),
      if (previousSets != null)
        'previousSets': previousSets?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SessionDetail',
      'session': session.toJsonForProtocol(),
      'sets': sets.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'plan': plan.toJsonForProtocol(),
      if (previousSets != null)
        'previousSets': previousSets?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SessionDetailImpl extends SessionDetail {
  _SessionDetailImpl({
    required _ic5tnsvc.WorkoutSession session,
    required List<_ia8z1hbl.WorkoutSet> sets,
    required _ijosjbbk.PlanDetail plan,
    List<_ia8z1hbl.WorkoutSet>? previousSets,
  }) : super._(
         session: session,
         sets: sets,
         plan: plan,
         previousSets: previousSets,
       );

  /// Returns a shallow copy of this [SessionDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SessionDetail copyWith({
    _ic5tnsvc.WorkoutSession? session,
    List<_ia8z1hbl.WorkoutSet>? sets,
    _ijosjbbk.PlanDetail? plan,
    Object? previousSets = _Undefined,
  }) {
    return SessionDetail(
      session: session ?? this.session.copyWith(),
      sets: sets ?? this.sets.map((e0) => e0.copyWith()).toList(),
      plan: plan ?? this.plan.copyWith(),
      previousSets: previousSets is List<_ia8z1hbl.WorkoutSet>?
          ? previousSets
          : this.previousSets?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
