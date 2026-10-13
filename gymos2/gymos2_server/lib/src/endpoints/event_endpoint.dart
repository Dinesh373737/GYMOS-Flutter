import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

import '../services/access.dart';

import '../services/events/event_cache_service.dart';

class EventEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<DiscoverData> discover(Session s, String city, String category) =>
      discoverFor(s, city, category);

  /// Shared by the endpoint and the coach tool. The coach passes
  /// [allowRefresh] false so a chat turn never waits on the external provider.
  static Future<DiscoverData> discoverFor(
    Session s,
    String city,
    String category, {
    bool allowRefresh = true,
  }) async {
    final p = await Access.profile(s);
    final now = DateTime.now().toUtc();

    final events = await CommunityEvent.db.find(
      s,
      where: (t) =>
          t.societyId.equals(p.societyId) &
          t.status.equals('scheduled') &
          (t.endsAt > now),
      orderBy: (t) => t.startsAt,
    );

    final joined = await EventParticipant.db.find(
      s,
      where: (t) => t.userId.equals(p.id!) & t.status.equals('joined'),
    );

    final counts = <int, int>{};
    if (events.isNotEmpty) {
      for (final x in await EventParticipant.db.find(
        s,
        where: (t) =>
            t.eventId.inSet(events.map((e) => e.id!).toSet()) &
            t.status.equals('joined'),
      )) {
        counts.update(x.eventId, (v) => v + 1, ifAbsent: () => 1);
      }
    }

    final external = await EventCacheService.discover(
      s,
      city,
      allowRefresh: allowRefresh,
    );

    return DiscoverData(
      community: events
          .where((e) => category == 'all' || e.category == category)
          .toList(),
      externalEvents: external.events
          .where((e) => category == 'all' || e.category == category)
          .toList(),
      joinedEventIds: joined.map((e) => e.eventId).toList(),
      providerStatus: external.status,
      providerState: external.state,
      supportedCities: external.supportedCities,
      participantCounts: {
        for (final e in events) e.id!: counts[e.id] ?? 0,
      },
    );
  }

  Future<CommunityEvent> create(
    Session s,
    String title,
    String description,
    String category,
    DateTime start,
    DateTime end,
    double latitude,
    double longitude,
    String venue,
    int capacity,
  ) async {
    final p = await Access.profile(s, admin: true);
    if (!latitude.isFinite ||
        !longitude.isFinite ||
        latitude.abs() > 90 ||
        longitude.abs() > 180 ||
        capacity < 1 ||
        capacity > 10000 ||
        !end.isAfter(start) ||
        start.isBefore(DateTime.now()) ||
        ![
          'running',
          'cycling',
          'yoga',
          'fitness',
          'sports',
        ].contains(category)) {
      throw GymException(
        message: 'Check location, dates, category, and capacity.',
      );
    }

    return CommunityEvent.db.insertRow(
      s,
      CommunityEvent(
        societyId: p.societyId,
        organizerUserId: p.id!,
        title: Access.text(title, max: 100),
        description: Access.text(description),
        category: category,
        startsAt: start.toUtc(),
        endsAt: end.toUtc(),
        latitude: latitude,
        longitude: longitude,
        venueLabel: Access.text(venue, max: 150),
        capacity: capacity,
        status: 'scheduled',
        isDemo: false,
      ),
    );
  }

  Future<int> participantCount(Session s, int id) async {
    final p = await Access.profile(s);
    final e = await CommunityEvent.db.findById(s, id);
    if (e == null || e.societyId != p.societyId) {
      throw GymException(message: 'Event not found.');
    }
    return EventParticipant.db.count(
      s,
      where: (t) => t.eventId.equals(id) & t.status.equals('joined'),
    );
  }

  Future<void> join(Session s, int id, bool join) async {
    final p = await Access.profile(s);

    await s.db.transaction((tx) async {
      final e = await CommunityEvent.db.findById(
        s,
        id,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );

      if (e == null ||
          e.societyId != p.societyId ||
          e.status != 'scheduled' ||
          e.endsAt.isBefore(DateTime.now())) {
        throw GymException(message: 'Event is unavailable.');
      }

      final old = await EventParticipant.db.findFirstRow(
        s,
        where: (t) => t.eventId.equals(id) & t.userId.equals(p.id!),
        transaction: tx,
      );

      if (join &&
          old?.status != 'joined' &&
          await EventParticipant.db.count(
                s,
                where: (t) => t.eventId.equals(id) & t.status.equals('joined'),
                transaction: tx,
              ) >=
              e.capacity) {
        throw GymException(message: 'This event is full.');
      }

      if (old != null) {
        old.status = join ? 'joined' : 'left';
        await EventParticipant.db.updateRow(s, old, transaction: tx);
      } else if (join) {
        await EventParticipant.db.insertRow(
          s,
          EventParticipant(
            eventId: id,
            userId: p.id!,
            joinedAt: DateTime.now().toUtc(),
            status: 'joined',
          ),
          transaction: tx,
        );
      }
    });
  }
}
