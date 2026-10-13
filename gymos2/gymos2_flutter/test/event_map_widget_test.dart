import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymos2_flutter/features/events/directions.dart';
import 'package:gymos2_flutter/features/events/event_map_widget.dart';

final _eventTime = DateTime.utc(2026, 10, 13, 9);

EventMapItem _event(
  String id,
  String title, {
  double latitude = 12.9716,
  double longitude = 77.5946,
  bool isExternal = false,
}) => EventMapItem(
  id: id,
  title: title,
  category: 'running',
  startsAt: _eventTime,
  venueLabel: 'Cubbon Park, Bengaluru',
  latitude: latitude,
  longitude: longitude,
  isExternal: isExternal,
);

void main() {
  testWidgets('multiple markers select their event and show its actions', (
    tester,
  ) async {
    final community = _event('community-1', 'Park run');
    final external = _event(
      'external-2',
      'City ride',
      latitude: 12.945,
      longitude: 77.625,
      isExternal: true,
    );
    String? selectedId;
    String? openedId;
    String? directionsId;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 700,
            height: 380,
            child: StatefulBuilder(
              builder: (context, setState) => EventMapWidget(
                city: 'Bengaluru',
                events: [community, external],
                selectedId: selectedId,
                showTiles: false,
                onSelect: (event) => setState(
                  () => selectedId = selectedId == event.id ? null : event.id,
                ),
                onOpen: (event) => openedId = event.id,
                onDirections: (event) => directionsId = event.id,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('2 on map'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('map-marker-community-1')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('map-marker-external-2')), findsOneWidget);

    await tester.tap(
      find.byKey(const ValueKey('map-marker-button-community-1')),
    );
    await tester.pump();
    expect(selectedId, 'community-1');
    expect(find.text('Park run'), findsOneWidget);
    expect(find.text('IN YOUR COMMUNITY'), findsOneWidget);
    await tester.tap(find.text('View event →'));
    expect(openedId, 'community-1');
    await tester.tap(find.text('Get Directions'));
    expect(directionsId, 'community-1');

    await tester.tap(
      find.byKey(const ValueKey('map-marker-button-community-1')),
    );
    await tester.pump();
    expect(selectedId, isNull);

    await tester.tap(
      find.byKey(const ValueKey('map-marker-button-external-2')),
    );
    await tester.pump();
    expect(selectedId, 'external-2');
    expect(find.text('City ride'), findsOneWidget);
    expect(find.text('BEYOND YOUR COMMUNITY'), findsOneWidget);
    await tester.tap(find.text('Open source ↗'));
    expect(openedId, 'external-2');
  });

  testWidgets('empty and unusable coordinates show the map empty state', (
    tester,
  ) async {
    Future<void> show(List<EventMapItem> events) => tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 700,
            height: 380,
            child: EventMapWidget(
              city: 'Bengaluru',
              events: events,
              selectedId: null,
              showTiles: false,
              onSelect: (_) {},
              onOpen: (_) {},
              onDirections: (_) {},
            ),
          ),
        ),
      ),
    );

    await show([]);
    await tester.pump();
    expect(find.text('0 on map'), findsOneWidget);
    expect(
      find.text(
        'No event locations available here. Events remain in the list.',
      ),
      findsOneWidget,
    );
    expect(find.text('© OpenStreetMap contributors'), findsOneWidget);

    await show([
      _event('community-1', 'Missing coordinates', latitude: double.nan),
      _event('external-2', 'Outside map', latitude: 91),
      _event('community-3', 'Zero coordinates', latitude: 0, longitude: 0),
    ]);
    await tester.pump();
    expect(find.text('0 on map'), findsOneWidget);
    expect(find.byKey(const ValueKey('map-marker-community-1')), findsNothing);
    expect(find.byKey(const ValueKey('map-marker-external-2')), findsNothing);
    expect(find.byKey(const ValueKey('map-marker-community-3')), findsNothing);
    expect(
      find.text(
        'No event locations available here. Events remain in the list.',
      ),
      findsOneWidget,
    );
  });

  test('directions URI uses coordinates or an encoded venue', () {
    final coordinates = directionsUri(
      latitude: 12.9716,
      longitude: 77.5946,
      venueLabel: 'Ignored venue',
    )!;
    expect(coordinates.scheme, 'https');
    expect(coordinates.host, 'www.google.com');
    expect(coordinates.path, '/maps/dir/');
    expect(coordinates.queryParameters, {
      'api': '1',
      'destination': '12.9716,77.5946',
    });

    final venue = directionsUri(
      latitude: double.nan,
      longitude: 77.5946,
      venueLabel: '  Cubbon Park, Bengaluru  ',
    )!;
    expect(venue.queryParameters['destination'], 'Cubbon Park, Bengaluru');
    expect(venue.toString(), isNot(contains(' ')));
    expect(venue.toString(), contains('%2C'));
    expect(
      directionsUri(latitude: double.nan, longitude: 0, venueLabel: '  '),
      isNull,
    );
    expect(
      directionsUri(latitude: double.nan, longitude: 0, venueLabel: 'Online'),
      isNull,
    );
  });
}
