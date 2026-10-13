from pathlib import Path
base=Path('gymos2/gymos2_server/lib/src')
def put(p,s):
 f=base/p; f.parent.mkdir(parents=True,exist_ok=True); f.write_text(s)
put('endpoints/equipment_endpoint.dart','''import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/access.dart';
class EquipmentEndpoint extends Endpoint {
 @override bool get requireLogin=>true;
 Future<List<SocietyEquipment>> list(Session s) async { final p=await Access.profile(s); return SocietyEquipment.db.find(s,where:(t)=>t.societyId.equals(p.societyId),orderBy:(t)=>t.label); }
 Future<List<EquipmentCatalog>> catalog(Session s) async { await Access.profile(s); return EquipmentCatalog.db.find(s); }
 Future<SocietyEquipment> save(Session s,int? id,int catalogId,String label,int quantity,String status,String location) async {
  final p=await Access.profile(s,admin:true); if(quantity<0||quantity>100||!['available','maintenance','unavailable'].contains(status))throw GymException(message:'Invalid equipment values.');
  if(await EquipmentCatalog.db.findById(s,catalogId)==null)throw GymException(message:'Equipment type not found.');
  final old=id==null?null:await SocietyEquipment.db.findById(s,id); if(id!=null&&(old==null||old.societyId!=p.societyId))throw GymException(message:'Equipment not found.');
  final row=SocietyEquipment(id:id,societyId:p.societyId,equipmentId:catalogId,label:Access.text(label,max:80),quantity:quantity,status:status,locationLabel:Access.text(location,max:100),lastServicedAt:old?.lastServicedAt);
  final result=id==null?await SocietyEquipment.db.insertRow(s,row):await SocietyEquipment.db.updateRow(s,row); s.messages.postMessage('equipment-${p.societyId}',result); return result;
 }
 Stream<SocietyEquipment> watch(Session s) async* { final p=await Access.profile(s); yield* s.messages.createStream<SocietyEquipment>('equipment-${p.societyId}'); }
 Future<MaintenanceIssue> report(Session s,int equipmentId,String title,String description,String severity) async {
  final p=await Access.profile(s); final e=await SocietyEquipment.db.findById(s,equipmentId); if(e==null||e.societyId!=p.societyId)throw GymException(message:'Equipment not found.'); if(!['low','medium','high'].contains(severity))throw GymException(message:'Invalid severity.');
  return MaintenanceIssue.db.insertRow(s,MaintenanceIssue(societyId:p.societyId,societyEquipmentId:equipmentId,reportedBy:p.id!,title:Access.text(title,max:100),description:Access.text(description),severity:severity,status:'open',createdAt:DateTime.now().toUtc()));
 }
 Future<List<MaintenanceIssue>> issues(Session s) async { final p=await Access.profile(s); return MaintenanceIssue.db.find(s,where:(t)=>t.societyId.equals(p.societyId),orderBy:(t)=>t.createdAt,orderDescending:true); }
 Future<MaintenanceIssue> updateIssue(Session s,int id,String status) async {
  final p=await Access.profile(s,admin:true); final issue=await MaintenanceIssue.db.findById(s,id); if(issue==null||issue.societyId!=p.societyId)throw GymException(message:'Issue not found.');
  if(!['open','in progress','resolved'].contains(status))throw GymException(message:'Invalid status.');
  issue..status=status..resolvedAt=status=='resolved'?DateTime.now().toUtc():null; await MaintenanceIssue.db.updateRow(s,issue);
  final e=(await SocietyEquipment.db.findById(s,issue.societyEquipmentId))!;
  final unresolved=await MaintenanceIssue.db.count(s,where:(t)=>t.societyEquipmentId.equals(e.id!)&t.status.notEquals('resolved'));
  e.status=unresolved==0?'available':'maintenance'; if(unresolved==0)e.lastServicedAt=DateTime.now().toUtc(); await SocietyEquipment.db.updateRow(s,e); s.messages.postMessage('equipment-${p.societyId}',e); return issue;
 }
}
''')
put('endpoints/exercise_endpoint.dart','''import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/access.dart';
class ExerciseEndpoint extends Endpoint {
 @override bool get requireLogin=>true;
 Future<List<Exercise>> list(Session s,String query) async { await Access.profile(s); final all=await Exercise.db.find(s,where:(t)=>t.isActive.equals(true)); return all.where((e)=>e.name.toLowerCase().contains(query.toLowerCase())).toList(); }
}
''')
put('endpoints/event_endpoint.dart','''import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/access.dart';
class EventEndpoint extends Endpoint {
 @override bool get requireLogin=>true;
 Future<DiscoverData> discover(Session s,String city,String category) async {
  final p=await Access.profile(s); final now=DateTime.now().toUtc();
  final events=await CommunityEvent.db.find(s,where:(t)=>t.societyId.equals(p.societyId)&t.status.equals('scheduled')&(t.endsAt>now),orderBy:(t)=>t.startsAt);
  final joined=await EventParticipant.db.find(s,where:(t)=>t.userId.equals(p.id!)&t.status.equals('joined'));
  final cache=await ExternalEventCache.db.find(s,where:(t)=>t.queryKey.equals(city.toLowerCase().trim())&(t.startsAt>now));
  return DiscoverData(community:events.where((e)=>category=='all'||e.category==category).toList(),externalEvents:cache.where((e)=>category=='all'||e.category==category).toList(),joinedEventIds:joined.map((e)=>e.eventId).toList(),providerStatus:cache.isEmpty?'AllEvents is not connected. Community events are available.':'Cached AllEvents results; live refresh is not configured.');
 }
 Future<CommunityEvent> create(Session s,String title,String description,String category,DateTime start,DateTime end,double latitude,double longitude,String venue,int capacity) async {
  final p=await Access.profile(s,admin:true); if(!latitude.isFinite||!longitude.isFinite||latitude.abs()>90||longitude.abs()>180||capacity<1||capacity>10000||!end.isAfter(start)||start.isBefore(DateTime.now())||!['running','cycling','yoga','fitness','sports'].contains(category))throw GymException(message:'Check location, dates, category, and capacity.');
  return CommunityEvent.db.insertRow(s,CommunityEvent(societyId:p.societyId,organizerUserId:p.id!,title:Access.text(title,max:100),description:Access.text(description),category:category,startsAt:start.toUtc(),endsAt:end.toUtc(),latitude:latitude,longitude:longitude,venueLabel:Access.text(venue,max:150),capacity:capacity,status:'scheduled',isDemo:false));
 }
 Future<int> participantCount(Session s,int id) async { final p=await Access.profile(s); final e=await CommunityEvent.db.findById(s,id); if(e==null||e.societyId!=p.societyId)throw GymException(message:'Event not found.'); return EventParticipant.db.count(s,where:(t)=>t.eventId.equals(id)&t.status.equals('joined')); }
 Future<void> join(Session s,int id,bool join) async {
  final p=await Access.profile(s);
  await s.db.transaction((tx) async {
   final e=await CommunityEvent.db.findById(s,id,transaction:tx,lockMode:LockMode.forUpdate);
   if(e==null||e.societyId!=p.societyId||e.status!='scheduled'||e.endsAt.isBefore(DateTime.now()))throw GymException(message:'Event is unavailable.');
   final old=await EventParticipant.db.findFirstRow(s,where:(t)=>t.eventId.equals(id)&t.userId.equals(p.id!),transaction:tx);
   if(join && old?.status!='joined' && await EventParticipant.db.count(s,where:(t)=>t.eventId.equals(id)&t.status.equals('joined'),transaction:tx)>=e.capacity)throw GymException(message:'This event is full.');
   if(old!=null){ old.status=join?'joined':'left'; await EventParticipant.db.updateRow(s,old,transaction:tx); } else if(join){await EventParticipant.db.insertRow(s,EventParticipant(eventId:id,userId:p.id!,joinedAt:DateTime.now().toUtc(),status:'joined'),transaction:tx);}
  });
 }
}
''')
put('endpoints/form_endpoint.dart','''import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/access.dart';
class FormEndpoint extends Endpoint {
 @override bool get requireLogin=>true;
 Future<FormResult> save(Session s,int exerciseId,String checkpoint,double confidence,List<FormMetric> metrics) async {
  final p=await Access.profile(s); final exercise=await Exercise.db.findById(s,exerciseId);
  if(exercise==null||!['squat','push-up','plank','curl'].contains(checkpoint)||!confidence.isFinite||confidence<.65||confidence>1||metrics.isEmpty||metrics.length>8||metrics.any((m)=>!m.measuredValue.isFinite||!m.confidence.isFinite||m.confidence<.65||m.confidence>1||m.metricName.length>60||m.cue.length>300||m.targetRangeText.length>80||!['check passed','needs attention'].contains(m.status)))throw GymException(message:'Retake the photo with all important landmarks visible.');
  final now=DateTime.now().toUtc(); final attention=metrics.any((m)=>m.status=='needs attention');
  final row=await FormAnalysis.db.insertRow(s,FormAnalysis(userId:p.id!,exerciseId:exerciseId,checkpoint:checkpoint,capturedAt:now,analysisType:'photo',resultBand:attention?'needs attention':'checks passed',confidence:confidence,summary:attention?'Review the technique cues below.':'Visible checkpoint metrics are within the reference ranges. This is not a safety assessment.'));
  final saved=<FormMetric>[]; for(final m in metrics){ saved.add(await FormMetric.db.insertRow(s,FormMetric(formAnalysisId:row.id!,metricName:m.metricName,measuredValue:m.measuredValue,unit:m.unit,targetRangeText:m.targetRangeText,status:m.status,confidence:m.confidence,cue:m.cue))); }
  return FormResult(analysis:row,metrics:saved);
 }
 Future<List<FormAnalysis>> history(Session s) async { final p=await Access.profile(s); return FormAnalysis.db.find(s,where:(t)=>t.userId.equals(p.id!),orderBy:(t)=>t.capturedAt,orderDescending:true,limit:100); }
 Future<FormResult> detail(Session s,int id) async { final p=await Access.profile(s); final a=await FormAnalysis.db.findById(s,id); if(a==null||a.userId!=p.id)throw GymException(message:'Analysis not found.'); return FormResult(analysis:a,metrics:await FormMetric.db.find(s,where:(t)=>t.formAnalysisId.equals(id))); }
}
''')
put('endpoints/dashboard_endpoint.dart','''import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/access.dart';
import '../services/workout/workout_service.dart';
class DashboardEndpoint extends Endpoint {
 @override bool get requireLogin=>true;
 Future<DashboardData> getSummary(Session s) async {
  final p=await Access.profile(s); final history=await WorkoutSession.db.find(s,where:(t)=>t.userId.equals(p.id!),orderBy:(t)=>t.startedAt,orderDescending:true,limit:100);
  var count=0; var volume=0.0; for(final session in history){ final sets=await WorkoutSet.db.find(s,where:(t)=>t.sessionId.equals(session.id!)); count+=sets.length; volume+=sets.fold<double>(0,(v,e)=>v+(e.reps??0)*(e.weightKg??0)); }
  return DashboardData(profile:p,society:(await Society.db.findById(s,p.societyId))!,equipment:await SocietyEquipment.db.find(s,where:(t)=>t.societyId.equals(p.societyId)),readiness:await WorkoutService.readiness(s,p),recentSessions:history,events:await CommunityEvent.db.find(s,where:(t)=>t.societyId.equals(p.societyId)&(t.endsAt>DateTime.now().toUtc()),orderBy:(t)=>t.startsAt,limit:3),completedSets:count,volumeKg:volume);
 }
}
''')
