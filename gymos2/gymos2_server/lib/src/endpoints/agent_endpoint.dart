import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

import '../services/access.dart';

import '../services/agent/agent_service.dart';

class AgentEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<AgentReply> sendMessage(Session s, String text, int? conversationId) =>
      AgentService.send(s, text, conversationId);

  Future<List<AgentConversation>> conversations(Session s) async {
    final p = await Access.profile(s);
    return AgentConversation.db.find(
      s,
      where: (t) => t.userId.equals(p.id!),
      orderBy: (t) => t.updatedAt.desc(),
      limit: 30,
    );
  }

  Future<List<AgentMessage>> messages(Session s, int id) async {
    final p = await Access.profile(s);
    final c = await AgentConversation.db.findById(s, id);
    if (c == null || c.userId != p.id) {
      throw GymException(message: 'Conversation not found.');
    }
    return AgentMessage.db.find(
      s,
      where: (t) => t.conversationId.equals(id),
      orderBy: (t) => t.createdAt,
    );
  }
}
