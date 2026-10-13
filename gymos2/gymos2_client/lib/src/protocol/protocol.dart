/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gymos2_client/src/protocol/agent_conversation.dart'
    as _ia02a612;
import 'package:gymos2_client/src/protocol/agent_message.dart' as _i5udvepv;
import 'package:gymos2_client/src/protocol/equipment_catalog.dart' as _iw7yyjnv;
import 'package:gymos2_client/src/protocol/exercise.dart' as _ictweu0g;
import 'package:gymos2_client/src/protocol/exercise_point.dart' as _i8fkiqtq;
import 'package:gymos2_client/src/protocol/form_analysis.dart' as _ionbffjy;
import 'package:gymos2_client/src/protocol/form_metric.dart' as _imrk6sq9;
import 'package:gymos2_client/src/protocol/maintenance_issue.dart' as _iz3dszao;
import 'package:gymos2_client/src/protocol/member_summary.dart' as _ipdotjts;
import 'package:gymos2_client/src/protocol/notification.dart' as _i8lewh08;
import 'package:gymos2_client/src/protocol/readiness_point.dart' as _itxsft30;
import 'package:gymos2_client/src/protocol/society_equipment.dart' as _i6wmn40d;
import 'package:gymos2_client/src/protocol/training_readiness.dart'
    as _ib2poron;
