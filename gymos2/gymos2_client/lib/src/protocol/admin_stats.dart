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
import 'society.dart' as _imb18de8;

abstract class AdminStats
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminStats._({
    required this.society,
    required this.memberCount,
    required this.activeMembers,
    required this.adminCount,
    required this.equipmentTotal,
    required this.equipmentAvailable,
    required this.equipmentMaintenance,
    required this.equipmentUnavailable,
    required this.openIssues,
    required this.inProgressIssues,
    required this.resolvedIssues30d,
    required this.highSeverityOpen,
    required this.upcomingEvents,
    required this.eventParticipants,
    required this.workoutsThisWeek,
    required this.activeTrainersThisWeek,
    required this.dailyWorkouts,
  });

  factory AdminStats({
    required _imb18de8.Society society,
    required int memberCount,
    required int activeMembers,
    required int adminCount,
    required int equipmentTotal,
    required int equipmentAvailable,
    required int equipmentMaintenance,
    required int equipmentUnavailable,
    required int openIssues,
    required int inProgressIssues,
    required int resolvedIssues30d,
    required int highSeverityOpen,
    required int upcomingEvents,
    required int eventParticipants,
    required int workoutsThisWeek,
    required int activeTrainersThisWeek,
    required List<int> dailyWorkouts,
  }) = _AdminStatsImpl;

  factory AdminStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminStats(
      society: _ihoj8lp7.Protocol().deserialize<_imb18de8.Society>(
        jsonSerialization['society'],
      ),
      memberCount: jsonSerialization['memberCount'] as int,
      activeMembers: jsonSerialization['activeMembers'] as int,
      adminCount: jsonSerialization['adminCount'] as int,
      equipmentTotal: jsonSerialization['equipmentTotal'] as int,
      equipmentAvailable: jsonSerialization['equipmentAvailable'] as int,
      equipmentMaintenance: jsonSerialization['equipmentMaintenance'] as int,
      equipmentUnavailable: jsonSerialization['equipmentUnavailable'] as int,
      openIssues: jsonSerialization['openIssues'] as int,
      inProgressIssues: jsonSerialization['inProgressIssues'] as int,
      resolvedIssues30d: jsonSerialization['resolvedIssues30d'] as int,
      highSeverityOpen: jsonSerialization['highSeverityOpen'] as int,
      upcomingEvents: jsonSerialization['upcomingEvents'] as int,
      eventParticipants: jsonSerialization['eventParticipants'] as int,
      workoutsThisWeek: jsonSerialization['workoutsThisWeek'] as int,
      activeTrainersThisWeek:
          jsonSerialization['activeTrainersThisWeek'] as int,
      dailyWorkouts: _ihoj8lp7.Protocol().deserialize<List<int>>(
        jsonSerialization['dailyWorkouts'],
      ),
    );
  }

  _imb18de8.Society society;

  int memberCount;

  int activeMembers;

  int adminCount;

  int equipmentTotal;

  int equipmentAvailable;

  int equipmentMaintenance;

  int equipmentUnavailable;

  int openIssues;

  int inProgressIssues;

  int resolvedIssues30d;

  int highSeverityOpen;

  int upcomingEvents;

  int eventParticipants;

  int workoutsThisWeek;

  int activeTrainersThisWeek;

  List<int> dailyWorkouts;

  /// Returns a shallow copy of this [AdminStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminStats copyWith({
    _imb18de8.Society? society,
    int? memberCount,
    int? activeMembers,
    int? adminCount,
    int? equipmentTotal,
    int? equipmentAvailable,
    int? equipmentMaintenance,
    int? equipmentUnavailable,
    int? openIssues,
    int? inProgressIssues,
    int? resolvedIssues30d,
    int? highSeverityOpen,
    int? upcomingEvents,
    int? eventParticipants,
    int? workoutsThisWeek,
    int? activeTrainersThisWeek,
    List<int>? dailyWorkouts,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminStats',
      'society': society.toJson(),
      'memberCount': memberCount,
      'activeMembers': activeMembers,
      'adminCount': adminCount,
      'equipmentTotal': equipmentTotal,
      'equipmentAvailable': equipmentAvailable,
      'equipmentMaintenance': equipmentMaintenance,
      'equipmentUnavailable': equipmentUnavailable,
      'openIssues': openIssues,
      'inProgressIssues': inProgressIssues,
      'resolvedIssues30d': resolvedIssues30d,
      'highSeverityOpen': highSeverityOpen,
      'upcomingEvents': upcomingEvents,
      'eventParticipants': eventParticipants,
      'workoutsThisWeek': workoutsThisWeek,
      'activeTrainersThisWeek': activeTrainersThisWeek,
      'dailyWorkouts': dailyWorkouts.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminStats',
      'society': society.toJsonForProtocol(),
      'memberCount': memberCount,
      'activeMembers': activeMembers,
      'adminCount': adminCount,
      'equipmentTotal': equipmentTotal,
      'equipmentAvailable': equipmentAvailable,
      'equipmentMaintenance': equipmentMaintenance,
      'equipmentUnavailable': equipmentUnavailable,
      'openIssues': openIssues,
      'inProgressIssues': inProgressIssues,
      'resolvedIssues30d': resolvedIssues30d,
      'highSeverityOpen': highSeverityOpen,
      'upcomingEvents': upcomingEvents,
      'eventParticipants': eventParticipants,
      'workoutsThisWeek': workoutsThisWeek,
      'activeTrainersThisWeek': activeTrainersThisWeek,
      'dailyWorkouts': dailyWorkouts.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AdminStatsImpl extends AdminStats {
  _AdminStatsImpl({
    required _imb18de8.Society society,
    required int memberCount,
    required int activeMembers,
    required int adminCount,
    required int equipmentTotal,
    required int equipmentAvailable,
    required int equipmentMaintenance,
    required int equipmentUnavailable,
    required int openIssues,
    required int inProgressIssues,
    required int resolvedIssues30d,
    required int highSeverityOpen,
    required int upcomingEvents,
    required int eventParticipants,
    required int workoutsThisWeek,
    required int activeTrainersThisWeek,
    required List<int> dailyWorkouts,
  }) : super._(
         society: society,
         memberCount: memberCount,
         activeMembers: activeMembers,
         adminCount: adminCount,
         equipmentTotal: equipmentTotal,
         equipmentAvailable: equipmentAvailable,
         equipmentMaintenance: equipmentMaintenance,
         equipmentUnavailable: equipmentUnavailable,
         openIssues: openIssues,
         inProgressIssues: inProgressIssues,
         resolvedIssues30d: resolvedIssues30d,
         highSeverityOpen: highSeverityOpen,
         upcomingEvents: upcomingEvents,
         eventParticipants: eventParticipants,
         workoutsThisWeek: workoutsThisWeek,
         activeTrainersThisWeek: activeTrainersThisWeek,
         dailyWorkouts: dailyWorkouts,
       );

  /// Returns a shallow copy of this [AdminStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminStats copyWith({
    _imb18de8.Society? society,
    int? memberCount,
    int? activeMembers,
    int? adminCount,
    int? equipmentTotal,
    int? equipmentAvailable,
    int? equipmentMaintenance,
    int? equipmentUnavailable,
    int? openIssues,
    int? inProgressIssues,
    int? resolvedIssues30d,
    int? highSeverityOpen,
    int? upcomingEvents,
    int? eventParticipants,
    int? workoutsThisWeek,
    int? activeTrainersThisWeek,
    List<int>? dailyWorkouts,
  }) {
    return AdminStats(
      society: society ?? this.society.copyWith(),
      memberCount: memberCount ?? this.memberCount,
      activeMembers: activeMembers ?? this.activeMembers,
      adminCount: adminCount ?? this.adminCount,
      equipmentTotal: equipmentTotal ?? this.equipmentTotal,
      equipmentAvailable: equipmentAvailable ?? this.equipmentAvailable,
      equipmentMaintenance: equipmentMaintenance ?? this.equipmentMaintenance,
      equipmentUnavailable: equipmentUnavailable ?? this.equipmentUnavailable,
      openIssues: openIssues ?? this.openIssues,
      inProgressIssues: inProgressIssues ?? this.inProgressIssues,
      resolvedIssues30d: resolvedIssues30d ?? this.resolvedIssues30d,
      highSeverityOpen: highSeverityOpen ?? this.highSeverityOpen,
      upcomingEvents: upcomingEvents ?? this.upcomingEvents,
      eventParticipants: eventParticipants ?? this.eventParticipants,
      workoutsThisWeek: workoutsThisWeek ?? this.workoutsThisWeek,
      activeTrainersThisWeek:
          activeTrainersThisWeek ?? this.activeTrainersThisWeek,
      dailyWorkouts:
          dailyWorkouts ?? this.dailyWorkouts.map((e0) => e0).toList(),
    );
  }
}
