import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/theme.dart';
import '../../core/map_config.dart';
import '../../core/widgets.dart';
import 'directions.dart';

class EventMapItem {
  const EventMapItem({
    required this.id,
    required this.title,
    required this.category,
    required this.startsAt,
    required this.venueLabel,
    required this.latitude,
    required this.longitude,
    required this.isExternal,
  });

  final String id;
  final String title;
  final String category;
  final DateTime startsAt;
  final String venueLabel;
  final double latitude;
  final double longitude;
  final bool isExternal;

  LatLng? get point =>
      hasUsableCoordinates(latitude, longitude) && latitude.abs() <= 85.0511
      ? LatLng(latitude, longitude)
      : null;

  Uri? get directionsUrl => directionsUri(
    latitude: latitude,
    longitude: longitude,
    venueLabel: venueLabel,
  );
}

/// A presentation-only map. Event loading and selection stay with Discover.
class EventMapWidget extends StatefulWidget {
  const EventMapWidget({
    super.key,
    required this.city,
    required this.events,
    required this.selectedId,
    required this.onSelect,
    required this.onOpen,
    required this.onDirections,
    this.userPosition,
    this.showTiles = true,
  });

  final String city;
  final List<EventMapItem> events;
  final String? selectedId;
  final ValueChanged<EventMapItem> onSelect;
  final ValueChanged<EventMapItem> onOpen;
  final ValueChanged<EventMapItem> onDirections;
  final LatLng? userPosition;
  @visibleForTesting
  final bool showTiles;

  @override
  State<EventMapWidget> createState() => _EventMapWidgetState();
}

class _EventMapWidgetState extends State<EventMapWidget> {
  final MapController _controller = MapController();
  final NetworkTileProvider _tileProvider = NetworkTileProvider(
    abortObsoleteRequests: false,
  );
  bool _ready = false;
  bool _tilesFailed = false;

  List<EventMapItem> get _placed =>
      widget.events.where((event) => event.point != null).toList();

  String get _locationsKey => widget.events
      .map((e) => '${e.id}:${e.latitude}:${e.longitude}')
      .join('|');

