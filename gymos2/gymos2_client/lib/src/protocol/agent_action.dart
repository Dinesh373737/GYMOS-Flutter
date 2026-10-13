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

abstract class AgentAction
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AgentAction._({
    this.id,
    required this.conversationId,
    required this.userId,
    required this.toolName,
    required this.requestSummary,
    required this.resultSummary,
    required this.status,
    required this.createdAt,
    required this.durationMs,
  });

  factory AgentAction({
    int? id,
    required int conversationId,
    required int userId,
    required String toolName,
    required String requestSummary,
    required String resultSummary,
    required String status,
    required DateTime createdAt,
    required int durationMs,
  }) = _AgentActionImpl;

  factory AgentAction.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentAction(
      id: jsonSerialization['id'] as int?,
      conversationId: jsonSerialization['conversationId'] as int,
      userId: jsonSerialization['userId'] as int,
      toolName: jsonSerialization['toolName'] as String,
      requestSummary: jsonSerialization['requestSummary'] as String,
      resultSummary: jsonSerialization['resultSummary'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      durationMs: jsonSerialization['durationMs'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int conversationId;

  int userId;

  String toolName;

  String requestSummary;

  String resultSummary;

  String status;

  DateTime createdAt;

  int durationMs;

  /// Returns a shallow copy of this [AgentAction]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AgentAction copyWith({
    int? id,
    int? conversationId,
    int? userId,
    String? toolName,
    String? requestSummary,
    String? resultSummary,
    String? status,
    DateTime? createdAt,
    int? durationMs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentAction',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'userId': userId,
      'toolName': toolName,
      'requestSummary': requestSummary,
      'resultSummary': resultSummary,
      'status': status,
      'createdAt': createdAt.toJson(),
      'durationMs': durationMs,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentAction',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'userId': userId,
      'toolName': toolName,
      'requestSummary': requestSummary,
      'resultSummary': resultSummary,
      'status': status,
      'createdAt': createdAt.toJson(),
      'durationMs': durationMs,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentActionImpl extends AgentAction {
  _AgentActionImpl({
    int? id,
    required int conversationId,
    required int userId,
    required String toolName,
    required String requestSummary,
    required String resultSummary,
    required String status,
    required DateTime createdAt,
    required int durationMs,
  }) : super._(
         id: id,
         conversationId: conversationId,
         userId: userId,
         toolName: toolName,
         requestSummary: requestSummary,
         resultSummary: resultSummary,
         status: status,
         createdAt: createdAt,
         durationMs: durationMs,
       );

  /// Returns a shallow copy of this [AgentAction]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AgentAction copyWith({
    Object? id = _Undefined,
    int? conversationId,
    int? userId,
    String? toolName,
    String? requestSummary,
    String? resultSummary,
    String? status,
    DateTime? createdAt,
    int? durationMs,
  }) {
    return AgentAction(
      id: id is int? ? id : this.id,
      conversationId: conversationId ?? this.conversationId,
      userId: userId ?? this.userId,
      toolName: toolName ?? this.toolName,
      requestSummary: requestSummary ?? this.requestSummary,
      resultSummary: resultSummary ?? this.resultSummary,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      durationMs: durationMs ?? this.durationMs,
    );
  }
}
