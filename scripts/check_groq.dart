import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

Future<void> main() async {
  final config = loadYaml(File('gymos2/gymos2_server/config/passwords.yaml').readAsStringSync());
  final key = config['development']['GROQ_API_KEY'] as String;
  final response = await http.post(
    Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
    headers: {'Authorization': 'Bearer $key', 'Content-Type': 'application/json'},
    body: jsonEncode({
      'model': 'openai/gpt-oss-120b',
      'messages': [{'role': 'user', 'content': 'Reply with OK.'}],
      'max_completion_tokens': 32,
    }),
  ).timeout(const Duration(seconds: 40));
  stdout.writeln('Groq status: ${response.statusCode}');
  stdout.writeln('Limit headers: ${Map.fromEntries(response.headers.entries.where((e) => e.key.contains('ratelimit') || e.key == 'retry-after'))}');
  try {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    if (data['error'] != null) {
      final error = data['error'] as Map<String, dynamic>;
      stdout.writeln('Error: ${error['code']} / ${error['type']}');
      stdout.writeln('${error['message']}'.replaceAll(key, '[redacted]'));
    } else {
      stdout.writeln('Model response received: ${data['model']}');
    }
  } on FormatException {
    stdout.writeln('Provider returned a non-JSON response.');
  }
}
