from pathlib import Path
b=Path('gymos2/gymos2_flutter/lib')
f=b/'features/events/discover_screen.dart';s=f.read_text().replace("label:const Text('Directions'))])])));}","label:const Text('Directions'))])]))));}");f.write_text(s)
f=b/'features/progress/progress_screen.dart';s=f.read_text().replace('BorderRadius.circular(6))])]))]))','BorderRadius.circular(6))])]))) ]))');f.write_text(s)
f=b/'core/widgets.dart';s=f.read_text().replace('if(action!=null)action!','?action');f.write_text(s)
f=b/'features/onboarding/onboarding_screen.dart';s=f.read_text().replace("context.go('/home');","if(context.mounted)context.go('/home');");f.write_text(s)
f=b/'features/workouts/workout_screen.dart';s=f.read_text().replace('if(session!=null)context.go','if(session!=null&&context.mounted)context.go');f.write_text(s)
f=b/'features/form_coach/form_screen.dart';s=f.read_text().replace('if(library!=null&&mounted)','if(library!=null&&context.mounted)');f.write_text(s)
