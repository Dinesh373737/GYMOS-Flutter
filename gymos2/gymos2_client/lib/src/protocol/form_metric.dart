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

abstract class FormMetric
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FormMetric._({
    this.id,
    required this.formAnalysisId,
    required this.metricName,
    required this.measuredValue,
    required this.unit,
    required this.targetRangeText,
    required this.status,
    required this.confidence,
    required this.cue,
  });

  factory FormMetric({
    int? id,
    required int formAnalysisId,
    required String metricName,
    required double measuredValue,
    required String unit,
    required String targetRangeText,
    required String status,
    required double confidence,
    required String cue,
  }) = _FormMetricImpl;

  factory FormMetric.fromJson(Map<String, dynamic> jsonSerialization) {
    return FormMetric(
      id: jsonSerialization['id'] as int?,
      formAnalysisId: jsonSerialization['formAnalysisId'] as int,
      metricName: jsonSerialization['metricName'] as String,
      measuredValue: (jsonSerialization['measuredValue'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
      targetRangeText: jsonSerialization['targetRangeText'] as String,
      status: jsonSerialization['status'] as String,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      cue: jsonSerialization['cue'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int formAnalysisId;

  String metricName;

  double measuredValue;

  String unit;

  String targetRangeText;

  String status;

  double confidence;

  String cue;

  /// Returns a shallow copy of this [FormMetric]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FormMetric copyWith({
    int? id,
    int? formAnalysisId,
    String? metricName,
    double? measuredValue,
    String? unit,
    String? targetRangeText,
    String? status,
    double? confidence,
    String? cue,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FormMetric',
      if (id != null) 'id': id,
      'formAnalysisId': formAnalysisId,
      'metricName': metricName,
      'measuredValue': measuredValue,
      'unit': unit,
      'targetRangeText': targetRangeText,
      'status': status,
      'confidence': confidence,
      'cue': cue,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FormMetric',
      if (id != null) 'id': id,
      'formAnalysisId': formAnalysisId,
      'metricName': metricName,
      'measuredValue': measuredValue,
      'unit': unit,
      'targetRangeText': targetRangeText,
      'status': status,
      'confidence': confidence,
      'cue': cue,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FormMetricImpl extends FormMetric {
  _FormMetricImpl({
    int? id,
    required int formAnalysisId,
    required String metricName,
    required double measuredValue,
    required String unit,
    required String targetRangeText,
    required String status,
    required double confidence,
    required String cue,
  }) : super._(
         id: id,
         formAnalysisId: formAnalysisId,
         metricName: metricName,
         measuredValue: measuredValue,
         unit: unit,
         targetRangeText: targetRangeText,
         status: status,
         confidence: confidence,
         cue: cue,
       );

  /// Returns a shallow copy of this [FormMetric]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FormMetric copyWith({
    Object? id = _Undefined,
    int? formAnalysisId,
    String? metricName,
    double? measuredValue,
    String? unit,
    String? targetRangeText,
    String? status,
    double? confidence,
    String? cue,
  }) {
    return FormMetric(
      id: id is int? ? id : this.id,
      formAnalysisId: formAnalysisId ?? this.formAnalysisId,
      metricName: metricName ?? this.metricName,
      measuredValue: measuredValue ?? this.measuredValue,
      unit: unit ?? this.unit,
      targetRangeText: targetRangeText ?? this.targetRangeText,
      status: status ?? this.status,
      confidence: confidence ?? this.confidence,
      cue: cue ?? this.cue,
    );
  }
}
