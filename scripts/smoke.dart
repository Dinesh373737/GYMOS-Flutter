import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:gymos2_client/gymos2_client.dart';

class SmokeAuth implements ClientAuthKeyProvider {
  final String token;
  SmokeAuth(this.token);
  @override Future<String?> get authHeaderValue async => 'Bearer $token';
}
Future<void> main(List<String> args) async {
  final credentials = File('.local-demo.json');
  final client = Client('http://localhost:8080/', connectionTimeout: const Duration(seconds: 90));
  try {
    Map<String,dynamic> data;
    if (!credentials.existsSync()) {
      final random = Random.secure();
      data = {'email':'demo@gymos.example','password':'GymOS-${List.generate(24,(_)=>random.nextInt(16).toRadixString(16)).join()}!'};
      final request = await client.emailIdp.startRegistration(email:data['email']);
      data['requestId']=request.toString();
      credentials.writeAsStringSync(jsonEncode(data));
      stdout.writeln('Development registration started. Supply the local server verification code with --verify=CODE.');
      return;
    }
    data=jsonDecode(credentials.readAsStringSync()) as Map<String,dynamic>;
    if(args.any((x)=>x.startsWith('--verify='))){
      final code=args.firstWhere((x)=>x.startsWith('--verify=')).substring(9);
      final registrationToken=await client.emailIdp.verifyRegistrationCode(accountRequestId:UuidValue.fromString(data['requestId']),verificationCode:code);
      await client.emailIdp.finishRegistration(registrationToken:registrationToken,password:data['password']);
      data.remove('requestId'); credentials.writeAsStringSync(jsonEncode(data));
      stdout.writeln('Email registration verified successfully.');
    }
    final auth=await client.emailIdp.login(email:data['email'],password:data['password']);
    client.authKeyProvider=SmokeAuth(auth.token);
    stdout.writeln('Email/password sign-in passed.');
    var profile=await client.profile.getMe();
    profile??=await client.profile.completeOnboarding('Demo member','',true,'beginner','general fitness',40);
    stdout.writeln('Persistent profile and society loaded.');
    if(args.contains('--flow')){
      final plan=await client.workout.generate(40,'full body');
      final session=await client.workout.start(plan.plan.id!);
      await client.workout.logSet(session.id!,plan.items.first.exerciseId,1,10,8.0,null,6.0);
      await client.workout.logSet(session.id!,plan.items.first.exerciseId,2,10,8.0,null,6.0);
      final done=await client.workout.finish(session.id!,'Development verification session',6);
      if(done.sets.length!=2||done.session.endedAt==null)throw StateError('Session did not persist.');
      final events=await client.event.discover('Bengaluru','all');
      if(events.community.isNotEmpty)await client.event.join(events.community.first.id!,true);
      stdout.writeln('Plan, set logging, completion, history and community joining passed.');
    }
    if(args.contains('--coach')){
      final reply=await client.agent.sendMessage('I have 40 minutes. What should I train today?',null);
      stdout.writeln('Groq response: ${reply.message}');
      stdout.writeln('Tools: ${reply.actions.map((a)=>'${a.toolName}:${a.status}').join(', ')}');
      if(reply.planId==null||!reply.actions.any((a)=>a.toolName=='create_workout_draft'&&a.status=='success'))throw StateError('Coach did not produce a verified draft.');
      for(final name in ['get_recent_workouts','get_training_readiness','get_available_equipment']) {
        if(!reply.actions.any((a)=>a.toolName==name&&a.status=='success'))throw StateError('Coach skipped required context: $name');
      }
      final savedPlan=await client.workout.getPlan(reply.planId!);
      if(savedPlan.plan.status!='draft'||savedPlan.plan.plannedDurationMin>40||savedPlan.items.isEmpty)throw StateError('Saved draft failed validation.');
      stdout.writeln('Live Groq tool-calling draft verified: ${savedPlan.items.length} exercises, ${savedPlan.plan.plannedDurationMin} minutes, persisted as a draft.');
    }
    final dashboard=await client.dashboard.getSummary();
    stdout.writeln('Dashboard loaded: ${dashboard.equipment.length} equipment entries, ${dashboard.completedSets} sets.');
  } on GymException catch(e) {stderr.writeln(e.message);exitCode=1;} finally {client.close();}
}
