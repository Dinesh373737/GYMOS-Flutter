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

abstract class FormAnalysis
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FormAnalysis._({
    this.id,
    required this.userId,
    required this.exerciseId,
    required this.checkpoint,
    required this.capturedAt,
    required this.analysisType,
    required this.resultBand,
    required this.confidence,
    required this.summary,
    this.retainedImagePath,
  });

  factory FormAnalysis({
    int? id,
    required int userId,
    required int exerciseId,
    required String checkpoint,
    required DateTime capturedAt,
    required String analysisType,
    required String resultBand,
    required double confidence,
    required String summary,
    String? retainedImagePath,
  }) = _FormAnalysisImpl;

  factory FormAnalysis.fromJson(Map<String, dynamic> jsonSerialization) {
    return FormAnalysis(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      exerciseId: jsonSerialization['exerciseId'] as int,
      checkpoint: jsonSerialization['checkpoint'] as String,
      capturedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['capturedAt'],
      ),
      analysisType: jsonSerialization['analysisType'] as String,
      resultBand: jsonSerialization['resultBand'] as String,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      summary: jsonSerialization['summary'] as String,
      retainedImagePath: jsonSerialization['retainedImagePath'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int exerciseId;

  String checkpoint;

  DateTime capturedAt;

  String analysisType;

  String resultBand;

  double confidence;

  String summary;

  String? retainedImagePath;

  /// Returns a shallow copy of this [FormAnalysis]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FormAnalysis copyWith({
    int? id,
    int? userId,
    int? exerciseId,
    String? checkpoint,
    DateTime? capturedAt,
    String? analysisType,
    String? resultBand,
    double? confidence,
    String? summary,
    String? retainedImagePath,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FormAnalysis',
      if (id != null) 'id': id,
      'userId': userId,
      'exerciseId': exerciseId,
      'checkpoint': checkpoint,
      'capturedAt': capturedAt.toJson(),
      'analysisType': analysisType,
      'resultBand': resultBand,
      'confidence': confidence,
      'summary': summary,
      if (retainedImagePath != null) 'retainedImagePath': retainedImagePath,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FormAnalysis',
      if (id != null) 'id': id,
      'userId': userId,
      'exerciseId': exerciseId,
      'checkpoint': checkpoint,
      'capturedAt': capturedAt.toJson(),
      'analysisType': analysisType,
      'resultBand': resultBand,
      'confidence': confidence,
      'summary': summary,
      if (retainedImagePath != null) 'retainedImagePath': retainedImagePath,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FormAnalysisImpl extends FormAnalysis {
  _FormAnalysisImpl({
    int? id,
    required int userId,
    required int exerciseId,
    required String checkpoint,
    required DateTime capturedAt,
    required String analysisType,
    required String resultBand,
    required double confidence,
    required String summary,
    String? retainedImagePath,
  }) : super._(
         id: id,
         userId: userId,
         exerciseId: exerciseId,
         checkpoint: checkpoint,
         capturedAt: capturedAt,
         analysisType: analysisType,
         resultBand: resultBand,
         confidence: confidence,
         summary: summary,
         retainedImagePath: retainedImagePath,
       );

  /// Returns a shallow copy of this [FormAnalysis]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FormAnalysis copyWith({
    Object? id = _Undefined,
    int? userId,
    int? exerciseId,
    String? checkpoint,
    DateTime? capturedAt,
    String? analysisType,
    String? resultBand,
    double? confidence,
    String? summary,
    Object? retainedImagePath = _Undefined,
  }) {
    return FormAnalysis(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      exerciseId: exerciseId ?? this.exerciseId,
      checkpoint: checkpoint ?? this.checkpoint,
      capturedAt: capturedAt ?? this.capturedAt,
      analysisType: analysisType ?? this.analysisType,
      resultBand: resultBand ?? this.resultBand,
      confidence: confidence ?? this.confidence,
      summary: summary ?? this.summary,
      retainedImagePath: retainedImagePath is String?
          ? retainedImagePath
          : this.retainedImagePath,
    );
  }
}
