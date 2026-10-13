import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gymos2_client/gymos2_client.dart';
import '../../client.dart';
import '../../core/widgets.dart';
import '../../core/providers.dart';
import '../../app/theme.dart';
import 'directions.dart';
import 'event_map_widget.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});
  @override
  ConsumerState<DiscoverScreen> createState() => _State();
}

class _State extends ConsumerState<DiscoverScreen> {
  static const categories = [
    'all',
    'running',
    'cycling',
    'yoga',
    'fitness',
    'sports',
  ];
  String category = 'all', city = 'Bengaluru';
  bool map = false, goingOnly = false;
  LatLng? position;
  String? selectedEventId;
  final cityInput = TextEditingController(text: 'Bengaluru');
  @override
  void dispose() {
    cityInput.dispose();
    super.dispose();
  }

  void search(String value) => setState(() {
    city = value.trim();
    cityInput.text = city;
    selectedEventId = null;
  });

  Future<void> locate() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Location is optional. You can still browse your community and enter a city.',
              ),
            ),
          );
        }
        return;
      }
      final p = await Geolocator.getCurrentPosition().timeout(
        const Duration(seconds: 15),
      );
      if (mounted) {
        setState(() => position = LatLng(p.latitude, p.longitude));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not get your location. Browse by city instead.',
            ),
          ),
        );
      }
    }
  }

  Future<void> showDirections(Uri? uri) async {
    if (uri == null) return;
    if (await openDirections(uri) || !mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Could not open directions. Try again later.'),
      ),
    );
  }

  Future<void> openSource(ExternalEventCache e) async {
    setState(() => selectedEventId = 'external-${e.id}');
    final ok = await launchUrl(
      Uri.parse(e.sourceUrl),
      mode: LaunchMode.externalApplication,
    ).catchError((_) => false);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the event page.')),
      );
    }
  }

  VoidCallback? directionsFor(ExternalEventCache e) {
    final uri = directionsUri(
      latitude: e.latitude ?? double.nan,
      longitude: e.longitude ?? double.nan,
      venueLabel: e.venueLabel,
    );
    return uri == null ? null : () => showDirections(uri);
  }

  String? distance(double? lat, double? lng) {
    if (position == null ||
        lat == null ||
        lng == null ||
        !hasUsableCoordinates(lat, lng)) {
      return null;
    }
    final km =
        Geolocator.distanceBetween(
          position!.latitude,
          position!.longitude,
          lat,
          lng,
        ) /
        1000;
    return '${km.toStringAsFixed(km < 10 ? 1 : 0)} km away';
  }

  Future<void> detail(CommunityEvent e, bool joined, int count) async {
    setState(() => selectedEventId = 'community-${e.id}');
    final (icon, color) = GymTheme.category(e.category);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 640),
      builder: (c) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconBadge(icon, color: color, size: 52),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StatusPill(
                          e.isDemo ? 'DEMO COMMUNITY EVENT' : 'GYMOS COMMUNITY',
                          color: e.isDemo ? GymTheme.orange : color,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          e.title,
                          style: Theme.of(c).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(e.description, style: const TextStyle(height: 1.6)),
              const SizedBox(height: 18),
              _InfoLine(Icons.schedule_rounded, friendlyDate(e.startsAt)),
              _InfoLine(Icons.place_outlined, e.venueLabel),
              if (distance(e.latitude, e.longitude) case final d?)
                _InfoLine(Icons.near_me_outlined, d),
              const SizedBox(height: 10),
              MetricBar(
                label: '$count of ${e.capacity} going',
                trailing: count >= e.capacity
                    ? 'FULL'
                    : '${e.capacity - count} SPOTS LEFT',
                value: e.capacity == 0 ? 0 : count / e.capacity,
                color: count >= e.capacity ? GymTheme.coral : color,
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: () async {
                      try {
                        await client.event.join(e.id!, !joined);
                        ref.invalidate(discoverProvider);
                        ref.invalidate(dashboardProvider);
                        if (c.mounted) Navigator.pop(c);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                joined
                                    ? 'You left ${e.title}.'
                                    : 'You’re going to ${e.title}!',
                              ),
                            ),
                          );
                        }
                      } catch (error) {
                        if (c.mounted) {
                          ScaffoldMessenger.of(c).showSnackBar(
                            SnackBar(content: Text(errorText(error))),
                          );
                        }
                      }
                    },
                    icon: Icon(
                      joined ? Icons.logout_rounded : Icons.how_to_reg_rounded,
                    ),
                    label: Text(
                      joined ? 'Leave event' : 'Join community event',
                    ),
                  ),
                  if (directionsUri(
                        latitude: e.latitude,
                        longitude: e.longitude,
                        venueLabel: e.venueLabel,
                      )
                      case final uri?)
                    OutlinedButton.icon(
                      onPressed: () => showDirections(uri),
                      icon: const Icon(Icons.directions_outlined),
                      label: const Text('Get Directions'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> create() async {
    final title = TextEditingController(),
        description = TextEditingController(),
        venue = TextEditingController(),
        lat = TextEditingController(text: '12.9716'),
        lng = TextEditingController(text: '77.5946'),
        capacity = TextEditingController(text: '20');
    DateTime start = DateTime.now().add(const Duration(days: 1));
    String type = 'fitness';
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => StatefulBuilder(
        builder: (c, set) => AlertDialog(
          title: const Text('Bring your community together'),
          content: SizedBox(
            width: 460,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: title,
                    decoration: const InputDecoration(labelText: 'Event title'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: description,
                    maxLines: 2,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: venue,
                    decoration: const InputDecoration(labelText: 'Venue'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: lat,
                          decoration: const InputDecoration(
                            labelText: 'Latitude',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: lng,
                          decoration: const InputDecoration(
                            labelText: 'Longitude',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: capacity,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Capacity'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Category',
                    style: TextStyle(color: GymTheme.muted, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final s in categories.skip(1))
                        ChoiceChip(
                          avatar: Icon(GymTheme.category(s).$1, size: 16),
                          label: Text(titleCase(s)),
                          selected: type == s,
                          onSelected: (_) => set(() => type = s),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: c,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        initialDate: start,
                      );
                      if (c.mounted && date != null) {
                        final time = await showTimePicker(
                          context: c,
                          initialTime: TimeOfDay.fromDateTime(start),
                        );
                        if (time != null) {
                          set(
                            () => start = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            ),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.event_rounded),
                    label: Text('Starts ${friendlyDate(start)} · 1 hour'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(c, true),
              child: const Text('Create event'),
            ),
          ],
        ),
      ),
    );
    if (ok == true && mounted) {
      final e = await guarded(
        context,
        () => client.event.create(
          title.text,
          description.text,
          type,
          start,
          start.add(const Duration(hours: 1)),
          double.tryParse(lat.text) ?? double.nan,
          double.tryParse(lng.text) ?? double.nan,
          venue.text,
          int.tryParse(capacity.text) ?? 0,
        ),
      );
      if (e != null) ref.invalidate(discoverProvider);
    }
    for (final x in [title, description, venue, lat, lng, capacity]) {
      x.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = (city: city, category: category);
    final admin = ref.watch(profileProvider).value?.role == 'admin';
    final data = ref.watch(discoverProvider(query));
    final supported = data.value?.supportedCities ?? const <String>[];
    return PageBody(
      children: [
        PageTitle(
          'Find your people',
          'Movement is better together.',
          'Community sessions from your gym plus fitness listings nearby.',
          action: admin
              ? IconButton.filled(
                  tooltip: 'Create community event',
                  onPressed: create,
                  icon: const Icon(Icons.add_rounded),
                )
              : null,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: cityInput,
                onSubmitted: search,
                decoration: InputDecoration(
                  hintText: 'Browse a city',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: IconButton(
                    tooltip: 'Search city',
                    onPressed: () => search(cityInput.text),
                    icon: const Icon(Icons.arrow_forward_rounded),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton.filledTonal(
              tooltip: 'Use my location',
              onPressed: locate,
              icon: Icon(
                position == null
                    ? Icons.my_location_rounded
                    : Icons.gps_fixed_rounded,
              ),
            ),
          ],
        ),
        if (supported.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text(
                'Live listings:',
                style: TextStyle(color: GymTheme.subtle, fontSize: 12.5),
              ),
              for (final c in supported)
                ActionChip(
                  avatar: const Icon(
                    Icons.public_rounded,
                    size: 15,
                    color: GymTheme.sky,
                  ),
                  label: Text(c),
                  onPressed: () => search(c),
                ),
            ],
          ),
        ],
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final c in categories)
                    ChoiceChip(
                      avatar: c == 'all'
                          ? null
                          : Icon(
                              GymTheme.category(c).$1,
                              size: 16,
                              color: category == c
                                  ? GymTheme.bg
                                  : GymTheme.category(c).$2,
                            ),
                      showCheckmark: false,
                      label: Text(titleCase(c)),
                      labelStyle: TextStyle(
                        color: category == c ? GymTheme.bg : GymTheme.text,
                        fontWeight: FontWeight.w600,
                      ),
                      selected: category == c,
                      onSelected: (_) => setState(() {
                        category = c;
                        selectedEventId = null;
                      }),
                    ),
                  FilterChip(
                    label: const Text('Going'),
                    avatar: const Icon(Icons.how_to_reg_rounded, size: 16),
                    selected: goingOnly,
                    labelStyle: TextStyle(
                      color: goingOnly ? GymTheme.bg : GymTheme.text,
                      fontWeight: FontWeight.w600,
                    ),
                    onSelected: (v) => setState(() => goingOnly = v),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: false,
                  icon: Icon(Icons.view_agenda_outlined, size: 18),
                  label: Text('List'),
                ),
                ButtonSegment(
                  value: true,
                  icon: Icon(Icons.map_outlined, size: 18),
                  label: Text('Map'),
                ),
              ],
              selected: {map},
              onSelectionChanged: (v) => setState(() => map = v.first),
            ),
          ],
        ),
        const SizedBox(height: 22),
        AsyncPanel(
          value: data,
          retry: () => ref.invalidate(discoverProvider(query)),
          builder: (d) {
            final counts = d.participantCounts ?? const <int, int>{};
            final community = goingOnly
                ? d.community
                      .where((e) => d.joinedEventIds.contains(e.id))
                      .toList()
                : d.community;
            final mapItems = [
              for (final e in community)
                EventMapItem(
                  id: 'community-${e.id}',
                  title: e.title,
                  category: e.category,
                  startsAt: e.startsAt,
                  venueLabel: e.venueLabel,
                  latitude: e.latitude,
                  longitude: e.longitude,
                  isExternal: false,
                ),
              if (!goingOnly)
                for (final e in d.externalEvents)
                  EventMapItem(
                    id: 'external-${e.id}',
                    title: e.title,
                    category: e.category,
                    startsAt: e.startsAt,
                    venueLabel: e.venueLabel,
                    latitude: e.latitude ?? double.nan,
                    longitude: e.longitude ?? double.nan,
                    isExternal: true,
                  ),
            ];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (map) ...[
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width > 900 ? 460 : 380,
                    child: EventMapWidget(
                      key: ValueKey('$city-$category-$goingOnly'),
                      city: city,
                      events: mapItems,
                      selectedId: selectedEventId,
                      userPosition: position,
                      onSelect: (item) => setState(
                        () => selectedEventId = selectedEventId == item.id
                            ? null
                            : item.id,
                      ),
                      onOpen: (item) {
                        for (final e in d.community) {
                          if (item.id == 'community-${e.id}') {
                            detail(
                              e,
                              d.joinedEventIds.contains(e.id),
                              counts[e.id] ?? 0,
                            );
                            return;
                          }
                        }
                        for (final e in d.externalEvents) {
                          if (item.id == 'external-${e.id}') {
                            openSource(e);
                            return;
                          }
                        }
                      },
                      onDirections: (item) =>
                          showDirections(item.directionsUrl),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      _LegendDot(GymTheme.accent, 'GymOS community'),
                      SizedBox(width: 18),
                      _LegendDot(GymTheme.sky, 'External listing'),
                    ],
                  ),
                ],
                SectionTitle(
                  'In your community',
                  icon: Icons.groups_2_outlined,
                  action: StatusPill(
                    '${community.length} UPCOMING',
                    color: GymTheme.muted,
                  ),
                ),
                if (community.isEmpty)
                  EmptyCard(
                    icon: Icons.groups_outlined,
                    title: goingOnly
                        ? 'No joined events yet'
                        : 'Room for something good',
                    message: goingOnly
                        ? 'Join a community event and it will show up here.'
                        : 'There are no upcoming community events in this category.',
                  )
                else
                  AdaptiveGrid(
                    minTileWidth: 320,
                    children: [
                      for (final e in community)
                        _CommunityCard(
                          event: e,
                          joined: d.joinedEventIds.contains(e.id),
                          count: counts[e.id] ?? 0,
                          distance: distance(e.latitude, e.longitude),
                          selected: selectedEventId == 'community-${e.id}',
                          onOpen: () => detail(
                            e,
                            d.joinedEventIds.contains(e.id),
                            counts[e.id] ?? 0,
                          ),
                        ),
                    ],
                  ),
                if (!goingOnly) ...[
                  const SectionTitle(
                    'Beyond your community',
                    icon: Icons.public_rounded,
                  ),
                  _ProviderBanner(
                    state: d.providerState,
                    status: d.providerStatus,
                    city: city,
                  ),
                  const SizedBox(height: 14),
                  if (d.externalEvents.isNotEmpty)
                    AdaptiveGrid(
                      minTileWidth: 300,
                      children: [
                        for (final e in d.externalEvents)
                          _ExternalCard(
                            event: e,
                            distance: distance(e.latitude, e.longitude),
                            selected: selectedEventId == 'external-${e.id}',
                            onOpen: () => openSource(e),
                            onDirections: directionsFor(e),
                          ),
                      ],
                    ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoLine(this.icon, this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Icon(icon, size: 17, color: GymTheme.subtle),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: const TextStyle(color: GymTheme.muted)),
        ),
      ],
    ),
  );
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot(this.color, this.label);
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2),
        ),
      ),
      const SizedBox(width: 6),
      Text(
        label,
        style: const TextStyle(color: GymTheme.muted, fontSize: 12),
      ),
    ],
  );
}

