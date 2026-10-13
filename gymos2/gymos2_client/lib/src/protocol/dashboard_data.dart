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
import 'community_event.dart' as _inypuiwd;
import 'society.dart' as _imb18de8;
import 'society_equipment.dart' as _isihw7hu;
import 'training_readiness.dart' as _izoaoiwz;
import 'user_profile.dart' as _ir2mn8w1;
import 'workout_session.dart' as _ic5tnsvc;

abstract class DashboardData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DashboardData._({
    required this.profile,
    required this.society,
    required this.equipment,
    required this.readiness,
    required this.recentSessions,
    required this.events,
    required this.completedSets,
    required this.volumeKg,
  });

  factory DashboardData({
    required _ir2mn8w1.UserProfile profile,
    required _imb18de8.Society society,
    required List<_isihw7hu.SocietyEquipment> equipment,
    required List<_izoaoiwz.TrainingReadiness> readiness,
    required List<_ic5tnsvc.WorkoutSession> recentSessions,
    required List<_inypuiwd.CommunityEvent> events,
    required int completedSets,
    required double volumeKg,
  }) = _DashboardDataImpl;

  factory DashboardData.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardData(
      profile: _ihoj8lp7.Protocol().deserialize<_ir2mn8w1.UserProfile>(
        jsonSerialization['profile'],
      ),
      society: _ihoj8lp7.Protocol().deserialize<_imb18de8.Society>(
        jsonSerialization['society'],
      ),
      equipment: _ihoj8lp7.Protocol()
          .deserialize<List<_isihw7hu.SocietyEquipment>>(
            jsonSerialization['equipment'],
          ),
      readiness: _ihoj8lp7.Protocol()
          .deserialize<List<_izoaoiwz.TrainingReadiness>>(
            jsonSerialization['readiness'],
          ),
      recentSessions: _ihoj8lp7.Protocol()
          .deserialize<List<_ic5tnsvc.WorkoutSession>>(
            jsonSerialization['recentSessions'],
          ),
      events: _ihoj8lp7.Protocol().deserialize<List<_inypuiwd.CommunityEvent>>(
        jsonSerialization['events'],
      ),
      completedSets: jsonSerialization['completedSets'] as int,
      volumeKg: (jsonSerialization['volumeKg'] as num).toDouble(),
    );
  }

  _ir2mn8w1.UserProfile profile;

  _imb18de8.Society society;

  List<_isihw7hu.SocietyEquipment> equipment;

  List<_izoaoiwz.TrainingReadiness> readiness;

  List<_ic5tnsvc.WorkoutSession> recentSessions;

  List<_inypuiwd.CommunityEvent> events;

  int completedSets;

  double volumeKg;

  /// Returns a shallow copy of this [DashboardData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DashboardData copyWith({
    _ir2mn8w1.UserProfile? profile,
    _imb18de8.Society? society,
    List<_isihw7hu.SocietyEquipment>? equipment,
    List<_izoaoiwz.TrainingReadiness>? readiness,
    List<_ic5tnsvc.WorkoutSession>? recentSessions,
    List<_inypuiwd.CommunityEvent>? events,
    int? completedSets,
    double? volumeKg,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardData',
      'profile': profile.toJson(),
      'society': society.toJson(),
      'equipment': equipment.toJson(valueToJson: (v) => v.toJson()),
      'readiness': readiness.toJson(valueToJson: (v) => v.toJson()),
      'recentSessions': recentSessions.toJson(valueToJson: (v) => v.toJson()),
      'events': events.toJson(valueToJson: (v) => v.toJson()),
      'completedSets': completedSets,
      'volumeKg': volumeKg,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DashboardData',
      'profile': profile.toJsonForProtocol(),
      'society': society.toJsonForProtocol(),
      'equipment': equipment.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'readiness': readiness.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'recentSessions': recentSessions.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'events': events.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'completedSets': completedSets,
      'volumeKg': volumeKg,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DashboardDataImpl extends DashboardData {
  _DashboardDataImpl({
    required _ir2mn8w1.UserProfile profile,
    required _imb18de8.Society society,
    required List<_isihw7hu.SocietyEquipment> equipment,
    required List<_izoaoiwz.TrainingReadiness> readiness,
    required List<_ic5tnsvc.WorkoutSession> recentSessions,
    required List<_inypuiwd.CommunityEvent> events,
    required int completedSets,
    required double volumeKg,
  }) : super._(
         profile: profile,
         society: society,
         equipment: equipment,
         readiness: readiness,
         recentSessions: recentSessions,
         events: events,
         completedSets: completedSets,
         volumeKg: volumeKg,
       );

  /// Returns a shallow copy of this [DashboardData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DashboardData copyWith({
    _ir2mn8w1.UserProfile? profile,
    _imb18de8.Society? society,
    List<_isihw7hu.SocietyEquipment>? equipment,
    List<_izoaoiwz.TrainingReadiness>? readiness,
    List<_ic5tnsvc.WorkoutSession>? recentSessions,
    List<_inypuiwd.CommunityEvent>? events,
    int? completedSets,
    double? volumeKg,
  }) {
    return DashboardData(
      profile: profile ?? this.profile.copyWith(),
      society: society ?? this.society.copyWith(),
      equipment:
          equipment ?? this.equipment.map((e0) => e0.copyWith()).toList(),
      readiness:
          readiness ?? this.readiness.map((e0) => e0.copyWith()).toList(),
      recentSessions:
          recentSessions ??
          this.recentSessions.map((e0) => e0.copyWith()).toList(),
      events: events ?? this.events.map((e0) => e0.copyWith()).toList(),
      completedSets: completedSets ?? this.completedSets,
      volumeKg: volumeKg ?? this.volumeKg,
    );
  }
}