  @override
  void didUpdateWidget(covariant EventMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userPosition != widget.userPosition &&
        widget.userPosition != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _ready) _controller.move(widget.userPosition!, 12);
      });
    } else if (oldWidget.city != widget.city ||
        oldWidget.events
                .map((e) => '${e.id}:${e.latitude}:${e.longitude}')
                .join('|') !=
            _locationsKey) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _ready) _fitEvents();
      });
    }
  }

  void _fitEvents() {
    final points = _placed.map((e) => e.point!).toList();
    if (points.length > 1) {
      _controller.fitCamera(_cameraFit(points));
    } else if (points.length == 1) {
      _controller.move(points.first, 12);
    } else {
      final center = widget.userPosition ?? MapConfig.cityCenter(widget.city);
      _controller.move(center ?? const LatLng(20, 0), center == null ? 2 : 11);
    }
  }

  CameraFit _cameraFit(List<LatLng> points) => CameraFit.coordinates(
    coordinates: points,
    padding: const EdgeInsets.fromLTRB(48, 60, 48, 125),
    maxZoom: 13,
  );

  void _tileError(TileImage _, Object error, StackTrace? stackTrace) {
    if (_tilesFailed) return;
    _tilesFailed = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Community pins use the brand lime; external listings use sky blue.
  Color _markerColor(EventMapItem event) =>
      event.isExternal ? GymTheme.sky : GymTheme.accent;

  @override
  Widget build(BuildContext context) {
    final placed = _placed;
    EventMapItem? selected;
    for (final item in widget.events) {
      if (item.id == widget.selectedId) selected = item;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(GymTheme.radius),
      child: Stack(
        children: [
          FlutterMap(
            mapController: _controller,
            options: MapOptions(
              initialCameraFit: placed.length > 1
                  ? _cameraFit(placed.map((event) => event.point!).toList())
                  : null,
              initialCenter: placed.isNotEmpty
                  ? placed.first.point!
                  : widget.userPosition ??
                        MapConfig.cityCenter(widget.city) ??
                        const LatLng(20, 0),
              initialZoom: placed.isNotEmpty
                  ? 12
                  : MapConfig.cityCenter(widget.city) == null
                  ? 2
                  : 11,
              backgroundColor: GymTheme.surface,
              minZoom: 2,
              maxZoom: 18,
              onMapReady: () {
                _ready = true;
              },
            ),
            children: [
              if (widget.showTiles)
                TileLayer(
                  urlTemplate: MapConfig.tileUrl,
                  userAgentPackageName: MapConfig.appPackageName,
                  tileProvider: _tileProvider,
                  panBuffer: 0,
                  retinaMode: false,
                  errorTileCallback: _tileError,
                  tileBuilder: darkModeTileBuilder,
                ),
              MarkerLayer(
                markers: [
                  for (final event in placed)
                    Marker(
                      key: ValueKey('map-marker-${event.id}'),
                      point: event.point!,
                      width: 56,
                      height: 56,
                      child: Tooltip(
                        message: event.title,
                        child: Semantics(
                          button: true,
                          label: '${event.title} map marker',
                          child: InkWell(
                            key: ValueKey('map-marker-button-${event.id}'),
                            onTap: () => widget.onSelect(event),
                            customBorder: const CircleBorder(),
                            child: Center(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                width: event.id == widget.selectedId ? 50 : 42,
                                height: event.id == widget.selectedId ? 50 : 42,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: event.id == widget.selectedId
                                      ? _markerColor(event)
                                      : GymTheme.bg,
                                  border: Border.all(
                                    color: _markerColor(event),
                                    width: event.id == widget.selectedId
                                        ? 3
                                        : 2,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x66000000),
                                      blurRadius: 12,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  event.isExternal
                                      ? Icons.public
                                      : Icons.groups_2_outlined,
                                  size: 20,
                                  color: event.id == widget.selectedId
                                      ? GymTheme.bg
                                      : _markerColor(event),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 12,
            left: 12,
            child: _MapBadge(
              icon: Icons.place_outlined,
              label: '${placed.length} on map',
            ),
          ),
          if (_tilesFailed)
            const Positioned(
              top: 58,
              left: 12,
              right: 12,
              child: _MapBadge(
                icon: Icons.wifi_off_outlined,
                label: 'Map tiles unavailable. Event pins still work.',
              ),
            ),
          if (placed.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: GymTheme.bg.withValues(alpha: .92),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: GymTheme.line),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'No event locations available here. Events remain in the list.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          if (selected != null)
            Positioned(
              left: 12,
              right: 12,
              bottom: 44,
              child: _SelectedEventCard(
                event: selected,
                onOpen: () => widget.onOpen(selected!),
                onDirections: selected.directionsUrl == null
                    ? null
                    : () => widget.onDirections(selected!),
              ),
            ),
          Positioned(
            left: 10,
            bottom: 8,
            child: Material(
              color: GymTheme.bg.withValues(alpha: .92),
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => launchUrl(
                  MapConfig.attributionUrl,
                  mode: LaunchMode.externalApplication,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    '© OpenStreetMap contributors',
                    style: TextStyle(fontSize: 11, color: GymTheme.accent),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapBadge extends StatelessWidget {
  const _MapBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: GymTheme.bg.withValues(alpha: .92),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: GymTheme.line),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: GymTheme.accent, size: 15),
          const SizedBox(width: 6),
          Flexible(child: Text(label, style: const TextStyle(fontSize: 12))),
        ],
      ),
    ),
  );
}

class _SelectedEventCard extends StatelessWidget {
  const _SelectedEventCard({
    required this.event,
    required this.onOpen,
    required this.onDirections,
  });

  final EventMapItem event;
  final VoidCallback onOpen;
  final VoidCallback? onDirections;

  @override
  Widget build(BuildContext context) => Material(
    color: GymTheme.bg.withValues(alpha: .96),
    borderRadius: BorderRadius.circular(18),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: GymTheme.accent.withValues(alpha: .45)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.isExternal ? 'BEYOND YOUR COMMUNITY' : 'IN YOUR COMMUNITY',
            style: const TextStyle(
              color: GymTheme.accent,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            event.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            '${shortDate(event.startsAt)} • ${event.venueLabel}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: GymTheme.muted, fontSize: 12),
          ),
          if (event.point == null)
            const Text(
              'Map location unavailable',
              style: TextStyle(color: GymTheme.orange, fontSize: 12),
            ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              TextButton(
                onPressed: onOpen,
                child: Text(
                  event.isExternal ? 'Open source ↗' : 'View event →',
                ),
              ),
              if (onDirections != null)
                TextButton.icon(
                  onPressed: onDirections,
                  icon: const Icon(Icons.directions_outlined, size: 17),
                  label: const Text('Get Directions'),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}
