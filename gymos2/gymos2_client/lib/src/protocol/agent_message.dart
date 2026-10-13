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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class AgentMessage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AgentMessage._({
    this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    required this.createdAt,
  });

  factory AgentMessage({
    int? id,
    required int conversationId,
    required String role,
    required String content,
    required DateTime createdAt,
  }) = _AgentMessageImpl;

  factory AgentMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentMessage(
      id: jsonSerialization['id'] as int?,
      conversationId: jsonSerialization['conversationId'] as int,
      role: jsonSerialization['role'] as String,
      content: jsonSerialization['content'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int conversationId;

  String role;

  String content;

  DateTime createdAt;

  /// Returns a shallow copy of this [AgentMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AgentMessage copyWith({
    int? id,
    int? conversationId,
    String? role,
    String? content,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentMessage',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'role': role,
      'content': content,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentMessage',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'role': role,
      'content': content,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentMessageImpl extends AgentMessage {
  _AgentMessageImpl({
    int? id,
    required int conversationId,
    required String role,
    required String content,
    required DateTime createdAt,
  }) : super._(
         id: id,
         conversationId: conversationId,
         role: role,
         content: content,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AgentMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AgentMessage copyWith({
    Object? id = _Undefined,
    int? conversationId,
    String? role,
    String? content,
    DateTime? createdAt,
  }) {
    return AgentMessage(
      id: id is int? ? id : this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
