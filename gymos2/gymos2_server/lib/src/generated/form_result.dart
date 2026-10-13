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
import 'form_analysis.dart' as _i1g08zve;
import 'form_metric.dart' as _i85mqlmj;

abstract class FormResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FormResult._({
    required this.analysis,
    required this.metrics,
  });

  factory FormResult({
    required _i1g08zve.FormAnalysis analysis,
    required List<_i85mqlmj.FormMetric> metrics,
  }) = _FormResultImpl;

  factory FormResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return FormResult(
      analysis: _ib35fuo1.Protocol().deserialize<_i1g08zve.FormAnalysis>(
        jsonSerialization['analysis'],
      ),
      metrics: _ib35fuo1.Protocol().deserialize<List<_i85mqlmj.FormMetric>>(
        jsonSerialization['metrics'],
      ),
    );
  }

  _i1g08zve.FormAnalysis analysis;

  List<_i85mqlmj.FormMetric> metrics;

  /// Returns a shallow copy of this [FormResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FormResult copyWith({
    _i1g08zve.FormAnalysis? analysis,
    List<_i85mqlmj.FormMetric>? metrics,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FormResult',
      'analysis': analysis.toJson(),
      'metrics': metrics.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FormResult',
      'analysis': analysis.toJsonForProtocol(),
      'metrics': metrics.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _FormResultImpl extends FormResult {
  _FormResultImpl({
    required _i1g08zve.FormAnalysis analysis,
    required List<_i85mqlmj.FormMetric> metrics,
  }) : super._(
         analysis: analysis,
         metrics: metrics,
       );

  /// Returns a shallow copy of this [FormResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FormResult copyWith({
    _i1g08zve.FormAnalysis? analysis,
    List<_i85mqlmj.FormMetric>? metrics,
  }) {
    return FormResult(
      analysis: analysis ?? this.analysis.copyWith(),
      metrics: metrics ?? this.metrics.map((e0) => e0.copyWith()).toList(),
    );
  }
}
