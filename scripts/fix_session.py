from pathlib import Path
p=Path('gymos2/gymos2_flutter/lib/features/workouts/session_screen.dart')
s=p.read_text();s=s.replace('builder: (d) {\n          final item', '''builder: (d) {
          if (d.plan.items.isEmpty || d.plan.exercises.isEmpty) {
            return const EmptyCard(icon: Icons.fitness_center, title: 'No exercises in this session', message: 'Return to Workout and create a new plan.');
          }
          final item''')
s=s.replace('final finished = d.session.endedAt != null;', 'final finished = d.session.endedAt != null;\n          final nextSet = sets.fold<int>(0, (n, s) => n > s.setNumber ? n : s.setNumber) + 1;')
s=s.replace("'Log set ${sets.length + 1}'", "'Log set $nextSet'")
p.write_text(s)
