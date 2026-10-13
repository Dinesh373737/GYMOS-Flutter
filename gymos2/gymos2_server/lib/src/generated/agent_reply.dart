/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gymos2_server/src/generated/protocol.dart' as _ib35fuo1;
import 'package:serverpod/serverpod.dart' as _is;
import 'agent_action.dart' as _i5uera5m;

abstract class AgentReply
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AgentReply._({
    required this.conversationId,
    required this.message,
    required this.actions,
    this.planId,
  });

  factory AgentReply({
    required int conversationId,
    required String message,
    required List<_i5uera5m.AgentAction> actions,
    int? planId,
  }) = _AgentReplyImpl;

  factory AgentReply.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentReply(
      conversationId: jsonSerialization['conversationId'] as int,
      message: jsonSerialization['message'] as String,
      actions: _ib35fuo1.Protocol().deserialize<List<_i5uera5m.AgentAction>>(
        jsonSerialization['actions'],
      ),
      planId: jsonSerialization['planId'] as int?,
    );
  }

  int conversationId;

  String message;

  List<_i5uera5m.AgentAction> actions;

  int? planId;

  /// Returns a shallow copy of this [AgentReply]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AgentReply copyWith({
    int? conversationId,
    String? message,
    List<_i5uera5m.AgentAction>? actions,
    int? planId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentReply',
      'conversationId': conversationId,
      'message': message,
      'actions': actions.toJson(valueToJson: (v) => v.toJson()),
      if (planId != null) 'planId': planId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentReply',
      'conversationId': conversationId,
      'message': message,
      'actions': actions.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (planId != null) 'planId': planId,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentReplyImpl extends AgentReply {
  _AgentReplyImpl({
    required int conversationId,
    required String message,
    required List<_i5uera5m.AgentAction> actions,
    int? planId,
  }) : super._(
         conversationId: conversationId,
         message: message,
         actions: actions,
         planId: planId,
       );

  /// Returns a shallow copy of this [AgentReply]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AgentReply copyWith({
    int? conversationId,
    String? message,
    List<_i5uera5m.AgentAction>? actions,
    Object? planId = _Undefined,
  }) {
    return AgentReply(
      conversationId: conversationId ?? this.conversationId,
      message: message ?? this.message,
      actions: actions ?? this.actions.map((e0) => e0.copyWith()).toList(),
      planId: planId is int? ? planId : this.planId,
    );
  }
}
