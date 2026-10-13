import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:gymos2_client/gymos2_client.dart';
import 'package:gymos2_flutter/app/app.dart';
import 'package:gymos2_flutter/client.dart' as api;
import 'package:gymos2_flutter/core/providers.dart';
import 'package:gymos2_flutter/core/widgets.dart';
import 'package:gymos2_flutter/features/events/discover_screen.dart';
import 'package:gymos2_flutter/features/equipment/equipment_screen.dart';
import 'package:gymos2_flutter/features/workouts/session_screen.dart';
import 'package:gymos2_flutter/features/workouts/workout_screen.dart';

import 'support/fixtures.dart';

class TestClient extends Client {
  TestClient() : super('http://localhost:8080/');

  Future<Object?> Function(
    String endpoint,
    String method,
    Map<String, dynamic> args,
  )?
  handle;

  @override
  Future<T> callServerEndpoint<T>(
    String endpoint,
    String method,
    Map<String, dynamic> args, {
    bool authenticated = true,
  }) async {
    if (handle == null) {
      throw StateError('Unexpected API call: $endpoint.$method');
    }
    return (await handle!(endpoint, method, args)) as T;
  }
}

void main() {
  final fake = TestClient();
  setUpAll(() => api.client = fake);
  setUp(() => fake.handle = null);
  tearDownAll(fake.close);

  for (final status in ['draft', 'active', 'completed']) {
    testWidgets('$status workout offers only valid plan actions', (
      tester,
    ) async {
      final plan = sessionFixture().plan..plan.status = status;
      fake.handle = (endpoint, method, _) async {
        expect('$endpoint.$method', 'workout.getPlan');
        return plan;
      };
      await tester.binding.setSurfaceSize(const Size(1000, 1400));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plansProvider.overrideWith((ref) async => []),
            historyProvider.overrideWith((ref) async => []),
          ],
          child: const MaterialApp(
            home: Scaffold(body: WorkoutScreen(planId: 10)),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.byTooltip('Swap exercise'),
        status == 'draft' ? findsNWidgets(2) : findsNothing,
      );
      expect(
        find.text('Resume workout'),
        status == 'active' ? findsOneWidget : findsNothing,
      );
      expect(
        find.text('Start this workout'),
        status == 'draft' ? findsOneWidget : findsNothing,
      );
    });
  }

  Future<void> screen(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: child)));
  }

  Future<void> session(WidgetTester tester, SessionDetail detail) async {
    await tester.binding.setSurfaceSize(const Size(1000, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [sessionProvider(20).overrideWith((ref) async => detail)],
        child: const MaterialApp(home: Scaffold(body: SessionScreen(id: 20))),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('loading is replaced by data without an error action', (
    tester,
  ) async {
    await screen(
      tester,
      AsyncPanel<String>(
        value: const AsyncLoading(),
        retry: () {},
        builder: Text.new,
      ),
    );
    expect(find.byType(LoadingSkeleton), findsOneWidget);
    expect(find.text('Try again'), findsNothing);
    await screen(
      tester,
      AsyncPanel<String>(
        value: const AsyncData('Loaded workout'),
        retry: () {},
        builder: Text.new,
      ),
    );
    expect(find.text('Loaded workout'), findsOneWidget);
    expect(find.byType(LoadingSkeleton), findsNothing);
  });

  testWidgets('connection error hides internals and retry is usable', (
    tester,
  ) async {
    var retries = 0;
    await screen(
      tester,
      AsyncPanel<String>(
        value: AsyncError(
          StateError('private transport details'),
          StackTrace.empty,
        ),
        retry: () => retries++,
        builder: Text.new,
      ),
    );
    expect(find.text('Let’s reconnect'), findsOneWidget);
    expect(find.textContaining('private transport'), findsNothing);
    await tester.tap(find.text('Try again'));
    expect(retries, 1);
  });

  testWidgets(
    'set entry saves entered values and exposes a skippable rest timer',
    (tester) async {
      final detail = sessionFixture();
      Map<String, dynamic>? submitted;
      final result = Completer<Object?>();
      fake.handle = (endpoint, method, args) {
        expect('$endpoint.$method', 'workout.logSet');
        submitted = args;
        return result.future;
      };
      await session(tester, detail);
      expect(
        find.text('No sets logged for this exercise yet.'),
        findsOneWidget,
      );
      await tester.enterText(find.widgetWithText(TextField, 'Reps'), '8');
      await tester.enterText(
        find.widgetWithText(TextField, 'Weight (kg)'),
        '12.5',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Seconds (opt.)'),
        '45',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Effort 1–10'),
        '7',
      );
      await tester.tap(find.text('Log set 1'));
      await tester.pump();
      expect(find.text('Saving…'), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, 'Saving…'))
            .onPressed,
        isNull,
      );
      expect(submitted, {
        'sessionId': 20,
        'exerciseId': 1,
        'setNumber': 1,
        'reps': 8,
        'weightKg': 12.5,
        'durationSec': 45,
        'rpe': 7.0,
      });
      final saved = setFixture();
      detail.sets.add(saved);
      result.complete(saved);
      await tester.pumpAndSettle();
      expect(find.text('Log set 2'), findsOneWidget);
      expect(find.textContaining('Set 1 • 8 reps'), findsOneWidget);
      expect(find.textContaining('Take a breath'), findsOneWidget);
      await tester.tap(find.text('Skip'));
      await tester.pump();
      expect(find.textContaining('Take a breath'), findsNothing);
    },
  );

  testWidgets('failed set save keeps entered values and allows retry', (
    tester,
  ) async {
    fake.handle = (_, _, _) async =>
        throw GymException(message: 'Use an effort from 1 to 10.');
    await session(tester, sessionFixture());
    await tester.enterText(find.widgetWithText(TextField, 'Reps'), '9');
    await tester.tap(find.text('Log set 1'));
    await tester.pumpAndSettle();
    expect(find.text('Use an effort from 1 to 10.'), findsOneWidget);
    expect(find.text('Log set 1'), findsOneWidget);
    expect(
      tester
          .widget<TextField>(find.widgetWithText(TextField, 'Reps'))
          .controller!
          .text,
      '9',
    );
    expect(find.textContaining('Take a breath'), findsNothing);
  });

  testWidgets('empty session provides a recovery action instead of crashing', (
    tester,
  ) async {
    final detail = sessionFixture()..plan.items.clear();
    await session(tester, detail);
    expect(find.text('No exercises in this session'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('deleted earlier sets do not reuse a later set number', (
    tester,
  ) async {
    final detail = sessionFixture()
      ..sets.addAll([setFixture(), setFixture(number: 3)]);
    await session(tester, detail);
    expect(find.text('Log set 4'), findsOneWidget);
    expect(find.text('Log set 3'), findsNothing);
  });
  testWidgets('exercise selection shows only its own sets', (tester) async {
    final detail = sessionFixture()..sets.add(setFixture());
    await session(tester, detail);
    expect(find.textContaining('Set 1 • 8 reps'), findsOneWidget);
    await tester.tap(find.text('2. Dumbbell row'));
    await tester.pumpAndSettle();
    expect(find.text('Pull with control.'), findsOneWidget);
    expect(find.textContaining('Set 1 • 8 reps'), findsNothing);
    expect(find.text('No sets logged for this exercise yet.'), findsOneWidget);
    expect(find.text('Log set 1'), findsOneWidget);
  });

  testWidgets(
    'completed session displays volume and removes editing controls',
    (tester) async {
      final detail = sessionFixture(finished: true)..sets.add(setFixture());
      await session(tester, detail);
      expect(find.text('SESSION COMPLETE'), findsOneWidget);
      expect(find.textContaining('100 kg total logged volume'), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
      expect(find.byTooltip('Remove set'), findsNothing);
      expect(find.text('Finish workout'), findsNothing);
      expect(find.text('Back to home'), findsOneWidget);
    },
  );

  testWidgets(
    'discover sends selected category and trimmed city and shows empty state',
    (tester) async {
      final queries = <({String city, String category})>[];
      await tester.binding.setSurfaceSize(const Size(1000, 1100));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileProvider.overrideWith((ref) async => memberProfile()),
            discoverProvider.overrideWith((ref, query) async {
              queries.add(query);
              return emptyEvents();
            }),
          ],
          child: const MaterialApp(home: Scaffold(body: DiscoverScreen())),
        ),
      );
      await tester.pumpAndSettle();
      expect(queries.last, (city: 'Bengaluru', category: 'all'));
      expect(find.text('Room for something good'), findsOneWidget);
      expect(find.text('External events are unavailable.'), findsOneWidget);
      expect(find.byTooltip('Create community event'), findsNothing);
      await tester.tap(find.text('Yoga'));
      await tester.pumpAndSettle();
      expect(queries.last, (city: 'Bengaluru', category: 'yoga'));
      await tester.enterText(find.byType(TextField), '  Pune  ');
      await tester.tap(find.byTooltip('Search city'));
      await tester.pumpAndSettle();
      expect(queries.last, (city: 'Pune', category: 'yoga'));
      await tester.tap(find.text('Map'));
      await tester.pumpAndSettle();
      expect(
        find.text(
          'No event locations available here. Events remain in the list.',
        ),
        findsOneWidget,
      );
      expect(find.text('© OpenStreetMap contributors'), findsOneWidget);
    },
  );

  testWidgets('mobile navigation opens the selected destination', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: '/home',
      routes: [
        ShellRoute(
          builder: (context, state, child) =>
              AppShell(path: state.uri.path, child: child),
          routes: [
            for (final path in AppShell.paths)
              GoRoute(path: path, builder: (_, _) => Text('Page $path')),
            GoRoute(
              path: '/coach',
              builder: (_, _) => const Text('Coach page'),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileProvider.overrideWith((ref) async => memberProfile()),
          equipmentStreamProvider.overrideWith((ref) => const Stream.empty()),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discover'));
    await tester.pumpAndSettle();
    expect(find.text('Page /discover'), findsOneWidget);
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      3,
    );
    await tester.tap(find.text('Ask GymOS'));
    await tester.pumpAndSettle();
    expect(find.text('Coach page'), findsOneWidget);
    expect(find.text('Ask GymOS'), findsNothing);
  });

  Future<void> equipmentScreen(WidgetTester tester, {bool admin = true}) async {
    await tester.binding.setSurfaceSize(const Size(1000, 1100));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final profile = memberProfile()..role = admin ? 'admin' : 'member';
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileProvider.overrideWith((ref) async => profile),
          equipmentProvider.overrideWith(
            (ref) async => [
              SocietyEquipment(
                id: 5,
                societyId: 1,
                equipmentId: 2,
                label: 'Dumbbell rack',
                quantity: 2,
                status: 'available',
                locationLabel: 'Ground floor',
              ),
            ],
          ),
          issuesProvider.overrideWith((ref) async => []),
        ],
        child: const MaterialApp(home: Scaffold(body: EquipmentScreen())),
      ),
    );
    await tester.pumpAndSettle();
  }

  final equipmentTypes = [
    EquipmentCatalog(
      id: 2,
      name: 'Dumbbells',
      category: 'strength',
      description: 'Free weights',
    ),
    EquipmentCatalog(
      id: 3,
      name: 'Treadmill',
      category: 'cardio',
      description: 'Running',
    ),
  ];

  testWidgets('members can report equipment but cannot add or edit', (
    tester,
  ) async {
    await equipmentScreen(tester, admin: false);
    expect(find.text('Report issue'), findsOneWidget);
    expect(find.text('Add equipment'), findsNothing);
    expect(find.text('Edit equipment'), findsNothing);
  });

  testWidgets('admin equipment form validates then saves entered values', (
    tester,
  ) async {
    Map<String, dynamic>? saved;
    fake.handle = (endpoint, method, args) async {
      expect(endpoint, 'equipment');
      if (method == 'catalog') return equipmentTypes;
      expect(method, 'save');
      saved = args;
      return SocietyEquipment(
        id: 6,
        societyId: 1,
        equipmentId: args['catalogId'],
        label: args['label'],
        quantity: args['quantity'],
        status: args['status'],
        locationLabel: args['location'],
      );
    };
    await equipmentScreen(tester);
    await tester.tap(find.text('Add equipment'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save equipment'));
    await tester.pumpAndSettle();
    expect(find.text('Enter an equipment name.'), findsOneWidget);
    expect(find.text('Enter the equipment location.'), findsOneWidget);
    expect(saved, isNull);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Equipment name'),
      '  Free weights B  ',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Quantity'),
      '101',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Location'),
      '  First floor  ',
    );
    await tester.tap(find.text('Save equipment'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a whole number from 0 to 100.'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextFormField, 'Quantity'), '4');
    await tester.tap(find.text('Save equipment'));
    await tester.pumpAndSettle();
    expect(saved, {
      'id': null,
      'catalogId': 2,
      'label': 'Free weights B',
      'quantity': 4,
      'status': 'available',
      'location': 'First floor',
    });
    expect(find.text('Equipment added to your gym.'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets(
    'equipment edit preserves input after a failed save and retries',
    (tester) async {
      var attempts = 0;
      Map<String, dynamic>? saved;
      fake.handle = (endpoint, method, args) async {
        if (method == 'catalog') return equipmentTypes;
        expect('$endpoint.$method', 'equipment.save');
        attempts++;
        if (attempts == 1) {
          throw GymException(message: 'Unable to save equipment.');
        }
        saved = args;
        return SocietyEquipment(
          id: 5,
          societyId: 1,
          equipmentId: 2,
          label: args['label'],
          quantity: args['quantity'],
          status: args['status'],
          locationLabel: args['location'],
        );
      };
      await equipmentScreen(tester);
      await tester.tap(find.text('Edit equipment'));
      await tester.pumpAndSettle();
      expect(find.text('Dumbbell rack'), findsNWidgets(2));
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Quantity'),
        '3',
      );
      await tester.tap(find.text('Save equipment'));
      await tester.pumpAndSettle();
      expect(find.text('Unable to save equipment.'), findsOneWidget);
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.widgetWithText(TextFormField, '3'), findsOneWidget);
      await tester.tap(find.text('Save equipment'));
      await tester.pumpAndSettle();
      expect(saved?['id'], 5);
      expect(saved?['quantity'], 3);
      expect(find.text('Equipment updated.'), findsOneWidget);
    },
  );

  testWidgets(
    'equipment catalog failure offers retry without losing the dialog',
    (tester) async {
      var calls = 0;
      fake.handle = (_, method, _) async {
        expect(method, 'catalog');
        if (calls++ == 0) throw StateError('transport failed');
        return equipmentTypes;
      };
      await equipmentScreen(tester);
      await tester.tap(find.text('Add equipment'));
      await tester.pumpAndSettle();
      expect(find.text('Retry equipment types'), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'Save equipment'),
            )
            .onPressed,
        isNull,
      );
      await tester.tap(find.text('Retry equipment types'));
      await tester.pumpAndSettle();
      expect(find.text('Equipment name'), findsOneWidget);
      expect(calls, 2);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    },
  );
}
