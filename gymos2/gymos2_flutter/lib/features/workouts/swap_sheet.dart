import 'package:flutter/material.dart';
import 'package:gymos2_client/gymos2_client.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../core/widgets.dart';

/// Lets the user pick an eligible alternative for [item] and returns the
/// updated plan, or null when nothing changed.
Future<PlanDetail?> swapExercise(
  BuildContext context,
  PlanDetail plan,
  WorkoutPlanItem item,
) async {
  final options = await guarded(
    context,
    () => client.workout.alternatives(item.exerciseId),
  );
  if (!context.mounted || options == null) return null;
  final current = plan.exercises
      .where((e) => e.id == item.exerciseId)
      .firstOrNull;
  final taken = plan.items.map((i) => i.exerciseId).toSet();
  final eligible = options.where((e) => !taken.contains(e.id)).toList();
  final choice = await showModalBottomSheet<Exercise>(
    context: context,
    isScrollControlled: true,
    constraints: const BoxConstraints(maxWidth: 640),
    builder: (c) => SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(c).height * .8,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Make it work for you',
                style: Theme.of(c).textTheme.headlineSmall,
              ),
              const SizedBox(height: 6),
              Text(
                current == null
                    ? 'Alternatives that use available equipment.'
                    : 'Alternatives to ${current.name} that use available equipment and fit the time.',
                style: const TextStyle(color: GymTheme.muted),
              ),
              const SizedBox(height: 18),
              if (eligible.isEmpty)
                const EmptyCard(
                  icon: Icons.swap_horiz_rounded,
                  title: 'No eligible alternatives',
                  message:
                      'Nothing else fits this movement and time budget with the equipment available right now.',
                )
              else
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: eligible.take(10).length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (c, i) {
                      final e = eligible[i];
                      return Panel(
                        padding: const EdgeInsets.all(16),
                        onTap: () => Navigator.pop(c, e),
                        child: Row(
                          children: [
                            const IconBadge(
                              Icons.fitness_center_rounded,
                              size: 38,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '${e.defaultDurationMin} min · ${e.difficulty} · ${e.movementPattern}',
                                    style: const TextStyle(
                                      color: GymTheme.muted,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: GymTheme.subtle,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
  if (choice == null || !context.mounted) return null;
  return guarded(
    context,
    () => client.workout.replace(plan.plan.id!, item.id!, choice.id!),
  );
}
