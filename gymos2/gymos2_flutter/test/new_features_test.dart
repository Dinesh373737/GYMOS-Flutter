import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymos2_client/gymos2_client.dart';
import 'package:gymos2_flutter/app/app.dart';
import 'package:gymos2_flutter/core/providers.dart';
import 'package:gymos2_flutter/features/admin/admin_screen.dart';
import 'package:gymos2_flutter/features/events/discover_screen.dart';

import 'support/fixtures.dart';

AdminStats stats() => AdminStats(
  society: Society(
    id: 1,
    name: 'Demo community',
    addressLabel: 'Bengaluru',
    inviteCode: 'GYM-123',
    createdBy: 'admin',
    createdAt: fixtureTime,
    isActive: true,
  ),
  memberCount: 3,
  activeMembers: 2,
  adminCount: 1,
  equipmentTotal: 15,
  equipmentAvailable: 14,
  equipmentMaintenance: 1,
  equipmentUnavailable: 0,
  openIssues: 2,
  inProgressIssues: 1,
  resolvedIssues30d: 4,
  highSeverityOpen: 1,
  upcomingEvents: 3,
  eventParticipants: 5,
  workoutsThisWeek: 6,
  activeTrainersThisWeek: 2,
  dailyWorkouts: List.filled(14, 1),
);

void main() {
  group('auth redirect', () {
    test('signed-out users are sent to sign in from any page', () {
      expect(authRedirect(false, '/home'), '/auth');
      expect(authRedirect(false, '/admin'), '/auth');
      expect(authRedirect(false, '/auth'), isNull);
    });
    test('signed-in users skip the sign-in page only', () {
      expect(authRedirect(true, '/auth'), '/home');
      expect(authRedirect(true, '/discover'), isNull);
    });
  });

  Future<void> pump(
    WidgetTester tester,
    Widget child,
    List overrides, {
    Size size = const Size(1200, 1600),
  }) async {
    await tester.binding.setSurfaceSize(size);
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [...overrides],
        child: MaterialApp(home: Scaffold(body: child)),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('admin dashboard is hidden from residents', (tester) async {
    await pump(tester, const AdminScreen(), [
      profileProvider.overrideWith((ref) async => memberProfile()),
    ]);
    expect(find.text('Admins only'), findsOneWidget);
    expect(find.text('Active members'), findsNothing);
  });

  testWidgets('admin dashboard shows society aggregates and members', (
    tester,
  ) async {
    await pump(tester, const AdminScreen(), [
      profileProvider.overrideWith(
        (ref) async => memberProfile()..role = 'admin',
      ),
      adminStatsProvider.overrideWith((ref) async => stats()),
      membersProvider.overrideWith(
        (ref) async => [
          MemberSummary(
            profileId: 1,
            displayName: 'Alex',
            role: 'admin',
            isActive: true,
            joinedAt: fixtureTime,
            workoutsLast30Days: 4,
          ),
          MemberSummary(
            profileId: 2,
            displayName: 'Riley',
            role: 'resident',
            isActive: false,
            joinedAt: fixtureTime,
            workoutsLast30Days: 0,
          ),
        ],
      ),
    ]);
    expect(find.text('Active members'), findsOneWidget);
    expect(find.text('14/15'), findsOneWidget);
    expect(find.text('1 high'), findsOneWidget);
    expect(find.text('GYM-123'), findsOneWidget);
    expect(find.text('YOU'), findsOneWidget);
    expect(find.text('PAUSED'), findsOneWidget);
    // The signed-in admin cannot pause their own membership.
    final switches = tester.widgetList<Switch>(find.byType(Switch)).toList();
    expect(switches.first.onChanged, isNull);
    expect(switches.last.onChanged, isNotNull);
  });

  DiscoverData events(String state, String status) => DiscoverData(
    community: [],
    externalEvents: [
      ExternalEventCache(
        id: 7,
        provider: 'allevents',
        providerEventId: 'e7',
        queryKey: 'london',
        title: 'Riverside 10K',
        category: 'running',
        startsAt: fixtureTime.add(const Duration(days: 2)),
        venueLabel: '',
        sourceUrl: 'https://allevents.in/london/example/7',
        rawHash: 'x',
        fetchedAt: fixtureTime,
        expiresAt: fixtureTime.add(const Duration(hours: 6)),
      ),
    ],
    joinedEventIds: [],
    providerStatus: status,
    providerState: state,
    supportedCities: ['London', 'New York', 'Tokyo'],
  );

  for (final (state, label) in [
    ('live', 'LIVE · ALLEVENTS'),
    ('stale', 'OFFLINE CACHE'),
  ]) {
    testWidgets('discover labels $state external listings honestly', (
      tester,
    ) async {
      await pump(tester, const DiscoverScreen(), [
        profileProvider.overrideWith((ref) async => memberProfile()),
        discoverProvider.overrideWith(
          (ref, q) async => events(state, 'Status for $state'),
        ),
      ]);
      expect(find.text(label), findsOneWidget);
      expect(find.text('Status for $state'), findsOneWidget);
      expect(find.text('Riverside 10K'), findsOneWidget);
      expect(find.text('ALLEVENTS'), findsOneWidget);
      // No coordinates and no venue: no directions are offered.
      expect(find.byTooltip('Get Directions to Riverside 10K'), findsNothing);
      // Supported cities are offered as shortcuts.
      expect(find.text('Tokyo'), findsOneWidget);
    });
  }

  testWidgets('going filter shows only joined community events', (
    tester,
  ) async {
    CommunityEvent event(int id, String title) => CommunityEvent(
      id: id,
      societyId: 1,
      organizerUserId: 1,
      title: title,
      description: 'Demo',
      category: 'yoga',
      startsAt: fixtureTime.add(const Duration(days: 1)),
      endsAt: fixtureTime.add(const Duration(days: 1, hours: 1)),
      latitude: 12.97,
      longitude: 77.59,
      venueLabel: 'Park',
      capacity: 10,
      status: 'scheduled',
      isDemo: true,
    );
    await pump(tester, const DiscoverScreen(), [
      profileProvider.overrideWith((ref) async => memberProfile()),
      discoverProvider.overrideWith(
        (ref, q) async => DiscoverData(
          community: [event(1, 'Sunrise flow'), event(2, 'Evening stretch')],
          externalEvents: [],
          joinedEventIds: [2],
          providerStatus: 'n/a',
          participantCounts: {1: 3, 2: 10},
        ),
      ),
    ]);
    expect(find.text('Sunrise flow'), findsOneWidget);
    expect(find.text('3 / 10 going'), findsOneWidget);
    expect(find.text('FULL'), findsOneWidget);
    await tester.tap(find.text('Going'));
    await tester.pumpAndSettle();
    expect(find.text('Sunrise flow'), findsNothing);
    expect(find.text('Evening stretch'), findsOneWidget);
  });

  testWidgets('notification bell shows the unread count', (tester) async {
    await pump(tester, const NotificationBell(), [
      unreadCountProvider.overrideWith((ref) async => 3),
    ]);
    expect(find.text('3'), findsOneWidget);
  });
}
