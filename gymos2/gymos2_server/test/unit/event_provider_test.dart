import 'dart:convert';

import 'package:gymos2_server/src/services/events/external_event_provider.dart';
import 'package:gymos2_server/src/services/events/parse_allevents_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

Map<String, dynamic> listing({
  String id = '1001',
  String name = 'Riverside Half Marathon',
  String start = 'Sat, 24 Oct at 09:00 am',
  String end = 'Sat, 24 Oct at 01:00 pm',
  List<String> categories = const ['marathons', 'sports'],
  List<String> tags = const ['Marathon'],
  Object? latitude = '51.507084',
  Object? longitude = '-0.163239',
}) => {
  'event_id': id,
  'name': name,
  'start_time_display': start,
  'end_time_display': end,
  'location': 'Hyde Park',
  'venue': {
    'city': 'London',
    'latitude': latitude,
    'longitude': longitude,
    'full_address': 'Hyde Park, London',
  },
  'event_url': 'https://allevents.in/london/example/$id',
  'banner_url': 'https://cdn-ip.allevents.in/banner.avif',
  'organizer': {'name': 'Example Runners'},
  'categories': categories,
  'tags': tags,
};

void main() {
  final now = DateTime.utc(2026, 10, 14, 8);

  group('Parse.bot allevents normalization', () {
    test('keeps fitness listings with source, venue and coordinates', () {
      final e = ParseAllEventsProvider.normalize(
        listing(),
        'London',
        now: now,
      )!;
      expect(e.category, 'running');
      expect(e.sourceUrl, 'https://allevents.in/london/example/1001');
      expect(e.latitude, closeTo(51.507084, 1e-6));
      expect(e.longitude, closeTo(-0.163239, 1e-6));
      expect(e.organizerName, 'Example Runners');
      // 24 Oct 2026 is still British Summer Time (UTC+1).
      expect(e.startsAt, DateTime.utc(2026, 10, 24, 8));
      expect(e.endsAt, DateTime.utc(2026, 10, 24, 12));
    });

    test('decodes HTML entities in titles', () {
      final e = ParseAllEventsProvider.normalize(
        listing(name: 'Yoga Flow &amp; Sound Bath &#8211; Level&nbsp;1'),
        'London',
        now: now,
      )!;
      expect(e.title, 'Yoga Flow & Sound Bath – Level 1');
    });

    test('never invents coordinates', () {
      for (final coords in [
        (null, null),
        ('', ''),
        ('0', '0'),
        ('91', '10'),
        ('abc', '1'),
      ]) {
        final e = ParseAllEventsProvider.normalize(
          listing(latitude: coords.$1, longitude: coords.$2),
          'London',
          now: now,
        )!;
        expect(e.latitude, isNull);
        expect(e.longitude, isNull);
        expect(e.venueLabel, 'Hyde Park');
      }
    });

    test('drops non-fitness, past, unparsable and unsafe listings', () {
      expect(
        ParseAllEventsProvider.normalize(
          listing(
            name: 'Comedy night',
            categories: ['entertainment'],
            tags: ['Comedy'],
          ),
          'London',
          now: now,
        ),
        isNull,
      );
      expect(
        ParseAllEventsProvider.normalize(
          listing(
            start: 'Sun, 11 Oct at 09:00 am',
            end: 'Sun, 11 Oct at 10:00 am',
          ),
          'London',
          now: now,
        ),
        isNull,
      );
      expect(
        ParseAllEventsProvider.normalize(
          listing(start: 'Date to be announced'),
          'London',
          now: now,
        ),
        isNull,
      );
      expect(
        ParseAllEventsProvider.normalize(
          listing()..['event_url'] = 'javascript:alert(1)',
          'London',
          now: now,
        ),
        isNull,
      );
    });

    test('classifies by keywords before generic provider categories', () {
      expect(
        ParseAllEventsProvider.classify(
          title: 'Sunday Vinyasa Flow',
          categories: ['health-wellness'],
          tags: [],
        ),
        'yoga',
      );
      expect(
        ParseAllEventsProvider.classify(
          title: 'Community Bike Ride',
          categories: ['sports'],
          tags: [],
        ),
        'cycling',
      );
      expect(
        ParseAllEventsProvider.classify(
          title: 'Spa and wellbeing day',
          categories: ['health-wellness'],
          tags: [],
        ),
        isNull,
      );
      // "run" must match as a word, not inside "brunch".
      expect(
        ParseAllEventsProvider.classify(
          title: 'Bottomless brunch',
          categories: ['food-drinks'],
          tags: [],
        ),
        isNull,
      );
    });

    test('converts city wall-clock times and rolls the year forward', () {
      DateTime? parse(String text, String city, [DateTime? at]) =>
          ParseAllEventsProvider.parseDisplayTime(text, city, now: at ?? now);
      // BST ends at 02:00 local on 25 Oct 2026.
      expect(
        parse('Sun, 25 Oct at 09:00 am', 'London'),
        DateTime.utc(2026, 10, 25, 9),
      );
      expect(
        parse('Sat, 7 Nov at 6:30 pm', 'New York'),
        DateTime.utc(2026, 11, 7, 23, 30),
      );
      expect(
        parse('Thu, 15 Oct at 07:00 am', 'New York'),
        DateTime.utc(2026, 10, 15, 11),
      );
      expect(
        parse('Fri, 16 Oct at 12:00 am', 'Tokyo'),
        DateTime.utc(2026, 10, 15, 15),
      );
      expect(
        parse('Sat, 9 Jan at 08:00 am', 'London'),
        DateTime.utc(2027, 1, 9, 8),
      );
      expect(
        parse('Mon, 4 Jan 2027 at 10:15 am', 'London'),
        DateTime.utc(2027, 1, 4, 10, 15),
      );
    });
  });

  group('Parse.bot transport', () {
    test(
      'sends the server credential, merges categories and dedupes',
      () async {
        final requested = <String>[];
        final provider = ParseAllEventsProvider(
          'test-key',
          transport: MockClient((request) async {
            expect(request.headers['X-API-Key'], 'test-key');
            expect(request.url.queryParameters['city'], 'London');
            requested.add(request.url.queryParameters['category']!);
            return http.Response(
              jsonEncode({
                'status': 'success',
                'data': {
                  'events': [
                    listing(),
                    listing(
                      id: '1002',
                      name: 'Morning Yoga in the Park',
                      categories: ['health-wellness', 'yoga'],
                      tags: ['Yoga'],
                    ),
                  ],
                },
              }),
              200,
            );
          }),
        );
        final events = await provider.search('London', now: now);
        expect(requested, unorderedEquals(['sports', 'health-wellness']));
        expect(events.map((e) => e.providerEventId), ['1001', '1002']);
      },
    );

    test('maps quota and rate limits to retryable provider errors', () async {
      Future<ExternalProviderException> failure(http.Response r) async {
        final provider = ParseAllEventsProvider(
          'k',
          transport: MockClient((_) async => r),
        );
        try {
          await provider.search('London', now: now);
        } on ExternalProviderException catch (e) {
          return e;
        }
        fail('expected a provider exception');
      }

      final limited = await failure(
        http.Response('', 429, headers: {'retry-after': '120'}),
      );
      expect(limited.retryAfter, const Duration(seconds: 120));
      final quota = await failure(http.Response('', 402));
      expect(quota.retryAfter, const Duration(hours: 6));
      final broken = await failure(http.Response('not json', 200));
      expect(broken.message, contains('unexpected'));
    });
  });
}
