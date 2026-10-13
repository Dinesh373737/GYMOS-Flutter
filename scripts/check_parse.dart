import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

Future<void> main(List<String> args) async {
  final config = loadYaml(File('gymos2/gymos2_server/config/passwords.yaml').readAsStringSync());
  final key = (config['development']['PARSE_EVENTS_API_KEY'] ?? config['development']['ALLEVENTS_API_KEY']) as String;
  final path = args.isEmpty ? '/v1/apis/3fe3d7da-7728-4b0d-b7e7-c0c4db6fa853/openapi.json' : args.first;
  final query = <String, String>{};
  for (final arg in args.skip(1)) {
    final split = arg.indexOf('=');
    query[arg.substring(0, split)] = Uri.decodeComponent(arg.substring(split + 1));
  }
  final uri = Uri.https('api.parse.bot', path, query.isEmpty ? null : query);
  final response = await http.get(uri, headers: {'X-API-Key': key}).timeout(const Duration(seconds: 50));
  stdout.writeln('Parse.bot HTTP ${response.statusCode}');
  final output = File('gymos2/gymos2_server/.serverpod/verification/parse-response.json');
  output.parent.createSync(recursive: true);
  output.writeAsStringSync(response.body.replaceAll(key, '[redacted]'));
  try {
    final data = jsonDecode(response.body);
    stdout.writeln(jsonEncode(data).substring(0, jsonEncode(data).length.clamp(0, 16000)));
  } on FormatException {
    stdout.writeln('Non-JSON response; saved for local diagnostics.');
  }
  if (response.statusCode != 200) exitCode = 1;
}
