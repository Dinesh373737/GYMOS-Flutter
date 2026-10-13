import 'package:url_launcher/url_launcher.dart';

bool hasUsableCoordinates(double latitude, double longitude) =>
    latitude.isFinite &&
    longitude.isFinite &&
    latitude >= -90 &&
    latitude <= 90 &&
    longitude >= -180 &&
    longitude <= 180 &&
    !(latitude == 0 && longitude == 0);

Uri? directionsUri({
  required double latitude,
  required double longitude,
  required String venueLabel,
}) {
  final address = venueLabel.trim();
  const unavailableAddresses = {
    '',
    'tba',
    'to be announced',
    'online',
    'virtual',
    'unknown',
    'not available',
  };
  final destination = hasUsableCoordinates(latitude, longitude)
      ? '$latitude,$longitude'
      : unavailableAddresses.contains(address.toLowerCase())
      ? ''
      : address;
  if (destination.isEmpty) return null;
  return Uri.https('www.google.com', '/maps/dir/', {
    'api': '1',
    'destination': destination,
  });
}

Future<bool> openDirections(Uri uri) async {
  try {
    if (await launchUrl(uri, mode: LaunchMode.externalApplication)) return true;
    return await launchUrl(uri, mode: LaunchMode.platformDefault);
  } catch (_) {
    try {
      return await launchUrl(uri, mode: LaunchMode.platformDefault);
    } catch (_) {
      return false;
    }
  }
}
