import 'dart:async';
import 'dart:convert';
import 'package:gymos2_server/src/generated/protocol.dart';
import 'package:gymos2_server/src/services/agent/agent_service.dart';
import 'package:gymos2_server/src/services/agent/groq_provider.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

class ScriptedProvider implements AgentProvider {
  ScriptedProvider(this.respond);
  final Future<Map<String, dynamic>> Function(List<Map<String, dynamic>>, int)
  respond;
  var calls = 0;
  final requiredTools = <String?>[];
  @override
  Future<Map<String, dynamic>> complete(
    List<Map<String, dynamic>> messages,
    List<Map<String, dynamic>> tools, {
    String? requiredTool,
  }) {
    requiredTools.add(requiredTool);
    return respond(messages, calls++);
  }
}

Map<String, dynamic> call(String id, String name, [String arguments = '{}']) =>
    {
      'id': id,
      'type': 'function',
      'function': {'name': name, 'arguments': arguments},
    };

void main() {
  withServerpod('Coach orchestration with real database and mock provider', (
    builder,
    endpoints,
  ) {
    final member = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'coach-member',
        {},
      ),
    );
    final other = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'coach-other',
        {},
      ),
    );

    setUp(() async {
      await endpoints.profile.completeOnboarding(
        member,
        'Member',
        '',
        true,
        'beginner',
        'strength',
        30,
      );
      await endpoints.profile.completeOnboarding(
        other,
        'Other',
        '',
        true,
        'beginner',
        'strength',
        30,
      );
    });

    test('tool results ground a persisted draft and stay private', () async {
      final provider = ScriptedProvider((messages, round) async {
        if (round == 0) {
          return {
            'role': 'assistant',
            'content': null,
            'tool_calls': [
              call('history', 'get_recent_workouts'),
              call('load', 'get_training_readiness'),
              call('equipment', 'get_available_equipment'),
              call(
                'draft',
                'create_workout_draft',
                '{"minutes":30,"focus":"full body"}',
              ),
            ],
          };
        }
        final results = messages.where((m) => m['role'] == 'tool').toList();
        expect(results, hasLength(4));
        final draft = jsonDecode(results.last['content'] as String);
        expect(draft['plan']['status'], 'draft');
        return {'content': 'Your 30-minute draft is ready to review.'};
      });
      final reply = await AgentService.send(
        member.build(),
        'Plan 30 minutes',
        null,
        provider: provider,
      );
      expect(reply.planId, isNotNull);
      expect(reply.actions, hasLength(4));
      expect(reply.actions.every((a) => a.status == 'success'), isTrue);
      final plan = await endpoints.workout.getPlan(member, reply.planId!);
      expect(plan.plan.createdByType, 'agent');
      expect(plan.plan.status, 'draft');
      expect(await endpoints.workout.history(member), isEmpty);
      final saved = await AgentMessage.db.find(
        member.build(),
        where: (t) => t.conversationId.equals(reply.conversationId),
      );
      expect(saved.map((m) => m.role), containsAll(['user', 'assistant']));
      await expectLater(
        AgentService.send(
          other.build(),
          'Show that conversation',
          reply.conversationId,
          provider: provider,
        ),
        throwsA(isA<GymException>()),
      );
    });

    test(
      'an invented routine is withheld until a real draft is saved',
      () async {
        final provider = ScriptedProvider(
          (_, round) async => round == 1
              ? {
                  'tool_calls': [
                    call(
                      'save',
                      'create_workout_draft',
                      '{"minutes":40,"focus":"full body"}',
                    ),
                  ],
                }
              : {'content': 'Invented routine: cable row with 100 kg.'},
        );
        final reply = await AgentService.send(
          member.build(),
          'I have 40 minutes. What should I train today?',
          null,
          provider: provider,
        );
        expect(provider.requiredTools[1], 'create_workout_draft');
        expect(reply.planId, isNotNull);
        expect(reply.message, contains('draft is saved'));
        expect(reply.message, isNot(contains('100 kg')));
        expect(reply.message, isNot(contains('cable row')));
      },
    );

    test(
      'unknown tools, invalid arguments and unsolicited replacement are audited failures',
      () async {
        final provider = ScriptedProvider(
          (_, round) async => round == 0
              ? {
                  'tool_calls': [
                    call('unknown', 'delete_everything'),
                    call('invalid', 'create_workout_draft', 'not-json'),
                    call(
                      'replace',
                      'replace_workout_exercise',
                      '{"planId":1,"itemId":1,"exerciseId":1}',
                    ),
                  ],
                }
              : {'content': 'Please choose a workout action.'},
        );
        final reply = await AgentService.send(
          member.build(),
          'What should I train?',
          null,
          provider: provider,
        );
        expect(reply.actions, hasLength(3));
        expect(reply.actions.every((a) => a.status == 'failed'), isTrue);
        expect(await endpoints.workout.plans(member), isEmpty);
      },
    );

    test(
      'tool execution is bounded even if the model keeps requesting actions',
      () async {
        final provider = ScriptedProvider(
          (_, round) async => {
            'tool_calls': [call('read-$round', 'get_user_profile')],
          },
        );
        final reply = await AgentService.send(
          member.build(),
          'Tell me about my training',
          null,
          provider: provider,
        );
        expect(provider.calls, 8);
        expect(reply.actions, hasLength(8));
        expect(reply.message, contains('action limit'));
      },
    );

    test(
      'provider failure releases the request guard and concurrent requests are rejected',
      () async {
        final entered = Completer<void>();
        final release = Completer<void>();
        final blockedProvider = ScriptedProvider((_, _) async {
          entered.complete();
          await release.future;
          throw GymException(message: 'The coach is temporarily unavailable.');
        });
        final inFlight = AgentService.send(
          member.build(),
          'First request',
          null,
          provider: blockedProvider,
        );
        final failure = expectLater(inFlight, throwsA(isA<GymException>()));
        await entered.future;
        await expectLater(
          AgentService.send(
            member.build(),
            'Second request',
            null,
            provider: blockedProvider,
          ),
          throwsA(
            isA<GymException>().having(
              (e) => e.message,
              'message',
              contains('previous'),
            ),
          ),
        );
        release.complete();
        await failure;
        final reply = await AgentService.send(
          member.build(),
          'Retry request',
          null,
          provider: ScriptedProvider(
            (_, _) async => {'content': 'Ready again.'},
          ),
        );
        expect(reply.message, 'Ready again.');
      },
    );

    test(
      'a saved draft remains accessible when the provider fails on its summary',
      () async {
        final provider = ScriptedProvider((_, round) async {
          if (round == 0) {
            return {
              'tool_calls': [
                call(
                  'draft',
                  'create_workout_draft',
                  '{"minutes":30,"focus":"full body"}',
                ),
              ],
            };
          }
          throw GymException(message: 'The coach is busy.');
        });
        final reply = await AgentService.send(
          member.build(),
          'Plan 30 minutes',
          null,
          provider: provider,
        );
        expect(reply.planId, isNotNull);
        expect(reply.actions.single.status, 'success');
        expect(reply.message, contains('draft is saved'));
        final plan = await endpoints.workout.getPlan(member, reply.planId!);
        expect(plan.plan.status, 'draft');
        expect((await endpoints.workout.plans(member)).length, 1);
      },
    );

    test(
      'rate limit is scoped to each user instead of blocking all residents',
      () async {
        final profile = (await endpoints.profile.getMe(member))!;
        final now = DateTime.now().toUtc();
        final conversation = await AgentConversation.db.insertRow(
          member.build(),
          AgentConversation(
            userId: profile.id!,
            title: 'Recent requests',
            createdAt: now,
            updatedAt: now,
          ),
        );
        for (var i = 0; i < 50; i++) {
          await AgentMessage.db.insertRow(
            member.build(),
            AgentMessage(
              conversationId: conversation.id!,
              role: 'user',
              content: 'Request $i',
              createdAt: now,
            ),
          );
        }
        final provider = ScriptedProvider(
          (_, _) async => {'content': 'Available for this resident.'},
        );
        final reply = await AgentService.send(
          other.build(),
          'Hello',
          null,
          provider: provider,
        );
        expect(reply.message, 'Available for this resident.');
        await expectLater(
          AgentService.send(
            member.build(),
            'One more',
            null,
            provider: provider,
          ),
          throwsA(
            isA<GymException>().having(
              (e) => e.message,
              'message',
              contains('minute'),
            ),
          ),
        );
        expect(provider.calls, 1);
      },
    );
  });
}
