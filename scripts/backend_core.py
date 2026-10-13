from pathlib import Path
import re,json
base=Path('gymos2/gymos2_server/lib/src')
def put(p,s):
 f=base/p; f.parent.mkdir(parents=True,exist_ok=True); f.write_text(s)
f=base/'models/discover_data.spy.yaml'; f.write_text(f.read_text().replace('external:', 'externalEvents:'))
put(Path('services/access.dart'),'''import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
class Access {
  static String authId(Session s) {
    final id = s.authenticated?.userIdentifier;
    if (id == null) throw GymException(message: 'Please sign in.');
    return id;
  }
  static Future<UserProfile> profile(Session s, {bool admin = false}) async {
    final id = authId(s);
    final p = await UserProfile.db.findFirstRow(s, where: (t) => t.authUserId.equals(id));
    if (p == null) throw GymException(message: 'Complete your profile first.');
    final m = await SocietyMembership.db.findFirstRow(s, where: (t) => t.userId.equals(p.id!) & t.societyId.equals(p.societyId) & t.isActive.equals(true));
    if (m == null || (admin && m.role != 'admin')) throw GymException(message: 'This action requires an active society administrator.');
    return p;
  }
  static String text(String value, {int max = 1000}) {
    final v = value.trim().replaceAll(RegExp(r'<[^>]*>'), '');
    if (v.isEmpty || v.length > max) throw GymException(message: 'Enter between 1 and $max characters.');
    return v;
  }
}
''')
seed=Path('original-daa/backend/src/database/seed.js').read_text(encoding='utf8')
ex=[]
for m in re.finditer(r"addEx\('([^']+)','([^']+)','([^']+)','([^']+)','([^']+)','([^']+)',(\d+),\s*(\[.*?\]),\s*(\[.*?\])\);",seed,re.S):
 slug,name,desc,diff,pattern,typ,dur,mus,eq=m.groups()
 muscles=re.findall(r"\['([^']+)',(true|false)\]",mus)
 equips=re.findall(r"\['([^']+)',(true|false)\]",eq)
 ex.append(dict(slug=slug,name=name,instructions=desc+'. Move slowly through a comfortable range, keep control, and stop if the movement causes pain.',difficulty=diff,pattern=pattern,type=typ,duration=int(dur),muscles=muscles,equipment=equips))
eqs=re.findall(r"\[EQ\.(\w+),'([^']+)','([^']+)','([^']+)'\]",seed)
put(Path('seed/catalog.json'),json.dumps({'exercises':ex,'equipment':eqs}))
put(Path('seed/seed_service.dart'),'''import 'dart:convert';
import 'dart:io';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
class SeedService {
 static Future<void> catalog(Session s) async {
  if (await Exercise.db.count(s) > 0) return;
  final data=jsonDecode(await File('lib/src/seed/catalog.json').readAsString()) as Map<String,dynamic>;
  final eq=<String,int>{}; final muscles=<String,int>{};
  for(final row in data['equipment'] as List) {
   final e=await EquipmentCatalog.db.insertRow(s,EquipmentCatalog(name:row[1],category:row[2],description:row[3])); eq[row[0]]=e.id!;
  }
  final exercises=<Exercise>[];
  for(final x in data['exercises'] as List) {
   final e=await Exercise.db.insertRow(s,Exercise(name:x['name'],slug:x['slug'],instructions:x['instructions'],difficulty:x['difficulty'],movementPattern:x['pattern'],exerciseType:x['type'],defaultDurationMin:x['duration'],isActive:true)); exercises.add(e);
   for(final m in x['muscles'] as List) {
    if(!muscles.containsKey(m[0])) { final g=await MuscleGroup.db.insertRow(s,MuscleGroup(name:m[0],bodyArea:['quads','hamstrings','glutes','calves'].contains(m[0])?'lower':'upper')); muscles[m[0]]=g.id!; }
    await ExerciseMuscle.db.insertRow(s,ExerciseMuscle(exerciseId:e.id!,muscleGroupId:muscles[m[0]]!,contribution:m[1]=='true'?1:.4));
   }
   for(final q in x['equipment'] as List) { await ExerciseEquipment.db.insertRow(s,ExerciseEquipment(exerciseId:e.id!,equipmentId:eq[q[0]]!,required:q[1]=='false')); }
  }
  for(final a in exercises) { for(final b in exercises) { if(a.id!=b.id && a.movementPattern==b.movementPattern) await ExerciseAlternative.db.insertRow(s,ExerciseAlternative(sourceExerciseId:a.id!,alternativeExerciseId:b.id!,similarityScore:.8,notes:'Same movement pattern; check the exercise instructions.')); } }
 }
 static Future<void> inventory(Session s,int societyId) async {
  for(final e in await EquipmentCatalog.db.find(s,limit:15)) {
   await SocietyEquipment.db.insertRow(s,SocietyEquipment(societyId:societyId,equipmentId:e.id!,label:e.name,quantity:1,status:e.name=='Cable Machine'?'maintenance':'available',locationLabel:'Demo gym • main floor'));
  }
 }
}
''')
print('Prepared seed catalog:',len(ex),'exercises,',len(eqs),'equipment types')
