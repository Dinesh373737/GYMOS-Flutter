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

abstract class Notification
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Notification._({
    this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    this.link,
    this.readAt,
    required this.createdAt,
  });

  factory Notification({
    int? id,
    required int userId,
    required String type,
    required String title,
    required String body,
    String? link,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _NotificationImpl;

  factory Notification.fromJson(Map<String, dynamic> jsonSerialization) {
    return Notification(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      type: jsonSerialization['type'] as String,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      link: jsonSerialization['link'] as String?,
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String type;

  String title;

  String body;

  String? link;

  DateTime? readAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Notification copyWith({
    int? id,
    int? userId,
    String? type,
    String? title,
    String? body,
    String? link,
    DateTime? readAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Notification',
      if (id != null) 'id': id,
      'userId': userId,
      'type': type,
      'title': title,
      'body': body,
      if (link != null) 'link': link,
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Notification',
      if (id != null) 'id': id,
      'userId': userId,
      'type': type,
      'title': title,
      'body': body,
      if (link != null) 'link': link,
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationImpl extends Notification {
  _NotificationImpl({
    int? id,
    required int userId,
    required String type,
    required String title,
    required String body,
    String? link,
    DateTime? readAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         type: type,
         title: title,
         body: body,
         link: link,
         readAt: readAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Notification copyWith({
    Object? id = _Undefined,
    int? userId,
    String? type,
    String? title,
    String? body,
    Object? link = _Undefined,
    Object? readAt = _Undefined,
    DateTime? createdAt,
  }) {
    return Notification(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      link: link is String? ? link : this.link,
      readAt: readAt is DateTime? ? readAt : this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
