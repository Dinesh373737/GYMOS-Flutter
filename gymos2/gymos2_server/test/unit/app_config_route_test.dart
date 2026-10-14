import 'package:gymos2_server/src/web/routes/app_config_route.dart';
import 'package:test/test.dart';

void main() {
  Uri url(String host, String? requestHost) => appApiUrl(
    scheme: 'http',
    host: host,
    port: 8080,
    requestHost: requestHost,
  );

  test('local configs follow the host the page was loaded from', () {
    expect(
      url('localhost', '192.168.0.50').toString(),
      'http://192.168.0.50:8080',
    );
    expect(url('localhost', 'localhost').toString(), 'http://localhost:8080');
    expect(url('localhost', '').toString(), 'http://localhost:8080');
    expect(url('localhost', null).toString(), 'http://localhost:8080');
  });

  test('a real public host is never replaced by the request host', () {
    expect(
      appApiUrl(
        scheme: 'https',
        host: 'gymos.api.serverpod.space',
        port: 443,
        requestHost: 'evil.example',
      ).toString(),
      'https://gymos.api.serverpod.space',
    );
  });
}
