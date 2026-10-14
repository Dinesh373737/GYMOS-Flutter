import 'package:serverpod/serverpod.dart';

class AppConfigWidget extends JsonWidget {
  final String apiUrl;

  AppConfigWidget({
    required this.apiUrl,
  }) : super(object: {'apiUrl': apiUrl});
}

class AppConfigRoute extends WidgetRoute {
  final ServerConfig apiConfig;

  AppConfigRoute({
    required this.apiConfig,
  });

  @override
  Future<WebWidget> build(Session session, Request request) async {
    return AppConfigWidget(
      apiUrl: appApiUrl(
        scheme: apiConfig.publicScheme,
        host: apiConfig.publicHost,
        port: apiConfig.publicPort,
        requestHost: request.url.host,
      ).toString(),
    );
  }
}

const _localHosts = {'localhost', '127.0.0.1', '::1', '0.0.0.0'};

/// The API address handed to the Flutter web app.
///
/// Local development configs advertise `localhost`, which only works in a
/// browser on the computer running the server. When the page was loaded from
/// another host (for example a phone using the computer's Wi-Fi address), the
/// app is pointed at that same host on the API port instead.
Uri appApiUrl({
  required String scheme,
  required String host,
  required int port,
  String? requestHost,
}) {
  final useRequestHost =
      _localHosts.contains(host) &&
      requestHost != null &&
      requestHost.isNotEmpty &&
      !_localHosts.contains(requestHost);
  return Uri(
    scheme: scheme,
    host: useRequestHost ? requestHost : host,
    port: port,
  );
}
