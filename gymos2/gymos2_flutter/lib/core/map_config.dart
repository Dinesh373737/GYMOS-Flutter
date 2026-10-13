import 'package:latlong2/latlong.dart';

/// Map presentation settings. The tile URL can be changed at build time without
/// changing the Discover UI or requiring a map SDK key.
class MapConfig {
  static const tileUrl = String.fromEnvironment(
    'OSM_TILE_URL',
    defaultValue: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  );
  static const appPackageName = 'com.example.gymos2_flutter';
  static final attributionUrl = Uri.https(
    'www.openstreetmap.org',
    '/copyright',
  );

  static LatLng? cityCenter(String city) => switch (city.trim().toLowerCase()) {
    'bengaluru' || 'bangalore' => const LatLng(12.9716, 77.5946),
    'pune' => const LatLng(18.5204, 73.8567),
    'london' => const LatLng(51.5072, -0.1276),
    'new york' => const LatLng(40.7128, -74.0060),
    'tokyo' => const LatLng(35.6762, 139.6503),
    _ => null,
  };
}
