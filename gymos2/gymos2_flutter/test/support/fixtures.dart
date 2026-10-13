import 'package:gymos2_client/gymos2_client.dart';

final fixtureTime = DateTime.utc(2026, 9, 29, 10);

UserProfile memberProfile() => UserProfile(
  id: 1,
  authUserId: 'test-user',
  displayName: 'Alex',
  role: 'member',
  societyId: 1,
  experienceLevel: 'beginner',
  primaryGoal: 'strength',
  preferredWorkoutDuration: 30,
  onboardingComplete: true,
  createdAt: fixtureTime,
  updatedAt: fixtureTime,
);

SessionDetail sessionFixture({bool finished = false}) => SessionDetail(
  session: WorkoutSession(
    id: 20,
    userId: 1,
    planId: 10,
    title: 'Full body strength',
    startedAt: fixtureTime,
    endedAt: finished ? fixtureTime.add(const Duration(minutes: 30)) : null,
    durationMin: finished ? 30 : null,
    notes: '',
  ),
  sets: [],
  plan: PlanDetail(
    plan: WorkoutPlan(
      id: 10,
      userId: 1,
      title: 'Full body strength',
      createdByType: 'manual',
      target: 'full body',
      plannedDurationMin: 30,
      createdAt: fixtureTime,
      status: 'ready',
    ),
    items: [
      for (var i = 0; i < 2; i++)
        WorkoutPlanItem(
          id: i + 1,
          planId: 10,
          exerciseId: i + 1,
          orderIndex: i,
          targetSets: 3,
          targetRepsText: '8-12',
          restSeconds: 60,
          rationale: 'Balanced training',
        ),
    ],
    exercises: [
      for (var i = 0; i < 2; i++)
        Exercise(
          id: i + 1,
          name: i == 0 ? 'Goblet squat' : 'Dumbbell row',
          slug: i == 0 ? 'goblet-squat' : 'dumbbell-row',
          instructions: i == 0 ? 'Keep a stable stance.' : 'Pull with control.',
          difficulty: 'beginner',
          movementPattern: i == 0 ? 'squat' : 'pull',
          exerciseType: 'strength',
          defaultDurationMin: 5,
          isActive: true,
        ),
    ],
  ),
);

WorkoutSet setFixture({int number = 1, int exerciseId = 1}) => WorkoutSet(
  id: number,
  sessionId: 20,
  exerciseId: exerciseId,
  setNumber: number,
  reps: 8,
  weightKg: 12.5,
  rpe: 7,
  completedAt: fixtureTime,
);

DiscoverData emptyEvents() => DiscoverData(
  community: [],
  externalEvents: [],
  joinedEventIds: [],
  providerStatus: 'External events are unavailable.',
);
