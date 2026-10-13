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

abstract class MaintenanceIssue
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MaintenanceIssue._({
    this.id,
    required this.societyId,
    required this.societyEquipmentId,
    required this.reportedBy,
    required this.title,
    required this.description,
    required this.severity,
    required this.status,
    this.photoPath,
    required this.createdAt,
    this.resolvedAt,
  });

  factory MaintenanceIssue({
    int? id,
    required int societyId,
    required int societyEquipmentId,
    required int reportedBy,
    required String title,
    required String description,
    required String severity,
    required String status,
    String? photoPath,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) = _MaintenanceIssueImpl;

  factory MaintenanceIssue.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaintenanceIssue(
      id: jsonSerialization['id'] as int?,
      societyId: jsonSerialization['societyId'] as int,
      societyEquipmentId: jsonSerialization['societyEquipmentId'] as int,
      reportedBy: jsonSerialization['reportedBy'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      severity: jsonSerialization['severity'] as String,
      status: jsonSerialization['status'] as String,
      photoPath: jsonSerialization['photoPath'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['resolvedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int societyId;

  int societyEquipmentId;

  int reportedBy;

  String title;

  String description;

  String severity;

  String status;

  String? photoPath;

  DateTime createdAt;

  DateTime? resolvedAt;

  /// Returns a shallow copy of this [MaintenanceIssue]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MaintenanceIssue copyWith({
    int? id,
    int? societyId,
    int? societyEquipmentId,
    int? reportedBy,
    String? title,
    String? description,
    String? severity,
    String? status,
    String? photoPath,
    DateTime? createdAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaintenanceIssue',
      if (id != null) 'id': id,
      'societyId': societyId,
      'societyEquipmentId': societyEquipmentId,
      'reportedBy': reportedBy,
      'title': title,
      'description': description,
      'severity': severity,
      'status': status,
      if (photoPath != null) 'photoPath': photoPath,
      'createdAt': createdAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MaintenanceIssue',
      if (id != null) 'id': id,
      'societyId': societyId,
      'societyEquipmentId': societyEquipmentId,
      'reportedBy': reportedBy,
      'title': title,
      'description': description,
      'severity': severity,
      'status': status,
      if (photoPath != null) 'photoPath': photoPath,
      'createdAt': createdAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MaintenanceIssueImpl extends MaintenanceIssue {
  _MaintenanceIssueImpl({
    int? id,
    required int societyId,
    required int societyEquipmentId,
    required int reportedBy,
    required String title,
    required String description,
    required String severity,
    required String status,
    String? photoPath,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         societyId: societyId,
         societyEquipmentId: societyEquipmentId,
         reportedBy: reportedBy,
         title: title,
         description: description,
         severity: severity,
         status: status,
         photoPath: photoPath,
         createdAt: createdAt,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [MaintenanceIssue]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MaintenanceIssue copyWith({
    Object? id = _Undefined,
    int? societyId,
    int? societyEquipmentId,
    int? reportedBy,
    String? title,
    String? description,
    String? severity,
    String? status,
    Object? photoPath = _Undefined,
    DateTime? createdAt,
    Object? resolvedAt = _Undefined,
  }) {
    return MaintenanceIssue(
      id: id is int? ? id : this.id,
      societyId: societyId ?? this.societyId,
      societyEquipmentId: societyEquipmentId ?? this.societyEquipmentId,
      reportedBy: reportedBy ?? this.reportedBy,
      title: title ?? this.title,
      description: description ?? this.description,
      severity: severity ?? this.severity,
      status: status ?? this.status,
      photoPath: photoPath is String? ? photoPath : this.photoPath,
      createdAt: createdAt ?? this.createdAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}
