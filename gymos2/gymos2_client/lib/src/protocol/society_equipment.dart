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

abstract class SocietyEquipment
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SocietyEquipment._({
    this.id,
    required this.societyId,
    required this.equipmentId,
    required this.label,
    required this.quantity,
    required this.status,
    required this.locationLabel,
    this.lastServicedAt,
  });

  factory SocietyEquipment({
    int? id,
    required int societyId,
    required int equipmentId,
    required String label,
    required int quantity,
    required String status,
    required String locationLabel,
    DateTime? lastServicedAt,
  }) = _SocietyEquipmentImpl;

  factory SocietyEquipment.fromJson(Map<String, dynamic> jsonSerialization) {
    return SocietyEquipment(
      id: jsonSerialization['id'] as int?,
      societyId: jsonSerialization['societyId'] as int,
      equipmentId: jsonSerialization['equipmentId'] as int,
      label: jsonSerialization['label'] as String,
      quantity: jsonSerialization['quantity'] as int,
      status: jsonSerialization['status'] as String,
      locationLabel: jsonSerialization['locationLabel'] as String,
      lastServicedAt: jsonSerialization['lastServicedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastServicedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int societyId;

  int equipmentId;

  String label;

  int quantity;

  String status;

  String locationLabel;

  DateTime? lastServicedAt;

  /// Returns a shallow copy of this [SocietyEquipment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SocietyEquipment copyWith({
    int? id,
    int? societyId,
    int? equipmentId,
    String? label,
    int? quantity,
    String? status,
    String? locationLabel,
    DateTime? lastServicedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SocietyEquipment',
      if (id != null) 'id': id,
      'societyId': societyId,
      'equipmentId': equipmentId,
      'label': label,
      'quantity': quantity,
      'status': status,
      'locationLabel': locationLabel,
      if (lastServicedAt != null) 'lastServicedAt': lastServicedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SocietyEquipment',
      if (id != null) 'id': id,
      'societyId': societyId,
      'equipmentId': equipmentId,
      'label': label,
      'quantity': quantity,
      'status': status,
      'locationLabel': locationLabel,
      if (lastServicedAt != null) 'lastServicedAt': lastServicedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SocietyEquipmentImpl extends SocietyEquipment {
  _SocietyEquipmentImpl({
    int? id,
    required int societyId,
    required int equipmentId,
    required String label,
    required int quantity,
    required String status,
    required String locationLabel,
    DateTime? lastServicedAt,
  }) : super._(
         id: id,
         societyId: societyId,
         equipmentId: equipmentId,
         label: label,
         quantity: quantity,
         status: status,
         locationLabel: locationLabel,
         lastServicedAt: lastServicedAt,
       );

  /// Returns a shallow copy of this [SocietyEquipment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SocietyEquipment copyWith({
    Object? id = _Undefined,
    int? societyId,
    int? equipmentId,
    String? label,
    int? quantity,
    String? status,
    String? locationLabel,
    Object? lastServicedAt = _Undefined,
  }) {
    return SocietyEquipment(
      id: id is int? ? id : this.id,
      societyId: societyId ?? this.societyId,
      equipmentId: equipmentId ?? this.equipmentId,
      label: label ?? this.label,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      locationLabel: locationLabel ?? this.locationLabel,
      lastServicedAt: lastServicedAt is DateTime?
          ? lastServicedAt
          : this.lastServicedAt,
    );
  }
}
