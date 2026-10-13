from pathlib import Path
base=Path('gymos2/gymos2_server/lib/src')
def put(p,s):
 f=base/p; f.parent.mkdir(parents=True,exist_ok=True); f.write_text(s)
put('endpoints/profile_endpoint.dart','''import 'dart:math';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/access.dart';
import '../seed/seed_service.dart';
class ProfileEndpoint extends Endpoint {
 @override bool get requireLogin => true;
 Future<UserProfile?> getMe(Session s) async => UserProfile.db.findFirstRow(s,where:(t)=>t.authUserId.equals(Access.authId(s)));
 Future<UserProfile> completeOnboarding(Session s,String name,String inviteCode,bool createDemo,String experience,String goal,int duration) async {
  final id=Access.authId(s); final existing=await getMe(s); if(existing!=null) return existing;
  if(!['beginner','intermediate','advanced'].contains(experience)||duration<10||duration>90) throw GymException(message:'Check your training preferences.');
  await SeedService.catalog(s);
  Society? society;
  if(createDemo) { society=await Society.db.insertRow(s,Society(name:'Demo community',addressLabel:'Bengaluru • demo location',inviteCode:'GYM-${DateTime.now().millisecondsSinceEpoch}-${Random.secure().nextInt(9999)}',createdBy:id,createdAt:DateTime.now().toUtc(),isActive:true)); await SeedService.inventory(s,society.id!); }
  else { society=await Society.db.findFirstRow(s,where:(t)=>t.inviteCode.equals(inviteCode.trim()) & t.isActive.equals(true)); }
  if(society==null) throw GymException(message:'That invite code was not found.');
  final now=DateTime.now().toUtc(); final role=createDemo?'admin':'resident';
  final p=await UserProfile.db.insertRow(s,UserProfile(authUserId:id,displayName:Access.text(name,max:60),role:role,societyId:society.id!,experienceLevel:experience,primaryGoal:Access.text(goal,max:40),preferredWorkoutDuration:duration,onboardingComplete:true,createdAt:now,updatedAt:now));
  await SocietyMembership.db.insertRow(s,SocietyMembership(societyId:society.id!,userId:p.id!,role:role,joinedAt:now,isActive:true));
  if(createDemo) { for(var i=0;i<3;i++) { final start=DateTime.utc(now.year,now.month,now.day+2+i,1); await CommunityEvent.db.insertRow(s,CommunityEvent(societyId:society.id!,organizerUserId:p.id!,title:['Sunrise run','Weekend mobility','Community strength'][i],description:'Demonstration event created with your demo society. Not a real scheduled activity.',category:['running','yoga','fitness'][i],startsAt:start,endsAt:start.add(const Duration(hours:1)),latitude:12.9716+i*.008,longitude:77.5946+i*.006,venueLabel:'Demo community park',capacity:20,status:'scheduled',isDemo:true)); } }
  return p;
 }
 Future<UserProfile> updatePreferences(Session s,String name,String experience,String goal,int duration) async {
  final p=await Access.profile(s); if(duration<10||duration>90||!['beginner','intermediate','advanced'].contains(experience)) throw GymException(message:'Invalid preferences.');
  p..displayName=Access.text(name,max:60)..experienceLevel=experience..primaryGoal=Access.text(goal,max:40)..preferredWorkoutDuration=duration..updatedAt=DateTime.now().toUtc(); return UserProfile.db.updateRow(s,p);
 }
 Future<Society> getSociety(Session s) async { final p=await Access.profile(s); return (await Society.db.findById(s,p.societyId))!; }
 Future<List<UserProfile>> getMembers(Session s) async { final p=await Access.profile(s,admin:true); return UserProfile.db.find(s,where:(t)=>t.societyId.equals(p.societyId)); }
}
''')
put('services/workout/planner.dart','''import 'dart:math';
import '../../generated/protocol.dart';
class Planner {
 static List<Exercise> select({required List<Exercise> exercises,required Set<int> availableEquipment,required List<ExerciseEquipment> requirements,required int minutes,required String experience,required String focus,required Set<int> highLoadExercises,Map<int,int> recentCounts=const {},Set<int> techniqueExercises=const {}}) {
  const ranks={'beginner':0,'intermediate':1,'advanced':2};
  final candidates=exercises.where((e)=>e.isActive && (ranks[e.difficulty]??2)<=(ranks[experience]??0) && !highLoadExercises.contains(e.id) && !requirements.any((r)=>r.exerciseId==e.id && r.required && !availableEquipment.contains(r.equipmentId)) && (focus=='full body'||e.movementPattern==focus||['warmup','cooldown','flexibility'].contains(e.exerciseType))).toList();
  int phase(Exercise e)=>e.exerciseType=='warmup'?0:['cooldown','flexibility'].contains(e.exerciseType)?3:e.exerciseType=='isolation'?2:1;
  candidates.sort((a,b) { final order=phase(a).compareTo(phase(b)); if(order!=0)return order; final score=((recentCounts[a.id]??0)+(techniqueExercises.contains(a.id)?3:0)).compareTo((recentCounts[b.id]??0)+(techniqueExercises.contains(b.id)?3:0)); return score!=0?score:a.id!.compareTo(b.id!); });
  final selected=<Exercise>[]; var used=0;
  for(final e in candidates) { if(used+e.defaultDurationMin<=minutes && selected.length<max(2,minutes~/5)) { selected.add(e); used+=e.defaultDurationMin; } }
  return selected;
 }
 static double decayedLoad(double load,Duration elapsed)=>load*pow(.5,elapsed.inMinutes.clamp(0,1000000)/(48*60));
 static String band(double score)=>score>=65?'HIGH RECENT LOAD':score>=25?'MODERATE LOAD':'READY';
}
''')
put('services/workout/workout_service.dart','''import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';
import '../access.dart';
import 'planner.dart';
class WorkoutService {
 static Future<WorkoutPlan> ownedPlan(Session s,int id,UserProfile p) async { final plan=await WorkoutPlan.db.findById(s,id); if(plan==null||plan.userId!=p.id) throw GymException(message:'Workout not found.'); return plan; }
 static Future<WorkoutSession> ownedSession(Session s,int id,UserProfile p) async { final x=await WorkoutSession.db.findById(s,id); if(x==null||x.userId!=p.id) throw GymException(message:'Session not found.'); return x; }
 static Future<List<TrainingReadiness>> readiness(Session s,UserProfile p) async {
  final now=DateTime.now().toUtc(); final sessions=await WorkoutSession.db.find(s,where:(t)=>t.userId.equals(p.id!) & (t.startedAt>now.subtract(const Duration(days:14))));
  final links=await ExerciseMuscle.db.find(s); final groups=await MuscleGroup.db.find(s); final loads=<int,double>{}; final last=<int,DateTime>{};
  for(final session in sessions) { for(final set in await WorkoutSet.db.find(s,where:(t)=>t.sessionId.equals(session.id!))) { for(final link in links.where((x)=>x.exerciseId==set.exerciseId)) { final dose=(set.rpe??6)*1.5*link.contribution; loads.update(link.muscleGroupId,(v)=>v+Planner.decayedLoad(dose,now.difference(set.completedAt)),ifAbsent:()=>Planner.decayedLoad(dose,now.difference(set.completedAt))); if(last[link.muscleGroupId]==null||last[link.muscleGroupId]!.isBefore(set.completedAt))last[link.muscleGroupId]=set.completedAt; } } }
  return [for(final g in groups) TrainingReadiness(userId:p.id!,muscleGroupId:g.id!,muscleName:g.name,trainingLoadScore:loads[g.id]??0,readinessBand:Planner.band(loads[g.id]??0),lastTrainedAt:last[g.id],computedAt:now,explanation:last[g.id]==null?'No sets logged for this muscle in the last 14 days.':'Estimate from logged sets, effort, and elapsed time; not a medical measure.')];
 }
 static Future<List<Exercise>> eligible(Session s,UserProfile p,{String focus='full body'}) async {
  final equipment=await SocietyEquipment.db.find(s,where:(t)=>t.societyId.equals(p.societyId) & t.status.equals('available') & (t.quantity>0));
  return Planner.select(exercises:await Exercise.db.find(s),availableEquipment:equipment.map((e)=>e.equipmentId).toSet(),requirements:await ExerciseEquipment.db.find(s),minutes:10000,experience:p.experienceLevel,focus:focus,highLoadExercises:{});
 }
 static Future<PlanDetail> generate(Session s,UserProfile p,int minutes,String focus,{String creator='user'}) async {
  if(minutes<10||minutes>90||!['full body','push','pull','squat','hinge','core','cardio'].contains(focus)) throw GymException(message:'Choose 10–90 minutes and a supported focus.');
  final equipment=await SocietyEquipment.db.find(s,where:(t)=>t.societyId.equals(p.societyId)&t.status.equals('available')&(t.quantity>0));
  final load=await readiness(s,p); final high=load.where((r)=>r.readinessBand=='HIGH RECENT LOAD').map((r)=>r.muscleGroupId).toSet();
  final links=await ExerciseMuscle.db.find(s); final highExercises=links.where((l)=>high.contains(l.muscleGroupId)&&l.contribution>=1).map((l)=>l.exerciseId).toSet();
  final history=await WorkoutSession.db.find(s,where:(t)=>t.userId.equals(p.id!),orderBy:(t)=>t.startedAt,orderDescending:true,limit:5); final counts=<int,int>{};
  for(final h in history) { for(final set in await WorkoutSet.db.find(s,where:(t)=>t.sessionId.equals(h.id!))) { counts.update(set.exerciseId,(v)=>v+1,ifAbsent:()=>1); } }
  final forms=await FormAnalysis.db.find(s,where:(t)=>t.userId.equals(p.id!)&t.resultBand.equals('needs attention'));
  final picked=Planner.select(exercises:await Exercise.db.find(s),availableEquipment:equipment.map((e)=>e.equipmentId).toSet(),requirements:await ExerciseEquipment.db.find(s),minutes:minutes,experience:p.experienceLevel,focus:focus,highLoadExercises:highExercises,recentCounts:counts,techniqueExercises:forms.map((f)=>f.exerciseId).toSet());
  if(picked.isEmpty) throw GymException(message:'No eligible exercises for these preferences. Try a different focus.');
  final plan=await WorkoutPlan.db.insertRow(s,WorkoutPlan(userId:p.id!,title:'${focus=='full body'?'Full body':focus[0].toUpperCase()+focus.substring(1)} / ${picked.fold<int>(0,(n,e)=>n+e.defaultDurationMin)} min',createdByType:creator,target:focus,plannedDurationMin:picked.fold<int>(0,(n,e)=>n+e.defaultDurationMin),createdAt:DateTime.now().toUtc(),status:'draft'));
  for(var i=0;i<picked.length;i++) { final e=picked[i]; await WorkoutPlanItem.db.insertRow(s,WorkoutPlanItem(planId:plan.id!,exerciseId:e.id!,orderIndex:i,targetSets:['warmup','cooldown','cardio','flexibility'].contains(e.exerciseType)?1:3,targetRepsText:e.movementPattern=='core'?'30 sec':'8–12',restSeconds:60,rationale:'Fits your ${p.experienceLevel} level and available equipment.${counts[e.id]==null?' Adds variety to your recent sessions.':''}${forms.any((f)=>f.exerciseId==e.id)?' Practice the recent technique cue with a comfortable load.':''}')); }
  return detail(s,plan.id!,p);
 }
 static Future<PlanDetail> detail(Session s,int id,UserProfile p) async { final plan=await ownedPlan(s,id,p); final items=await WorkoutPlanItem.db.find(s,where:(t)=>t.planId.equals(id),orderBy:(t)=>t.orderIndex); final exercises=<Exercise>[]; for(final i in items){ final e=await Exercise.db.findById(s,i.exerciseId); if(e!=null)exercises.add(e); } return PlanDetail(plan:plan,items:items,exercises:exercises); }
 static Future<PlanDetail> replace(Session s,UserProfile p,int planId,int itemId,int exerciseId) async {
  final plan=await ownedPlan(s,planId,p); if(plan.status=='completed')throw GymException(message:'Completed plans cannot be changed.');
  final item=await WorkoutPlanItem.db.findById(s,itemId); if(item==null||item.planId!=planId)throw GymException(message:'Plan item not found.');
  final source=(await Exercise.db.findById(s,item.exerciseId))!; final options=await eligible(s,p,focus:source.movementPattern); final replacement=options.where((e)=>e.id==exerciseId).firstOrNull;
  if(replacement==null)throw GymException(message:'That alternative is not eligible.');
  final newDuration=plan.plannedDurationMin-source.defaultDurationMin+replacement.defaultDurationMin;
  if(newDuration>plan.plannedDurationMin)throw GymException(message:'Choose an alternative that fits the remaining time.');
  item..exerciseId=exerciseId..rationale='Replaced at your request with an eligible ${replacement.movementPattern} exercise.'; await WorkoutPlanItem.db.updateRow(s,item); plan.plannedDurationMin=newDuration; await WorkoutPlan.db.updateRow(s,plan); return detail(s,planId,p);
 }
}
''')
put('endpoints/workout_endpoint.dart','''import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/access.dart';
import '../services/workout/workout_service.dart';
class WorkoutEndpoint extends Endpoint {
 @override bool get requireLogin=>true;
 Future<PlanDetail> generate(Session s,int minutes,String focus) async=>WorkoutService.generate(s,await Access.profile(s),minutes,focus);
 Future<PlanDetail> getPlan(Session s,int id) async=>WorkoutService.detail(s,id,await Access.profile(s));
 Future<List<WorkoutPlan>> plans(Session s) async { final p=await Access.profile(s); return WorkoutPlan.db.find(s,where:(t)=>t.userId.equals(p.id!),orderBy:(t)=>t.createdAt,orderDescending:true,limit:20); }
 Future<List<Exercise>> alternatives(Session s,int exerciseId) async { final p=await Access.profile(s); final e=await Exercise.db.findById(s,exerciseId); if(e==null)return []; return (await WorkoutService.eligible(s,p,focus:e.movementPattern)).where((x)=>x.id!=e.id && x.defaultDurationMin<=e.defaultDurationMin).toList(); }
 Future<PlanDetail> replace(Session s,int planId,int itemId,int exerciseId) async=>WorkoutService.replace(s,await Access.profile(s),planId,itemId,exerciseId);
 Future<WorkoutSession> start(Session s,int planId) async {
  final p=await Access.profile(s); final plan=await WorkoutService.ownedPlan(s,planId,p);
  final existing=await WorkoutSession.db.findFirstRow(s,where:(t)=>t.userId.equals(p.id!)&t.planId.equals(planId)&t.endedAt.equals(null)); if(existing!=null)return existing;
  if(plan.status=='completed')throw GymException(message:'Generate a new plan for your next workout.');
  final allowed=(await WorkoutService.eligible(s,p)).map((e)=>e.id).toSet(); final items=await WorkoutPlanItem.db.find(s,where:(t)=>t.planId.equals(planId)); if(items.any((i)=>!allowed.contains(i.exerciseId)))throw GymException(message:'Equipment availability changed. Replace unavailable exercises before starting.');
  plan.status='active'; await WorkoutPlan.db.updateRow(s,plan);
  return WorkoutSession.db.insertRow(s,WorkoutSession(userId:p.id!,planId:planId,title:plan.title,startedAt:DateTime.now().toUtc(),notes:''));
 }
 Future<WorkoutSet> logSet(Session s,int sessionId,int exerciseId,int setNumber,int? reps,double? weightKg,int? durationSec,double? rpe) async {
  final p=await Access.profile(s); final session=await WorkoutService.ownedSession(s,sessionId,p);
  if(session.endedAt!=null)throw GymException(message:'This session is already finished.');
  if(setNumber<1||setNumber>100||(reps==null&&durationSec==null)||(reps!=null&&(reps<1||reps>1000))||(weightKg!=null&&(!weightKg.isFinite||weightKg<0||weightKg>1000))||(durationSec!=null&&(durationSec<1||durationSec>7200))||(rpe!=null&&(!rpe.isFinite||rpe<1||rpe>10)))throw GymException(message:'Check the set values.');
  final item=await WorkoutPlanItem.db.findFirstRow(s,where:(t)=>t.planId.equals(session.planId)&t.exerciseId.equals(exerciseId)); if(item==null)throw GymException(message:'Exercise is not in this session.');
  final old=await WorkoutSet.db.findFirstRow(s,where:(t)=>t.sessionId.equals(sessionId)&t.exerciseId.equals(exerciseId)&t.setNumber.equals(setNumber));
  final row=WorkoutSet(id:old?.id,sessionId:sessionId,exerciseId:exerciseId,setNumber:setNumber,reps:reps,weightKg:weightKg,durationSec:durationSec,rpe:rpe,completedAt:DateTime.now().toUtc());
  return old==null?WorkoutSet.db.insertRow(s,row):WorkoutSet.db.updateRow(s,row);
 }
 Future<void> deleteSet(Session s,int setId) async { final p=await Access.profile(s); final set=await WorkoutSet.db.findById(s,setId); if(set==null)return; final session=await WorkoutService.ownedSession(s,set.sessionId,p); if(session.endedAt!=null)throw GymException(message:'Finished sessions are read-only.'); await WorkoutSet.db.deleteRow(s,set); }
 Future<SessionDetail> finish(Session s,int id,String notes,double effort) async { final p=await Access.profile(s); final x=await WorkoutService.ownedSession(s,id,p); if(!effort.isFinite||effort<1||effort>10||notes.length>1000)throw GymException(message:'Check effort and notes.'); if(x.endedAt==null){ x..endedAt=DateTime.now().toUtc()..durationMin=DateTime.now().toUtc().difference(x.startedAt).inMinutes..notes=notes.trim()..perceivedEffort=effort; await WorkoutSession.db.updateRow(s,x); final plan=await WorkoutService.ownedPlan(s,x.planId,p); plan.status='completed'; await WorkoutPlan.db.updateRow(s,plan); } return detail(s,id); }
 Future<List<WorkoutSession>> history(Session s) async { final p=await Access.profile(s); return WorkoutSession.db.find(s,where:(t)=>t.userId.equals(p.id!),orderBy:(t)=>t.startedAt,orderDescending:true,limit:100); }
 Future<SessionDetail> detail(Session s,int id) async { final p=await Access.profile(s); final x=await WorkoutService.ownedSession(s,id,p); return SessionDetail(session:x,sets:await WorkoutSet.db.find(s,where:(t)=>t.sessionId.equals(id),orderBy:(t)=>t.completedAt),plan:await WorkoutService.detail(s,x.planId,p)); }
 Future<List<TrainingReadiness>> readiness(Session s) async=>WorkoutService.readiness(s,await Access.profile(s));
}
''')