import 'package:gymos2_client/src/protocol/user_profile.dart' as _ioaxpban;
import 'package:gymos2_client/src/protocol/workout_plan.dart' as _i14z15uo;
import 'package:gymos2_client/src/protocol/workout_session.dart' as _ijjiocb7;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'admin_stats.dart' as _iqygks5s;
import 'agent_action.dart' as _i5uera5m;
import 'agent_conversation.dart' as _ixlrnuhd;
import 'agent_message.dart' as _ips3h0rm;
import 'agent_reply.dart' as _igee92io;
import 'community_event.dart' as _inypuiwd;
import 'dashboard_data.dart' as _irt0lj0o;
import 'discover_data.dart' as _i79facbx;
import 'equipment_catalog.dart' as _i4uc3nar;
import 'event_participant.dart' as _i5ye7mcz;
import 'exercise.dart' as _ij3o2h1q;
import 'exercise_alternative.dart' as _iu06qsr2;
import 'exercise_equipment.dart' as _i64c2fru;
import 'exercise_muscle.dart' as _iqbnnuq3;
import 'exercise_point.dart' as _i92yp22h;
import 'external_event_cache.dart' as _imhmmzbr;
import 'form_analysis.dart' as _i1g08zve;
import 'form_metric.dart' as _i85mqlmj;
import 'form_result.dart' as _i4yrss3y;
import 'gym_exception.dart' as _inpsb4xt;
import 'maintenance_issue.dart' as _i4who45y;
import 'member_summary.dart' as _im0mslp7;
import 'muscle_group.dart' as _io46uma7;
import 'notification.dart' as _irt10kca;
import 'plan_detail.dart' as _ijosjbbk;
import 'readiness_point.dart' as _ibymmiv6;
import 'session_detail.dart' as _izqv72qt;
import 'society.dart' as _imb18de8;
import 'society_equipment.dart' as _isihw7hu;
import 'society_membership.dart' as _iolaa93q;
import 'training_readiness.dart' as _izoaoiwz;
import 'user_profile.dart' as _ir2mn8w1;
import 'workout_plan.dart' as _ibmdzv6r;
import 'workout_plan_item.dart' as _ikhy8p9s;
import 'workout_session.dart' as _ic5tnsvc;
import 'workout_set.dart' as _ia8z1hbl;
export 'admin_stats.dart';
export 'agent_action.dart';
export 'agent_conversation.dart';
export 'agent_message.dart';
export 'agent_reply.dart';
export 'community_event.dart';
export 'dashboard_data.dart';
export 'discover_data.dart';
export 'equipment_catalog.dart';
export 'event_participant.dart';
export 'exercise.dart';
export 'exercise_alternative.dart';
export 'exercise_equipment.dart';
export 'exercise_muscle.dart';
export 'exercise_point.dart';
export 'external_event_cache.dart';
export 'form_analysis.dart';
export 'form_metric.dart';
export 'form_result.dart';
export 'gym_exception.dart';
export 'maintenance_issue.dart';
export 'member_summary.dart';
export 'muscle_group.dart';
export 'notification.dart';
export 'plan_detail.dart';
export 'readiness_point.dart';
export 'session_detail.dart';
export 'society.dart';
export 'society_equipment.dart';
export 'society_membership.dart';
export 'training_readiness.dart';
export 'user_profile.dart';
export 'workout_plan.dart';
export 'workout_plan_item.dart';
export 'workout_session.dart';
export 'workout_set.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iqygks5s.AdminStats) {
      return _iqygks5s.AdminStats.fromJson(data) as T;
    }
    if (t == _i5uera5m.AgentAction) {
      return _i5uera5m.AgentAction.fromJson(data) as T;
    }
    if (t == _ixlrnuhd.AgentConversation) {
      return _ixlrnuhd.AgentConversation.fromJson(data) as T;
    }
    if (t == _ips3h0rm.AgentMessage) {
      return _ips3h0rm.AgentMessage.fromJson(data) as T;
    }
    if (t == _igee92io.AgentReply) {
      return _igee92io.AgentReply.fromJson(data) as T;
    }
    if (t == _inypuiwd.CommunityEvent) {
      return _inypuiwd.CommunityEvent.fromJson(data) as T;
    }
    if (t == _irt0lj0o.DashboardData) {
      return _irt0lj0o.DashboardData.fromJson(data) as T;
    }
    if (t == _i79facbx.DiscoverData) {
      return _i79facbx.DiscoverData.fromJson(data) as T;
    }
    if (t == _i4uc3nar.EquipmentCatalog) {
      return _i4uc3nar.EquipmentCatalog.fromJson(data) as T;
    }
    if (t == _i5ye7mcz.EventParticipant) {
      return _i5ye7mcz.EventParticipant.fromJson(data) as T;
    }
    if (t == _ij3o2h1q.Exercise) {
      return _ij3o2h1q.Exercise.fromJson(data) as T;
    }
    if (t == _iu06qsr2.ExerciseAlternative) {
      return _iu06qsr2.ExerciseAlternative.fromJson(data) as T;
    }
    if (t == _i64c2fru.ExerciseEquipment) {
      return _i64c2fru.ExerciseEquipment.fromJson(data) as T;
    }
    if (t == _iqbnnuq3.ExerciseMuscle) {
      return _iqbnnuq3.ExerciseMuscle.fromJson(data) as T;
    }
    if (t == _i92yp22h.ExercisePoint) {
      return _i92yp22h.ExercisePoint.fromJson(data) as T;
    }
    if (t == _imhmmzbr.ExternalEventCache) {
      return _imhmmzbr.ExternalEventCache.fromJson(data) as T;
    }
    if (t == _i1g08zve.FormAnalysis) {
      return _i1g08zve.FormAnalysis.fromJson(data) as T;
    }
    if (t == _i85mqlmj.FormMetric) {
      return _i85mqlmj.FormMetric.fromJson(data) as T;
    }
    if (t == _i4yrss3y.FormResult) {
      return _i4yrss3y.FormResult.fromJson(data) as T;
    }
    if (t == _inpsb4xt.GymException) {
      return _inpsb4xt.GymException.fromJson(data) as T;
    }
    if (t == _i4who45y.MaintenanceIssue) {
      return _i4who45y.MaintenanceIssue.fromJson(data) as T;
    }
    if (t == _im0mslp7.MemberSummary) {
      return _im0mslp7.MemberSummary.fromJson(data) as T;
    }
    if (t == _io46uma7.MuscleGroup) {
      return _io46uma7.MuscleGroup.fromJson(data) as T;
    }
    if (t == _irt10kca.Notification) {
      return _irt10kca.Notification.fromJson(data) as T;
    }
    if (t == _ijosjbbk.PlanDetail) {
      return _ijosjbbk.PlanDetail.fromJson(data) as T;
    }
    if (t == _ibymmiv6.ReadinessPoint) {
      return _ibymmiv6.ReadinessPoint.fromJson(data) as T;
    }
    if (t == _izqv72qt.SessionDetail) {
      return _izqv72qt.SessionDetail.fromJson(data) as T;
    }
    if (t == _imb18de8.Society) {
      return _imb18de8.Society.fromJson(data) as T;
    }
    if (t == _isihw7hu.SocietyEquipment) {
      return _isihw7hu.SocietyEquipment.fromJson(data) as T;
    }
    if (t == _iolaa93q.SocietyMembership) {
      return _iolaa93q.SocietyMembership.fromJson(data) as T;
    }
    if (t == _izoaoiwz.TrainingReadiness) {
      return _izoaoiwz.TrainingReadiness.fromJson(data) as T;
    }
    if (t == _ir2mn8w1.UserProfile) {
      return _ir2mn8w1.UserProfile.fromJson(data) as T;
    }
    if (t == _ibmdzv6r.WorkoutPlan) {
      return _ibmdzv6r.WorkoutPlan.fromJson(data) as T;
    }
    if (t == _ikhy8p9s.WorkoutPlanItem) {
      return _ikhy8p9s.WorkoutPlanItem.fromJson(data) as T;
    }
    if (t == _ic5tnsvc.WorkoutSession) {
      return _ic5tnsvc.WorkoutSession.fromJson(data) as T;
    }
    if (t == _ia8z1hbl.WorkoutSet) {
      return _ia8z1hbl.WorkoutSet.fromJson(data) as T;
    }
    if (t == _isc.getType<_iqygks5s.AdminStats?>()) {
      return (data != null ? _iqygks5s.AdminStats.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i5uera5m.AgentAction?>()) {
      return (data != null ? _i5uera5m.AgentAction.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixlrnuhd.AgentConversation?>()) {
      return (data != null ? _ixlrnuhd.AgentConversation.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ips3h0rm.AgentMessage?>()) {
      return (data != null ? _ips3h0rm.AgentMessage.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igee92io.AgentReply?>()) {
      return (data != null ? _igee92io.AgentReply.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_inypuiwd.CommunityEvent?>()) {
      return (data != null ? _inypuiwd.CommunityEvent.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_irt0lj0o.DashboardData?>()) {
      return (data != null ? _irt0lj0o.DashboardData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i79facbx.DiscoverData?>()) {
      return (data != null ? _i79facbx.DiscoverData.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i4uc3nar.EquipmentCatalog?>()) {
      return (data != null ? _i4uc3nar.EquipmentCatalog.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i5ye7mcz.EventParticipant?>()) {
      return (data != null ? _i5ye7mcz.EventParticipant.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ij3o2h1q.Exercise?>()) {
      return (data != null ? _ij3o2h1q.Exercise.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iu06qsr2.ExerciseAlternative?>()) {
      return (data != null
              ? _iu06qsr2.ExerciseAlternative.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i64c2fru.ExerciseEquipment?>()) {
      return (data != null ? _i64c2fru.ExerciseEquipment.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iqbnnuq3.ExerciseMuscle?>()) {
      return (data != null ? _iqbnnuq3.ExerciseMuscle.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i92yp22h.ExercisePoint?>()) {
      return (data != null ? _i92yp22h.ExercisePoint.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_imhmmzbr.ExternalEventCache?>()) {
      return (data != null ? _imhmmzbr.ExternalEventCache.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1g08zve.FormAnalysis?>()) {
      return (data != null ? _i1g08zve.FormAnalysis.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i85mqlmj.FormMetric?>()) {
      return (data != null ? _i85mqlmj.FormMetric.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i4yrss3y.FormResult?>()) {
      return (data != null ? _i4yrss3y.FormResult.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_inpsb4xt.GymException?>()) {
      return (data != null ? _inpsb4xt.GymException.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i4who45y.MaintenanceIssue?>()) {
      return (data != null ? _i4who45y.MaintenanceIssue.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_im0mslp7.MemberSummary?>()) {
      return (data != null ? _im0mslp7.MemberSummary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_io46uma7.MuscleGroup?>()) {
      return (data != null ? _io46uma7.MuscleGroup.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_irt10kca.Notification?>()) {
      return (data != null ? _irt10kca.Notification.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijosjbbk.PlanDetail?>()) {
      return (data != null ? _ijosjbbk.PlanDetail.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ibymmiv6.ReadinessPoint?>()) {
      return (data != null ? _ibymmiv6.ReadinessPoint.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izqv72qt.SessionDetail?>()) {
      return (data != null ? _izqv72qt.SessionDetail.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_imb18de8.Society?>()) {
      return (data != null ? _imb18de8.Society.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isihw7hu.SocietyEquipment?>()) {
      return (data != null ? _isihw7hu.SocietyEquipment.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iolaa93q.SocietyMembership?>()) {
      return (data != null ? _iolaa93q.SocietyMembership.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izoaoiwz.TrainingReadiness?>()) {
      return (data != null ? _izoaoiwz.TrainingReadiness.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ir2mn8w1.UserProfile?>()) {
      return (data != null ? _ir2mn8w1.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ibmdzv6r.WorkoutPlan?>()) {
      return (data != null ? _ibmdzv6r.WorkoutPlan.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ikhy8p9s.WorkoutPlanItem?>()) {
      return (data != null ? _ikhy8p9s.WorkoutPlanItem.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ic5tnsvc.WorkoutSession?>()) {
      return (data != null ? _ic5tnsvc.WorkoutSession.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ia8z1hbl.WorkoutSet?>()) {
      return (data != null ? _ia8z1hbl.WorkoutSet.fromJson(data) : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i5uera5m.AgentAction>) {
      return (data as List)
              .map((e) => deserialize<_i5uera5m.AgentAction>(e))
              .toList()
          as T;
    }
    if (t == List<_isihw7hu.SocietyEquipment>) {
      return (data as List)
              .map((e) => deserialize<_isihw7hu.SocietyEquipment>(e))
              .toList()
          as T;
    }
    if (t == List<_izoaoiwz.TrainingReadiness>) {
      return (data as List)
              .map((e) => deserialize<_izoaoiwz.TrainingReadiness>(e))
              .toList()
          as T;
    }
    if (t == List<_ic5tnsvc.WorkoutSession>) {
      return (data as List)
              .map((e) => deserialize<_ic5tnsvc.WorkoutSession>(e))
              .toList()
          as T;
    }
    if (t == List<_inypuiwd.CommunityEvent>) {
      return (data as List)
              .map((e) => deserialize<_inypuiwd.CommunityEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_imhmmzbr.ExternalEventCache>) {
      return (data as List)
              .map((e) => deserialize<_imhmmzbr.ExternalEventCache>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _isc.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == Map<int, int>) {
      return Map.fromEntries(
            (data as List).map(
              (e) =>
                  MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v'])),
            ),
          )
          as T;
    }
    if (t == _isc.getType<Map<int, int>?>()) {
      return (data != null
              ? Map.fromEntries(
                  (data as List).map(
                    (e) => MapEntry(
                      deserialize<int>(e['k']),
                      deserialize<int>(e['v']),
                    ),
                  ),
                )
              : null)
          as T;
    }
    if (t == List<_i85mqlmj.FormMetric>) {
      return (data as List)
              .map((e) => deserialize<_i85mqlmj.FormMetric>(e))
              .toList()
          as T;
    }
    if (t == List<_ikhy8p9s.WorkoutPlanItem>) {
      return (data as List)
              .map((e) => deserialize<_ikhy8p9s.WorkoutPlanItem>(e))
              .toList()
          as T;
    }
    if (t == List<_ij3o2h1q.Exercise>) {
      return (data as List)
              .map((e) => deserialize<_ij3o2h1q.Exercise>(e))
              .toList()
          as T;
    }
    if (t == List<_ia8z1hbl.WorkoutSet>) {
      return (data as List)
              .map((e) => deserialize<_ia8z1hbl.WorkoutSet>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ia8z1hbl.WorkoutSet>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ia8z1hbl.WorkoutSet>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ipdotjts.MemberSummary>) {
      return (data as List)
              .map((e) => deserialize<_ipdotjts.MemberSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_ia02a612.AgentConversation>) {
      return (data as List)
              .map((e) => deserialize<_ia02a612.AgentConversation>(e))
              .toList()
          as T;
    }
    if (t == List<_i5udvepv.AgentMessage>) {
      return (data as List)
              .map((e) => deserialize<_i5udvepv.AgentMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_i6wmn40d.SocietyEquipment>) {
      return (data as List)
              .map((e) => deserialize<_i6wmn40d.SocietyEquipment>(e))
              .toList()
          as T;
    }
    if (t == List<_iw7yyjnv.EquipmentCatalog>) {
      return (data as List)
              .map((e) => deserialize<_iw7yyjnv.EquipmentCatalog>(e))
              .toList()
          as T;
    }
    if (t == List<_iz3dszao.MaintenanceIssue>) {
      return (data as List)
              .map((e) => deserialize<_iz3dszao.MaintenanceIssue>(e))
              .toList()
          as T;
    }
    if (t == List<_ictweu0g.Exercise>) {
      return (data as List)
              .map((e) => deserialize<_ictweu0g.Exercise>(e))
              .toList()
          as T;
    }
    if (t == List<_imrk6sq9.FormMetric>) {
      return (data as List)
              .map((e) => deserialize<_imrk6sq9.FormMetric>(e))
              .toList()
          as T;
    }
    if (t == List<_ionbffjy.FormAnalysis>) {
      return (data as List)
              .map((e) => deserialize<_ionbffjy.FormAnalysis>(e))
              .toList()
          as T;
    }
    if (t == List<_i8lewh08.Notification>) {
      return (data as List)
              .map((e) => deserialize<_i8lewh08.Notification>(e))
              .toList()
          as T;
    }
    if (t == List<_ioaxpban.UserProfile>) {
      return (data as List)
              .map((e) => deserialize<_ioaxpban.UserProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i14z15uo.WorkoutPlan>) {
      return (data as List)
              .map((e) => deserialize<_i14z15uo.WorkoutPlan>(e))
              .toList()
          as T;
    }
    if (t == List<_ijjiocb7.WorkoutSession>) {
      return (data as List)
              .map((e) => deserialize<_ijjiocb7.WorkoutSession>(e))
              .toList()
          as T;
    }
    if (t == List<_ib2poron.TrainingReadiness>) {
      return (data as List)
              .map((e) => deserialize<_ib2poron.TrainingReadiness>(e))
              .toList()
          as T;
    }
    if (t == List<_i8fkiqtq.ExercisePoint>) {
      return (data as List)
              .map((e) => deserialize<_i8fkiqtq.ExercisePoint>(e))
              .toList()
          as T;
    }
    if (t == List<_itxsft30.ReadinessPoint>) {
      return (data as List)
              .map((e) => deserialize<_itxsft30.ReadinessPoint>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iqygks5s.AdminStats => 'AdminStats',
      _i5uera5m.AgentAction => 'AgentAction',
      _ixlrnuhd.AgentConversation => 'AgentConversation',
      _ips3h0rm.AgentMessage => 'AgentMessage',
      _igee92io.AgentReply => 'AgentReply',
      _inypuiwd.CommunityEvent => 'CommunityEvent',
      _irt0lj0o.DashboardData => 'DashboardData',
      _i79facbx.DiscoverData => 'DiscoverData',
      _i4uc3nar.EquipmentCatalog => 'EquipmentCatalog',
      _i5ye7mcz.EventParticipant => 'EventParticipant',
      _ij3o2h1q.Exercise => 'Exercise',
      _iu06qsr2.ExerciseAlternative => 'ExerciseAlternative',
      _i64c2fru.ExerciseEquipment => 'ExerciseEquipment',
      _iqbnnuq3.ExerciseMuscle => 'ExerciseMuscle',
      _i92yp22h.ExercisePoint => 'ExercisePoint',
      _imhmmzbr.ExternalEventCache => 'ExternalEventCache',
      _i1g08zve.FormAnalysis => 'FormAnalysis',
      _i85mqlmj.FormMetric => 'FormMetric',
      _i4yrss3y.FormResult => 'FormResult',
      _inpsb4xt.GymException => 'GymException',
      _i4who45y.MaintenanceIssue => 'MaintenanceIssue',
      _im0mslp7.MemberSummary => 'MemberSummary',
      _io46uma7.MuscleGroup => 'MuscleGroup',
      _irt10kca.Notification => 'Notification',
      _ijosjbbk.PlanDetail => 'PlanDetail',
      _ibymmiv6.ReadinessPoint => 'ReadinessPoint',
      _izqv72qt.SessionDetail => 'SessionDetail',
      _imb18de8.Society => 'Society',
      _isihw7hu.SocietyEquipment => 'SocietyEquipment',
      _iolaa93q.SocietyMembership => 'SocietyMembership',
      _izoaoiwz.TrainingReadiness => 'TrainingReadiness',
      _ir2mn8w1.UserProfile => 'UserProfile',
      _ibmdzv6r.WorkoutPlan => 'WorkoutPlan',
      _ikhy8p9s.WorkoutPlanItem => 'WorkoutPlanItem',
      _ic5tnsvc.WorkoutSession => 'WorkoutSession',
      _ia8z1hbl.WorkoutSet => 'WorkoutSet',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('gymos2.', '');
    }

    switch (data) {
      case _iqygks5s.AdminStats():
        return 'AdminStats';
      case _i5uera5m.AgentAction():
        return 'AgentAction';
      case _ixlrnuhd.AgentConversation():
        return 'AgentConversation';
      case _ips3h0rm.AgentMessage():
        return 'AgentMessage';
      case _igee92io.AgentReply():
        return 'AgentReply';
      case _inypuiwd.CommunityEvent():
        return 'CommunityEvent';
      case _irt0lj0o.DashboardData():
        return 'DashboardData';
      case _i79facbx.DiscoverData():
        return 'DiscoverData';
      case _i4uc3nar.EquipmentCatalog():
        return 'EquipmentCatalog';
      case _i5ye7mcz.EventParticipant():
        return 'EventParticipant';
      case _ij3o2h1q.Exercise():
        return 'Exercise';
      case _iu06qsr2.ExerciseAlternative():
        return 'ExerciseAlternative';
      case _i64c2fru.ExerciseEquipment():
        return 'ExerciseEquipment';
      case _iqbnnuq3.ExerciseMuscle():
        return 'ExerciseMuscle';
      case _i92yp22h.ExercisePoint():
        return 'ExercisePoint';
      case _imhmmzbr.ExternalEventCache():
        return 'ExternalEventCache';
      case _i1g08zve.FormAnalysis():
        return 'FormAnalysis';
      case _i85mqlmj.FormMetric():
        return 'FormMetric';
      case _i4yrss3y.FormResult():
        return 'FormResult';
      case _inpsb4xt.GymException():
        return 'GymException';
      case _i4who45y.MaintenanceIssue():
        return 'MaintenanceIssue';
      case _im0mslp7.MemberSummary():
        return 'MemberSummary';
      case _io46uma7.MuscleGroup():
        return 'MuscleGroup';
      case _irt10kca.Notification():
        return 'Notification';
      case _ijosjbbk.PlanDetail():
        return 'PlanDetail';
      case _ibymmiv6.ReadinessPoint():
        return 'ReadinessPoint';
      case _izqv72qt.SessionDetail():
        return 'SessionDetail';
      case _imb18de8.Society():
        return 'Society';
      case _isihw7hu.SocietyEquipment():
        return 'SocietyEquipment';
      case _iolaa93q.SocietyMembership():
        return 'SocietyMembership';
      case _izoaoiwz.TrainingReadiness():
        return 'TrainingReadiness';
      case _ir2mn8w1.UserProfile():
        return 'UserProfile';
      case _ibmdzv6r.WorkoutPlan():
        return 'WorkoutPlan';
      case _ikhy8p9s.WorkoutPlanItem():
        return 'WorkoutPlanItem';
      case _ic5tnsvc.WorkoutSession():
        return 'WorkoutSession';
      case _ia8z1hbl.WorkoutSet():
        return 'WorkoutSet';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AdminStats') {
      return deserialize<_iqygks5s.AdminStats>(data['data']);
    }
    if (dataClassName == 'AgentAction') {
      return deserialize<_i5uera5m.AgentAction>(data['data']);
    }
    if (dataClassName == 'AgentConversation') {
      return deserialize<_ixlrnuhd.AgentConversation>(data['data']);
    }
    if (dataClassName == 'AgentMessage') {
      return deserialize<_ips3h0rm.AgentMessage>(data['data']);
    }
    if (dataClassName == 'AgentReply') {
      return deserialize<_igee92io.AgentReply>(data['data']);
    }
    if (dataClassName == 'CommunityEvent') {
      return deserialize<_inypuiwd.CommunityEvent>(data['data']);
    }
    if (dataClassName == 'DashboardData') {
      return deserialize<_irt0lj0o.DashboardData>(data['data']);
    }
    if (dataClassName == 'DiscoverData') {
      return deserialize<_i79facbx.DiscoverData>(data['data']);
    }
    if (dataClassName == 'EquipmentCatalog') {
      return deserialize<_i4uc3nar.EquipmentCatalog>(data['data']);
    }
    if (dataClassName == 'EventParticipant') {
      return deserialize<_i5ye7mcz.EventParticipant>(data['data']);
    }
    if (dataClassName == 'Exercise') {
      return deserialize<_ij3o2h1q.Exercise>(data['data']);
    }
    if (dataClassName == 'ExerciseAlternative') {
      return deserialize<_iu06qsr2.ExerciseAlternative>(data['data']);
    }
    if (dataClassName == 'ExerciseEquipment') {
      return deserialize<_i64c2fru.ExerciseEquipment>(data['data']);
    }
    if (dataClassName == 'ExerciseMuscle') {
      return deserialize<_iqbnnuq3.ExerciseMuscle>(data['data']);
    }
    if (dataClassName == 'ExercisePoint') {
      return deserialize<_i92yp22h.ExercisePoint>(data['data']);
    }
    if (dataClassName == 'ExternalEventCache') {
      return deserialize<_imhmmzbr.ExternalEventCache>(data['data']);
    }
    if (dataClassName == 'FormAnalysis') {
      return deserialize<_i1g08zve.FormAnalysis>(data['data']);
    }
    if (dataClassName == 'FormMetric') {
      return deserialize<_i85mqlmj.FormMetric>(data['data']);
    }
    if (dataClassName == 'FormResult') {
      return deserialize<_i4yrss3y.FormResult>(data['data']);
    }
    if (dataClassName == 'GymException') {
      return deserialize<_inpsb4xt.GymException>(data['data']);
    }
    if (dataClassName == 'MaintenanceIssue') {
      return deserialize<_i4who45y.MaintenanceIssue>(data['data']);
    }
    if (dataClassName == 'MemberSummary') {
      return deserialize<_im0mslp7.MemberSummary>(data['data']);
    }
    if (dataClassName == 'MuscleGroup') {
      return deserialize<_io46uma7.MuscleGroup>(data['data']);
    }
    if (dataClassName == 'Notification') {
      return deserialize<_irt10kca.Notification>(data['data']);
    }
    if (dataClassName == 'PlanDetail') {
      return deserialize<_ijosjbbk.PlanDetail>(data['data']);
    }
    if (dataClassName == 'ReadinessPoint') {
      return deserialize<_ibymmiv6.ReadinessPoint>(data['data']);
    }
    if (dataClassName == 'SessionDetail') {
      return deserialize<_izqv72qt.SessionDetail>(data['data']);
    }
    if (dataClassName == 'Society') {
      return deserialize<_imb18de8.Society>(data['data']);
    }
    if (dataClassName == 'SocietyEquipment') {
      return deserialize<_isihw7hu.SocietyEquipment>(data['data']);
    }
    if (dataClassName == 'SocietyMembership') {
      return deserialize<_iolaa93q.SocietyMembership>(data['data']);
    }
    if (dataClassName == 'TrainingReadiness') {
      return deserialize<_izoaoiwz.TrainingReadiness>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_ir2mn8w1.UserProfile>(data['data']);
    }
    if (dataClassName == 'WorkoutPlan') {
      return deserialize<_ibmdzv6r.WorkoutPlan>(data['data']);
    }
    if (dataClassName == 'WorkoutPlanItem') {
      return deserialize<_ikhy8p9s.WorkoutPlanItem>(data['data']);
    }
    if (dataClassName == 'WorkoutSession') {
      return deserialize<_ic5tnsvc.WorkoutSession>(data['data']);
    }
    if (dataClassName == 'WorkoutSet') {
      return deserialize<_ia8z1hbl.WorkoutSet>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('gymos2', this);
    _iacc.Protocol().registerHostProtocol('gymos2', this);
  }

  @override
  String getModuleName() => 'gymos2';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
