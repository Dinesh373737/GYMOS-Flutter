from pathlib import Path
b=Path('gymos2')
def put(p,s):
 f=b/p;f.parent.mkdir(parents=True,exist_ok=True);f.write_text(s,encoding='utf8')
put('gymos2_server/test/unit/planner_test.dart',r'''import 'package:test/test.dart';
import 'package:gymos2_server/src/generated/protocol.dart';
import 'package:gymos2_server/src/services/workout/planner.dart';
Exercise ex(int id,String name,{String difficulty='beginner',int minutes=5})=>Exercise(id:id,name:name,slug:name,instructions:'Controlled movement',difficulty:difficulty,movementPattern:'push',exerciseType:'strength',defaultDurationMin:minutes,isActive:true);
void main(){
 test('planner respects equipment, duration, difficulty and high load',(){final chosen=Planner.select(exercises:[ex(1,'bodyweight'),ex(2,'machine'),ex(3,'advanced',difficulty:'advanced'),ex(4,'loaded'),ex(5,'long',minutes:20)],availableEquipment:{},requirements:[ExerciseEquipment(exerciseId:2,equipmentId:1,required:true)],minutes:10,experience:'beginner',focus:'push',highLoadExercises:{4});expect(chosen.map((e)=>e.id),[1]);expect(chosen.fold<int>(0,(n,e)=>n+e.defaultDurationMin),lessThanOrEqualTo(10));});
 test('training load decays with time and effort matters',(){expect(Planner.decayedLoad(80,const Duration(hours:48)),closeTo(40,.001));expect(Planner.band(80),'HIGH RECENT LOAD');expect(Planner.band(40),'MODERATE LOAD');expect(Planner.band(10),'READY');});
 test('recently repeated exercise is deprioritized',(){final selected=Planner.select(exercises:[ex(1,'repeated'),ex(2,'fresh')],availableEquipment:{},requirements:[],minutes:5,experience:'beginner',focus:'push',highLoadExercises:{},recentCounts:{1:3});expect(selected.single.id,2);});
}
''')
put('gymos2_server/test/integration/gym_flow_test.dart',r'''import 'package:test/test.dart';
import 'package:serverpod_test/serverpod_test.dart';
import 'package:gymos2_server/src/generated/protocol.dart';
import 'test_tools/serverpod_test_tools.dart';
void main(){withServerpod('GymOS real database flow',(builder,endpoints){
 final admin=builder.copyWith(authentication:AuthenticationOverride.authenticationInfo('test-admin',{}));
 final resident=builder.copyWith(authentication:AuthenticationOverride.authenticationInfo('test-resident',{}));
 final outsider=builder.copyWith(authentication:AuthenticationOverride.authenticationInfo('test-outsider',{}));
 test('onboarding, tenant authorization, plans, sets, load, events and maintenance',()async{
  final a=await endpoints.profile.completeOnboarding(admin,'Alex','',true,'beginner','strength',40);
  final society=await endpoints.profile.getSociety(admin);
  final r=await endpoints.profile.completeOnboarding(resident,'Riley',society.inviteCode,false,'beginner','strength',40);
  final o=await endpoints.profile.completeOnboarding(outsider,'Other','',true,'beginner','strength',40);
  expect(a.societyId,r.societyId);expect(o.societyId,isNot(a.societyId));
  final eq=await endpoints.equipment.list(resident);expect(eq,isNotEmpty);
  await expectLater(endpoints.equipment.save(resident,eq.first.id,eq.first.equipmentId,'Forbidden',1,'available','Floor'),throwsA(isA<GymException>()));
  await expectLater(endpoints.equipment.report(outsider,eq.first.id!,'No access','Cannot report another society','high'),throwsA(isA<GymException>()));
  final plan=await endpoints.workout.generate(resident,40,'full body');expect(plan.plan.plannedDurationMin,lessThanOrEqualTo(40));expect(plan.items,isNotEmpty);
  await expectLater(endpoints.workout.getPlan(outsider,plan.plan.id!),throwsA(isA<GymException>()));
  final before=await endpoints.workout.readiness(resident);
  final session=await endpoints.workout.start(resident,plan.plan.id!);
  final set=await endpoints.workout.logSet(resident,session.id!,plan.items.first.exerciseId,1,10,12.0,null,7.0);
  await endpoints.workout.logSet(resident,session.id!,plan.items.first.exerciseId,1,12,12.0,null,7.0);
  final detail=await endpoints.workout.detail(resident,session.id!);expect(detail.sets.length,1);expect(detail.sets.first.reps,12);expect(detail.sets.first.id,set.id);
  await expectLater(endpoints.workout.detail(outsider,session.id!),throwsA(isA<GymException>()));
  final finished=await endpoints.workout.finish(resident,session.id!,'Good session',7);expect(finished.session.endedAt,isNotNull);
  final after=await endpoints.workout.readiness(resident);expect(after.fold<double>(0,(a,b)=>a+b.trainingLoadScore),greaterThan(before.fold<double>(0,(a,b)=>a+b.trainingLoadScore)));
  await expectLater(endpoints.workout.logSet(resident,session.id!,plan.items.first.exerciseId,2,10,12.0,null,7.0),throwsA(isA<GymException>()));
  final events=await endpoints.event.discover(resident,'Bengaluru','all');expect(events.community,isNotEmpty);expect(events.community.every((e)=>e.isDemo),true);expect(events.externalEvents,isEmpty);
  await endpoints.event.join(resident,events.community.first.id!,true);expect(await endpoints.event.participantCount(resident,events.community.first.id!),1);
  await expectLater(endpoints.event.join(outsider,events.community.first.id!,true),throwsA(isA<GymException>()));
  await endpoints.event.join(resident,events.community.first.id!,false);expect(await endpoints.event.participantCount(resident,events.community.first.id!),0);
  final issue=await endpoints.equipment.report(resident,eq.first.id!,'Loose handle','Please inspect handle','medium');
  await expectLater(endpoints.equipment.updateIssue(resident,issue.id!,'resolved'),throwsA(isA<GymException>()));
  await endpoints.equipment.updateIssue(admin,issue.id!,'in progress');await endpoints.equipment.updateIssue(admin,issue.id!,'resolved');
  final refreshed=await endpoints.equipment.list(resident);expect(refreshed.firstWhere((e)=>e.id==eq.first.id).status,'available');
  final dashboard=await endpoints.dashboard.getSummary(resident);expect(dashboard.completedSets,1);expect(dashboard.volumeKg,144);
 });
 });}
''')
put('gymos2_flutter/test/pose_analyzer_test.dart',r'''import 'package:flutter_test/flutter_test.dart';
import 'package:gymos2_flutter/features/form_coach/pose_analyzer.dart';
void main(){
 test('no person and missing landmarks request a retake',(){expect(PoseAnalyzer.analyze('plank',{}).complete,false);expect(PoseAnalyzer.analyze('plank',{'shoulder':const LandmarkPoint(0,0,.9)}).complete,false);});
 test('low confidence does not produce technique claims',(){final result=PoseAnalyzer.analyze('plank',{'shoulder':const LandmarkPoint(0,0,.2),'hip':const LandmarkPoint(1,0,.9),'ankle':const LandmarkPoint(2,0,.9)});expect(result.complete,false);expect(result.metrics,isEmpty);});
 test('straight body line is 180 degrees',(){final result=PoseAnalyzer.analyze('plank',{'shoulder':const LandmarkPoint(0,0,.9),'hip':const LandmarkPoint(1,0,.9),'ankle':const LandmarkPoint(2,0,.9)});expect(result.complete,true);expect(result.metrics.single.value,closeTo(180,.01));expect(result.metrics.single.passed,true);});
 test('overlapping joints are rejected',(){final result=PoseAnalyzer.analyze('plank',{'shoulder':const LandmarkPoint(0,0,.9),'hip':const LandmarkPoint(0,0,.9),'ankle':const LandmarkPoint(2,0,.9)});expect(result.complete,false);});
}
''')