class _ProviderBanner extends StatelessWidget {
  final String state, status, city;
  const _ProviderBanner({
    required this.state,
    required this.status,
    required this.city,
  });
  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = switch (state) {
      'live' => ('LIVE · ALLEVENTS', GymTheme.accent, Icons.bolt_rounded),
      'cached' => ('CACHED · ALLEVENTS', GymTheme.sky, Icons.cached_rounded),
      'stale' => (
        'OFFLINE CACHE',
        GymTheme.orange,
        Icons.cloud_off_rounded,
      ),
      'unavailable' => (
        'UNAVAILABLE',
        GymTheme.coral,
        Icons.error_outline_rounded,
      ),
      'unsupported' => (
        'NOT COVERED',
        GymTheme.muted,
        Icons.travel_explore_rounded,
      ),
      _ => ('NOT CONNECTED', GymTheme.muted, Icons.link_off_rounded),
    };
    return Panel(
      padding: const EdgeInsets.all(18),
      borderColor: color.withValues(alpha: .3),
      child: Row(
        children: [
          IconBadge(icon, color: color, size: 42),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusPill(label, color: color, dot: state == 'live'),
                const SizedBox(height: 8),
                Text(status, style: const TextStyle(color: GymTheme.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityCard extends StatelessWidget {
  final CommunityEvent event;
  final bool joined, selected;
  final int count;
  final String? distance;
  final VoidCallback onOpen;
  const _CommunityCard({
    required this.event,
    required this.joined,
    required this.count,
    required this.distance,
    required this.selected,
    required this.onOpen,
  });
  @override
  Widget build(BuildContext context) {
    final (icon, color) = GymTheme.category(event.category);
    final full = count >= event.capacity;
    return Panel(
      onTap: onOpen,
      borderColor: selected ? color : null,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconBadge(icon, color: color),
              const Spacer(),
              if (joined)
                const StatusPill(
                  'GOING',
                  color: GymTheme.accent,
                  icon: Icons.check_rounded,
                )
              else
                StatusPill(
                  event.isDemo ? 'DEMO EVENT' : 'COMMUNITY',
                  color: event.isDemo ? GymTheme.orange : color,
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(event.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          _InfoLine(Icons.schedule_rounded, friendlyDate(event.startsAt)),
          _InfoLine(
            Icons.place_outlined,
            distance == null
                ? event.venueLabel
                : '${event.venueLabel} · $distance',
          ),
          const SizedBox(height: 6),
          MetricBar(
            label: '$count / ${event.capacity} going',
            trailing: full ? 'FULL' : titleCase(event.category).toUpperCase(),
            value: event.capacity == 0 ? 0 : count / event.capacity,
            color: full ? GymTheme.coral : color,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  joined ? 'You’re going • View event' : 'Explore event →',
                  style: TextStyle(
                    color: joined ? GymTheme.accent : GymTheme.text,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: GymTheme.subtle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Series listings keep their first date, which may be past while later
/// dates are still upcoming.
String _when(ExternalEventCache e) {
  final end = e.endsAt;
  if (e.startsAt.isBefore(DateTime.now()) && end != null) {
    return 'Multiple dates · until ${friendlyDate(end, time: false)}';
  }
  return friendlyDate(e.startsAt);
}

class _ExternalCard extends StatelessWidget {
  final ExternalEventCache event;
  final bool selected;
  final String? distance;
  final VoidCallback onOpen;
  final VoidCallback? onDirections;
  const _ExternalCard({
    required this.event,
    required this.selected,
    required this.distance,
    required this.onOpen,
    required this.onDirections,
  });
  @override
  Widget build(BuildContext context) {
    final (icon, color) = GymTheme.category(event.category);
    final fallback = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: .35), GymTheme.surface],
        ),
      ),
      child: Center(
        child: Icon(icon, size: 44, color: color.withValues(alpha: .8)),
      ),
    );
    return Panel(
      onTap: onOpen,
      borderColor: selected ? GymTheme.sky : null,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(GymTheme.radius - 1),
            ),
            child: SizedBox(
              height: 130,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (event.imageUrl == null)
                    fallback
                  else
                    Image.network(
                      event.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => fallback,
                    ),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: GymTheme.bg.withValues(alpha: .8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(icon, size: 14, color: color),
                            const SizedBox(width: 6),
                            Text(
                              titleCase(event.category),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                _InfoLine(Icons.schedule_rounded, _when(event)),
                if (event.venueLabel.isNotEmpty)
                  _InfoLine(
                    Icons.place_outlined,
                    distance == null
                        ? event.venueLabel
                        : '${event.venueLabel} · $distance',
                  ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const StatusPill('ALLEVENTS', color: GymTheme.sky),
                    if (event.organizerName != null) ...[
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event.organizerName!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: GymTheme.subtle,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ] else
                      const Spacer(),
                    if (onDirections != null)
                      IconButton(
                        tooltip: 'Get Directions to ${event.title}',
                        onPressed: onDirections,
                        icon: const Icon(Icons.directions_outlined),
                      ),
                    const Icon(
                      Icons.open_in_new_rounded,
                      size: 18,
                      color: GymTheme.subtle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
