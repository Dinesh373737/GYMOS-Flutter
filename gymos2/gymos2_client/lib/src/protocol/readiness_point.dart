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

abstract class ReadinessPoint
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ReadinessPoint._({
    required this.day,
    required this.totalLoad,
    required this.highCount,
    required this.moderateCount,
    required this.sessions,
  });

  factory ReadinessPoint({
    required DateTime day,
    required double totalLoad,
    required int highCount,
    required int moderateCount,
    required int sessions,
  }) = _ReadinessPointImpl;

  factory ReadinessPoint.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReadinessPoint(
      day: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      totalLoad: (jsonSerialization['totalLoad'] as num).toDouble(),
      highCount: jsonSerialization['highCount'] as int,
      moderateCount: jsonSerialization['moderateCount'] as int,
      sessions: jsonSerialization['sessions'] as int,
    );
  }

  DateTime day;

  double totalLoad;

  int highCount;

  int moderateCount;

  int sessions;

  /// Returns a shallow copy of this [ReadinessPoint]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReadinessPoint copyWith({
    DateTime? day,
    double? totalLoad,
    int? highCount,
    int? moderateCount,
    int? sessions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReadinessPoint',
      'day': day.toJson(),
      'totalLoad': totalLoad,
      'highCount': highCount,
      'moderateCount': moderateCount,
      'sessions': sessions,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReadinessPoint',
      'day': day.toJson(),
      'totalLoad': totalLoad,
      'highCount': highCount,
      'moderateCount': moderateCount,
      'sessions': sessions,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ReadinessPointImpl extends ReadinessPoint {
  _ReadinessPointImpl({
    required DateTime day,
    required double totalLoad,
    required int highCount,
    required int moderateCount,
    required int sessions,
  }) : super._(
         day: day,
         totalLoad: totalLoad,
         highCount: highCount,
         moderateCount: moderateCount,
         sessions: sessions,
       );

  /// Returns a shallow copy of this [ReadinessPoint]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReadinessPoint copyWith({
    DateTime? day,
    double? totalLoad,
    int? highCount,
    int? moderateCount,
    int? sessions,
  }) {
    return ReadinessPoint(
      day: day ?? this.day,
      totalLoad: totalLoad ?? this.totalLoad,
      highCount: highCount ?? this.highCount,
      moderateCount: moderateCount ?? this.moderateCount,
      sessions: sessions ?? this.sessions,
    );
  }
}
