import 'package:flutter/foundation.dart';
import 'package:gymos2_client/gymos2_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// When you are running the app on a physical device, you need to set the
// server URL to the IP address of your computer. You can find the IP
// address by running `ipconfig` on Windows or `ifconfig` on Mac/Linux.
//
// You can set the variable when running or building your app like this:
// E.g. `flutter run --dart-define=SERVER_URL=https://api.example.com/`.
//
// Otherwise, the server URL is fetched from the assets/config.json file or
// defaults to http://$localhost:8080/ if not found.
//
// On phones the address can also be changed in the app (see
// [switchServer]); a saved address takes precedence over the built-in one.
final serverUrl = getServerUrl();

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
/// In a larger app, you may want to use the dependency injection of your choice
/// instead of using a global client object. This is just a simple example.
late Client client;

/// The API address [client] currently talks to.
String activeServerUrl = '';

/// Incremented after [switchServer] so the widget tree and providers restart
/// against the new client.
final appGeneration = ValueNotifier(0);

const _serverUrlKey = 'gymos.serverUrl';

/// Phones reach the server over the network, so its address is editable
/// there. Web builds always use the server that served them.
bool get serverAddressEditable => !kIsWeb;

Future<void> initializeClient() async {
  activeServerUrl = await _resolveServerUrl();
  client =
      Client(
          activeServerUrl,
          // A coach turn can include several sequential provider requests.
          connectionTimeout: const Duration(seconds: 90),
        )
        ..connectivityMonitor = FlutterConnectivityMonitor()
        ..authSessionManager = FlutterAuthSessionManager();
  await client.auth.initialize();
}

Future<String> _resolveServerUrl() async {
  if (serverAddressEditable) {
    try {
      final saved = (await SharedPreferences.getInstance()).getString(
        _serverUrlKey,
      );
      if (saved != null && saved.isNotEmpty) return saved;
    } catch (_) {
      // Fall back to the built-in address if preferences are unavailable.
    }
  }
  return serverUrl;
}

/// Accepts "192.168.0.10", "192.168.0.10:8080" or a full http(s) URL and
/// returns a normalized API URL, or null when the input is not usable.
String? normalizeServerUrl(String input) {
  var text = input.trim();
  if (text.isEmpty) return null;
  if (!text.contains('://')) text = 'http://$text';
  final uri = Uri.tryParse(text);
  if (uri == null ||
      !(uri.scheme == 'http' || uri.scheme == 'https') ||
      uri.host.isEmpty ||
      uri.host.contains(' ')) {
    return null;
  }
  final port = uri.hasPort ? uri.port : (uri.scheme == 'http' ? 8080 : 443);
  return Uri(
    scheme: uri.scheme,
    host: uri.host,
    port: port,
    path: '/',
  ).toString();
}

/// Points the app at [url], or back at the built-in address when null.
///
/// Sessions belong to the previous server, so the device signs out locally
/// (without contacting a server that may be unreachable) before reconnecting.
Future<void> switchServer(String? url) async {
  await client.auth.updateSignedInUser(null);
  final prefs = await SharedPreferences.getInstance();
  if (url == null) {
    await prefs.remove(_serverUrlKey);
  } else {
    await prefs.setString(_serverUrlKey, url);
  }
  final previous = client;
  await initializeClient();
  previous.close();
  appGeneration.value++;
}

/// True for failures to reach the server, as opposed to errors it returned.
bool isConnectionError(Object e) {
  if (e is GymException) return false;
  final text = e.toString();
  return const [
    'SocketException',
    'Connection refused',
    'Connection timed out',
    'Failed host lookup',
    'Network is unreachable',
    'TimeoutException',
    'ClientException',
    'Insecure HTTP',
  ].any(text.contains);
}
