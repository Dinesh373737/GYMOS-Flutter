from pathlib import Path
base=Path('gymos2/gymos2_flutter/lib')
def put(p,s):
 f=base/p; f.parent.mkdir(parents=True,exist_ok=True); f.write_text(s,encoding='utf8')
put('app/theme.dart',r'''import 'package:flutter/material.dart';
class GymTheme {
 static const bg=Color(0xFF101310),surface=Color(0xFF1B201C),line=Color(0xFF303830),accent=Color(0xFFD5F778),muted=Color(0xFFA1ADA1),orange=Color(0xFFF1B579);
 static const gap=20.0,radius=24.0;
 static ThemeData get dark=>ThemeData(useMaterial3:true,brightness:Brightness.dark,scaffoldBackgroundColor:bg,colorScheme:const ColorScheme.dark(primary:accent,onPrimary:bg,surface:surface,onSurface:Color(0xFFF3F5EE),secondary:orange,error:Color(0xFFFFB4AB)),fontFamily:'Arial',appBarTheme:const AppBarTheme(backgroundColor:bg,centerTitle:false),cardTheme:CardThemeData(color:surface,elevation:0,margin:EdgeInsets.zero,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(radius),side:const BorderSide(color:line))),inputDecorationTheme:InputDecorationTheme(filled:true,fillColor:surface,contentPadding:const EdgeInsets.all(18),border:OutlineInputBorder(borderRadius:BorderRadius.circular(16),borderSide:const BorderSide(color:line)),enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(16),borderSide:const BorderSide(color:line))),filledButtonTheme:FilledButtonThemeData(style:FilledButton.styleFrom(padding:const EdgeInsets.symmetric(horizontal:24,vertical:19),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(16)),textStyle:const TextStyle(fontSize:15,fontWeight:FontWeight.w700))),navigationBarTheme:const NavigationBarThemeData(backgroundColor:bg,indicatorColor:accent,labelBehavior:NavigationDestinationLabelBehavior.alwaysShow),dividerColor:line,textTheme:const TextTheme(displaySmall:TextStyle(fontSize:38,fontWeight:FontWeight.w800,letterSpacing:-1.5),headlineMedium:TextStyle(fontSize:28,fontWeight:FontWeight.w700,letterSpacing:-.8),titleLarge:TextStyle(fontSize:21,fontWeight:FontWeight.w700),titleMedium:TextStyle(fontSize:16,fontWeight:FontWeight.w600),bodyLarge:TextStyle(fontSize:16,height:1.5),bodyMedium:TextStyle(fontSize:14,height:1.45),labelSmall:TextStyle(fontSize:11,letterSpacing:1.6,fontWeight:FontWeight.w700)));
}
''')
put('core/widgets.dart',r'''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymos2_client/gymos2_client.dart';
import '../app/theme.dart';
String errorText(Object e)=>e is GymException?e.message:'Could not connect. Check your connection and try again.';
class AsyncPanel<T> extends StatelessWidget {
 final AsyncValue<T> value; final Widget Function(T) builder; final VoidCallback retry;
 const AsyncPanel({super.key,required this.value,required this.builder,required this.retry});
 @override Widget build(BuildContext context)=>value.when(data:builder,loading:()=>const Padding(padding:EdgeInsets.all(48),child:Center(child:CircularProgressIndicator())),error:(e,_)=>EmptyCard(icon:Icons.cloud_off_outlined,title:'Let’s reconnect',message:errorText(e),action:OutlinedButton.icon(onPressed:retry,icon:const Icon(Icons.refresh),label:const Text('Try again'))));
}
class PageBody extends StatelessWidget {
 final List<Widget> children; const PageBody({super.key,required this.children});
 @override Widget build(BuildContext context)=>SingleChildScrollView(padding:EdgeInsets.fromLTRB(MediaQuery.sizeOf(context).width>1000?36:20,20,MediaQuery.sizeOf(context).width>1000?36:20,110),child:Center(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:1160),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:children))));
}
class PageTitle extends StatelessWidget {
 final String eyebrow,title,subtitle; final Widget? action;
 const PageTitle(this.eyebrow,this.title,this.subtitle,{super.key,this.action});
 @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.only(bottom:28),child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(eyebrow.toUpperCase(),style:Theme.of(context).textTheme.labelSmall?.copyWith(color:GymTheme.accent)),const SizedBox(height:10),Text(title,style:Theme.of(context).textTheme.displaySmall),const SizedBox(height:10),Text(subtitle,style:const TextStyle(color:GymTheme.muted))])),if(action!=null)action!]));
}
class Panel extends StatelessWidget {
 final Widget child; final Color? color; final EdgeInsets padding; const Panel({super.key,required this.child,this.color,this.padding=const EdgeInsets.all(24)});
 @override Widget build(BuildContext context)=>Card(color:color,child:Padding(padding:padding,child:child));
}
class SectionTitle extends StatelessWidget {
 final String title; final Widget? action; const SectionTitle(this.title,{super.key,this.action});
 @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.only(top:28,bottom:16),child:Row(children:[Expanded(child:Text(title,style:Theme.of(context).textTheme.titleLarge)),if(action!=null)action!]));
}
class StatusPill extends StatelessWidget {
 final String text; final Color color; const StatusPill(this.text,{super.key,this.color=GymTheme.accent});
 @override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:6),decoration:BoxDecoration(color:color.withValues(alpha:.12),borderRadius:BorderRadius.circular(30)),child:Text(text,style:TextStyle(fontSize:11,fontWeight:FontWeight.w700,color:color)));
}
class EmptyCard extends StatelessWidget {
 final IconData icon; final String title,message; final Widget? action;
 const EmptyCard({super.key,required this.icon,required this.title,required this.message,this.action});
 @override Widget build(BuildContext context)=>Panel(child:Center(child:Column(children:[Icon(icon,color:GymTheme.accent,size:40),const SizedBox(height:16),Text(title,style:Theme.of(context).textTheme.titleLarge),const SizedBox(height:8),Text(message,textAlign:TextAlign.center,style:const TextStyle(color:GymTheme.muted)),if(action!=null)...[const SizedBox(height:20),action!]])));
}
class ResponsivePair extends StatelessWidget {
 final Widget first,second; const ResponsivePair({super.key,required this.first,required this.second});
 @override Widget build(BuildContext context)=>LayoutBuilder(builder:(c,b)=>b.maxWidth>760?Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(flex:3,child:first),const SizedBox(width:20),Expanded(flex:2,child:second)]):Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[first,const SizedBox(height:20),second]));
}
Future<T?> guarded<T>(BuildContext context,Future<T> Function() action) async {try{return await action();}catch(e){if(context.mounted)ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(errorText(e))));return null;}}
String shortDate(DateTime d){final x=d.toLocal();return '${x.day}/${x.month} • ${x.hour.toString().padLeft(2,'0')}:${x.minute.toString().padLeft(2,'0')}';}
''')
put('core/providers.dart',r'''import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../client.dart';
final profileProvider=FutureProvider((ref)=>client.profile.getMe());
final dashboardProvider=FutureProvider((ref)=>client.dashboard.getSummary());
final equipmentProvider=FutureProvider((ref)=>client.equipment.list());
final issuesProvider=FutureProvider((ref)=>client.equipment.issues());
final exercisesProvider=FutureProvider((ref)=>client.exercise.list(''));
final historyProvider=FutureProvider((ref)=>client.workout.history());
final plansProvider=FutureProvider((ref)=>client.workout.plans());
final readinessProvider=FutureProvider((ref)=>client.workout.readiness());
final formHistoryProvider=FutureProvider((ref)=>client.form.history());
final equipmentStreamProvider=StreamProvider((ref)=>client.equipment.watch());
final planProvider=FutureProvider.family((ref,int id)=>client.workout.getPlan(id));
final sessionProvider=FutureProvider.family((ref,int id)=>client.workout.detail(id));
final discoverProvider=FutureProvider.family((ref,({String city,String category}) q)=>client.event.discover(q.city,q.category));
''')
put('main.dart',r'''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'client.dart';
import 'app/app.dart';
Future<void> main() async {WidgetsFlutterBinding.ensureInitialized();await initializeClient();runApp(const ProviderScope(child:GymApp()));}
''')
f=base/'client.dart';s=f.read_text();s=s.replace("import 'dart:async';",'').replace('unawaited(client.auth.initialize());','await client.auth.initialize();');f.write_text(s,encoding='utf8')
put('features/auth/auth_screen.dart',r'''import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import '../../client.dart';
import '../../app/theme.dart';
import '../../core/widgets.dart';
class AuthScreen extends StatelessWidget {
 const AuthScreen({super.key});
 @override Widget build(BuildContext context)=>Scaffold(body:Center(child:SingleChildScrollView(padding:const EdgeInsets.all(24),child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:1050),child:ResponsivePair(first:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Row(children:[Icon(Icons.bolt,size:38,color:GymTheme.accent),Text('GymOS',style:TextStyle(fontSize:28,fontWeight:FontWeight.w900))]),const SizedBox(height:50),const StatusPill('YOUR EVERYDAY TRAINING COMPANION'),const SizedBox(height:24),Text('A little stronger.\nA lot more together.',style:Theme.of(context).textTheme.displaySmall?.copyWith(fontSize:48,height:1.08)),const SizedBox(height:24),const Text('Thoughtful workouts. Clear technique cues.\nA community that keeps you moving.',style:TextStyle(fontSize:18,color:GymTheme.muted,height:1.6)),const SizedBox(height:40),const Wrap(spacing:10,runSpacing:10,children:[StatusPill('PERSONAL PLANS'),StatusPill('PHOTO FORM COACH'),StatusPill('COMMUNITY')])]),second:Panel(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Your next chapter starts here.',style:Theme.of(context).textTheme.headlineMedium),const SizedBox(height:12),const Text('Sign in or create your account.',style:TextStyle(color:GymTheme.muted)),const SizedBox(height:24),SignInWidget(client:client,onAuthenticated:(){},onError:(e)=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Sign-in failed. Check your details and try again.')))),const SizedBox(height:16),const Text('Development sign-up codes appear in the local server console.',style:TextStyle(color:GymTheme.muted,fontSize:12))])))))));
}
''')
put('features/onboarding/onboarding_screen.dart',r'''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../client.dart';
import '../../core/providers.dart';
import '../../core/widgets.dart';
class OnboardingScreen extends ConsumerStatefulWidget {const OnboardingScreen({super.key});@override ConsumerState<OnboardingScreen> createState()=>_State();}
class _State extends ConsumerState<OnboardingScreen>{final name=TextEditingController(),invite=TextEditingController();String experience='beginner',goal='general fitness';double duration=40;bool demo=true,busy=false;
 @override void dispose(){name.dispose();invite.dispose();super.dispose();}
 @override Widget build(BuildContext context)=>Scaffold(body:PageBody(children:[const PageTitle('MAKE IT YOURS','Train on your terms.','A few details help us build sessions that fit your day.'),Center(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:540),child:Panel(child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[TextField(controller:name,decoration:const InputDecoration(labelText:'Your name')),const SizedBox(height:16),DropdownButtonFormField<String>(initialValue:experience,decoration:const InputDecoration(labelText:'Experience'),items:['beginner','intermediate','advanced'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(x)=>setState(()=>experience=x!)),const SizedBox(height:16),DropdownButtonFormField<String>(initialValue:goal,decoration:const InputDecoration(labelText:'Your focus'),items:['general fitness','strength','endurance','mobility','consistency'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(x)=>setState(()=>goal=x!)),const SizedBox(height:20),Text('Preferred session • ${duration.toInt()} minutes'),Slider(value:duration,min:10,max:90,divisions:16,label:'${duration.toInt()} min',onChanged:(v)=>setState(()=>duration=v)),SwitchListTile(contentPadding:EdgeInsets.zero,title:const Text('Create my demo community'),subtitle:const Text('Own a separate demo gym with labeled sample equipment and events.'),value:demo,onChanged:(v)=>setState(()=>demo=v)),if(!demo)TextField(controller:invite,decoration:const InputDecoration(labelText:'Society invite code')),const SizedBox(height:20),FilledButton(onPressed:busy?null:()async{setState(()=>busy=true);final p=await guarded(context,()=>client.profile.completeOnboarding(name.text,invite.text,demo,experience,goal,duration.toInt()));if(!mounted)return;setState(()=>busy=false);if(p!=null){ref.invalidate(profileProvider);ref.invalidate(dashboardProvider);context.go('/home');}},child:Text(busy?'Setting things up…':'Let’s get moving'))]))))]));
}
''')
put('app/app.dart',r'''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import '../client.dart';
import '../core/providers.dart';
import '../core/widgets.dart';
import '../features/auth/auth_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/dashboard/home_screen.dart';
import '../features/workouts/workout_screen.dart';
import '../features/workouts/session_screen.dart';
import '../features/form_coach/form_screen.dart';
import '../features/events/discover_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/equipment/equipment_screen.dart';
import '../features/agent/agent_screen.dart';
import '../features/progress/progress_screen.dart';
import 'theme.dart';
class GymApp extends ConsumerStatefulWidget {const GymApp({super.key});@override ConsumerState<GymApp> createState()=>_GymAppState();}
class _GymAppState extends ConsumerState<GymApp>{late final GoRouter router;
 @override void initState(){super.initState();router=GoRouter(initialLocation:'/home',refreshListenable:client.auth.authInfoListenable,redirect:(c,s){final signed=client.auth.isAuthenticated;if(!signed)return s.matchedLocation=='/auth'?null:'/auth';if(s.matchedLocation=='/auth')return '/home';return null;},routes:[GoRoute(path:'/auth',builder:(c,s)=>const AuthScreen()),GoRoute(path:'/onboarding',builder:(c,s)=>const OnboardingScreen()),ShellRoute(builder:(c,s,child)=>AppShell(path:s.uri.path,child:child),routes:[GoRoute(path:'/home',builder:(c,s)=>const HomeScreen()),GoRoute(path:'/workout',builder:(c,s)=>WorkoutScreen(planId:int.tryParse(s.uri.queryParameters['plan']??''))),GoRoute(path:'/session/:id',builder:(c,s)=>SessionScreen(id:int.parse(s.pathParameters['id']!))),GoRoute(path:'/form',builder:(c,s)=>const FormScreen()),GoRoute(path:'/discover',builder:(c,s)=>const DiscoverScreen()),GoRoute(path:'/profile',builder:(c,s)=>const ProfileScreen()),GoRoute(path:'/equipment',builder:(c,s)=>const EquipmentScreen()),GoRoute(path:'/coach',builder:(c,s)=>const AgentScreen()),GoRoute(path:'/progress',builder:(c,s)=>const ProgressScreen())])]);client.auth.authInfoListenable.addListener(clearUserState);}
 void clearUserState(){ref.invalidate(profileProvider);ref.invalidate(dashboardProvider);ref.invalidate(equipmentProvider);ref.invalidate(historyProvider);ref.invalidate(plansProvider);ref.invalidate(readinessProvider);ref.invalidate(formHistoryProvider);ref.invalidate(issuesProvider);ref.invalidate(discoverProvider);ref.invalidate(planProvider);ref.invalidate(sessionProvider);ref.invalidate(equipmentStreamProvider);}
 @override void dispose(){client.auth.authInfoListenable.removeListener(clearUserState);router.dispose();super.dispose();}
 @override Widget build(BuildContext context)=>MaterialApp.router(title:'GymOS • Train together',debugShowCheckedModeBanner:false,theme:GymTheme.dark,routerConfig:router);
}
class AppShell extends ConsumerWidget {
 final String path;final Widget child;const AppShell({super.key,required this.path,required this.child});
 static const paths=['/home','/workout','/form','/discover','/profile'];static const labels=['Home','Workout','Form','Discover','Profile'];static const icons=[Icons.grid_view_rounded,Icons.fitness_center_rounded,Icons.accessibility_new_rounded,Icons.explore_outlined,Icons.person_outline_rounded];
 @override Widget build(BuildContext context){final profile=ref.watch(profileProvider);final index=paths.indexOf(path);final selected=index<0?0:index;
 ref.listen(equipmentStreamProvider,(previous,next){if(next.hasValue){ref.invalidate(equipmentProvider);ref.invalidate(dashboardProvider);}});
 return profile.when(loading:()=>const Scaffold(body:Center(child:CircularProgressIndicator())),error:(e,_)=>Scaffold(body:PageBody(children:[EmptyCard(icon:Icons.cloud_off,title:'Unable to load your profile',message:errorText(e),action:FilledButton(onPressed:()=>ref.invalidate(profileProvider),child:const Text('Retry')))])),data:(p){if(p==null){WidgetsBinding.instance.addPostFrameCallback((_){if(context.mounted)context.go('/onboarding');});return const Scaffold(body:Center(child:CircularProgressIndicator()));}
 final wide=MediaQuery.sizeOf(context).width>=900;
 return Scaffold(appBar:wide?null:AppBar(title:const Row(mainAxisSize:MainAxisSize.min,children:[Icon(Icons.bolt,color:GymTheme.accent),Text('GymOS',style:TextStyle(fontWeight:FontWeight.w800))]),actions:[IconButton(tooltip:'Progress',onPressed:()=>context.go('/progress'),icon:const Icon(Icons.insights_outlined)),const SizedBox(width:8)]),body:SafeArea(child:Row(children:[if(wide)Container(width:220,decoration:const BoxDecoration(border:Border(right:BorderSide(color:GymTheme.line))),padding:const EdgeInsets.all(22),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const SizedBox(height:16),const Row(children:[Icon(Icons.bolt,color:GymTheme.accent,size:32),Text('GymOS',style:TextStyle(fontSize:26,fontWeight:FontWeight.w900))]),const SizedBox(height:8),const Text('MOVE WELL. LIVE WELL.',style:TextStyle(fontSize:9,letterSpacing:2,color:GymTheme.muted)),const SizedBox(height:50),for(var i=0;i<paths.length;i++)Padding(padding:const EdgeInsets.only(bottom:10),child:ListTile(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(14)),selected:path==paths[i],selectedTileColor:GymTheme.accent.withValues(alpha:.12),selectedColor:GymTheme.accent,leading:Icon(icons[i]),title:Text(labels[i]),onTap:()=>context.go(paths[i]))),const Divider(height:40),ListTile(leading:const Icon(Icons.insights_outlined),title:const Text('Progress'),onTap:()=>context.go('/progress')),ListTile(leading:const Icon(Icons.sports_gymnastics),title:const Text('Our gym'),onTap:()=>context.go('/equipment')),const Spacer(),const StatusPill('YOUR COMMUNITY'),const SizedBox(height:14),Text(p.displayName,style:const TextStyle(fontWeight:FontWeight.bold)),const SizedBox(height:5),Text(p.role,style:const TextStyle(color:GymTheme.muted)),const SizedBox(height:18)])),Expanded(child:child)])),bottomNavigationBar:wide?null:NavigationBar(selectedIndex:selected,onDestinationSelected:(i)=>context.go(paths[i]),destinations:[for(var i=0;i<paths.length;i++)NavigationDestination(icon:Icon(icons[i]),selectedIcon:Icon(icons[i],color:GymTheme.bg),label:labels[i])]),floatingActionButton:path=='/coach'?null:FloatingActionButton.extended(onPressed:()=>context.go('/coach'),backgroundColor:GymTheme.accent,foregroundColor:GymTheme.bg,icon:const Icon(Icons.auto_awesome),label:const Text('Ask GymOS')));
 });}
}
''')
