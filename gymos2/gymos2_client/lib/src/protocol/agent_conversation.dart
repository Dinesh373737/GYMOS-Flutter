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

abstract class AgentConversation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AgentConversation._({
    this.id,
    required this.userId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AgentConversation({
    int? id,
    required int userId,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AgentConversationImpl;

  factory AgentConversation.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentConversation(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String title;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [AgentConversation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AgentConversation copyWith({
    int? id,
    int? userId,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentConversation',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentConversation',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentConversationImpl extends AgentConversation {
  _AgentConversationImpl({
    int? id,
    required int userId,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         title: title,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AgentConversation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AgentConversation copyWith({
    Object? id = _Undefined,
    int? userId,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AgentConversation(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
