import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../generated/protocol.dart';

abstract interface class AgentProvider {
  Future<Map<String, dynamic>> complete(
    List<Map<String, dynamic>> messages,
    List<Map<String, dynamic>> tools, {
    String? requiredTool,
  });
}

class GroqProvider implements AgentProvider {
  final String apiKey;
  final String model;
  final http.Client transport;

  GroqProvider(
    this.apiKey, {
    this.model = 'openai/gpt-oss-120b',
    http.Client? transport,
  }) : transport = transport ?? http.Client();

  @override
  Future<Map<String, dynamic>> complete(
    List<Map<String, dynamic>> messages,
    List<Map<String, dynamic>> tools, {
    String? requiredTool,
  }) async {
    try {
      final response = await transport
          .post(
            Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
            headers: {
              'Authorization': 'Bearer $apiKey',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'model': model,
              'messages': messages,
              if (tools.isNotEmpty) 'tools': tools,
              if (tools.isNotEmpty)
                'tool_choice': requiredTool == null
                    ? 'auto'
                    : {
                        'type': 'function',
                        'function': {'name': requiredTool},
                      },
              'temperature': .3,
              if (model.startsWith('openai/gpt-oss-'))
                'reasoning_effort': 'low',
              'max_completion_tokens': 1000,
            }),
          )
          .timeout(const Duration(seconds: 35));

      if (response.statusCode == 429) {
        throw GymException(
          message:
              'The coach is busy. Please try again shortly; your workouts still work.',
        );
      }

      if (response.statusCode != 200) {
        throw GymException(
          message:
              'The coach is temporarily unavailable. You can still generate a workout in Workout.',
        );
      }

      return Map<String, dynamic>.from(
        jsonDecode(response.body)['choices'][0]['message'],
      );
    } on GymException {
      rethrow;
    } catch (_) {
      throw GymException(
        message: 'The coach could not connect. Please try again.',
      );
    }
  }

  void close() => transport.close();
}
