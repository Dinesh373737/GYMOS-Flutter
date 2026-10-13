import 'dart:convert';
import 'package:gymos2_server/src/generated/protocol.dart';
import 'package:gymos2_server/src/services/agent/groq_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Groq transport sends server credentials and returns structured tool calls',
    () async {
      final provider = GroqProvider(
        'test-secret',
        transport: MockClient((request) async {
          expect(
            request.url.toString(),
            'https://api.groq.com/openai/v1/chat/completions',
          );
          expect(request.headers['Authorization'], 'Bearer test-secret');
          final body = jsonDecode(request.body) as Map<String, dynamic>;
          expect(body['model'], 'openai/gpt-oss-120b');
          expect(body['reasoning_effort'], 'low');
          expect(body['max_completion_tokens'], 1000);
          expect(body['messages'], [
            {'role': 'user', 'content': 'Plan a workout'},
          ]);
          expect(body['tools'], hasLength(1));
          expect(body['tool_choice'], {
            'type': 'function',
            'function': {'name': 'get_user_profile'},
          });
          return http.Response(
            jsonEncode({
              'choices': [
                {
                  'message': {
                    'role': 'assistant',
                    'content': null,
                    'tool_calls': [
                      {
                        'id': 'read',
                        'type': 'function',
                        'function': {
                          'name': 'get_user_profile',
                          'arguments': '{}',
                        },
                      },
                    ],
                  },
                },
              ],
            }),
            200,
          );
        }),
      );
      addTearDown(provider.close);
      final reply = await provider.complete(
        [
          {'role': 'user', 'content': 'Plan a workout'},
        ],
        [
          {
            'type': 'function',
            'function': {'name': 'get_user_profile'},
          },
        ],
        requiredTool: 'get_user_profile',
      );
      expect(reply['tool_calls'], hasLength(1));
    },
  );

  for (final status in [401, 429, 500]) {
    test('Groq $status returns a safe actionable error', () async {
      final provider = GroqProvider(
        'test-secret',
        transport: MockClient(
          (_) async =>
              http.Response('sensitive provider detail test-secret', status),
        ),
      );
      addTearDown(provider.close);
      await expectLater(
        provider.complete([], []),
        throwsA(
          isA<GymException>().having(
            (e) => e.message,
            'message',
            allOf(
              isNot(contains('test-secret')),
              contains(status == 429 ? 'busy' : 'unavailable'),
            ),
          ),
        ),
      );
    });
  }

  test('invalid JSON and network failures remain safe errors', () async {
    for (final transport in [
      MockClient((_) async => http.Response('not json', 200)),
      MockClient(
        (_) async => throw http.ClientException('private network details'),
      ),
    ]) {
      final provider = GroqProvider('test-secret', transport: transport);
      addTearDown(provider.close);
      await expectLater(
        provider.complete([], []),
        throwsA(
          isA<GymException>().having(
            (e) => e.message,
            'message',
            'The coach could not connect. Please try again.',
          ),
        ),
      );
    }
  });
}
