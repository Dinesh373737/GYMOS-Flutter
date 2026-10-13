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

abstract class TrainingReadiness
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TrainingReadiness._({
    this.id,
    required this.userId,
    required this.muscleGroupId,
    required this.muscleName,
    required this.trainingLoadScore,
    required this.readinessBand,
    this.lastTrainedAt,
    required this.computedAt,
    required this.explanation,
  });

  factory TrainingReadiness({
    int? id,
    required int userId,
    required int muscleGroupId,
    required String muscleName,
    required double trainingLoadScore,
    required String readinessBand,
    DateTime? lastTrainedAt,
    required DateTime computedAt,
    required String explanation,
  }) = _TrainingReadinessImpl;

  factory TrainingReadiness.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingReadiness(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      muscleGroupId: jsonSerialization['muscleGroupId'] as int,
      muscleName: jsonSerialization['muscleName'] as String,
      trainingLoadScore: (jsonSerialization['trainingLoadScore'] as num)
          .toDouble(),
      readinessBand: jsonSerialization['readinessBand'] as String,
      lastTrainedAt: jsonSerialization['lastTrainedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastTrainedAt'],
            ),
      computedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['computedAt'],
      ),
      explanation: jsonSerialization['explanation'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int muscleGroupId;

  String muscleName;

  double trainingLoadScore;

  String readinessBand;

  DateTime? lastTrainedAt;

  DateTime computedAt;

  String explanation;

  /// Returns a shallow copy of this [TrainingReadiness]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TrainingReadiness copyWith({
    int? id,
    int? userId,
    int? muscleGroupId,
    String? muscleName,
    double? trainingLoadScore,
    String? readinessBand,
    DateTime? lastTrainedAt,
    DateTime? computedAt,
    String? explanation,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingReadiness',
      if (id != null) 'id': id,
      'userId': userId,
      'muscleGroupId': muscleGroupId,
      'muscleName': muscleName,
      'trainingLoadScore': trainingLoadScore,
      'readinessBand': readinessBand,
      if (lastTrainedAt != null) 'lastTrainedAt': lastTrainedAt?.toJson(),
      'computedAt': computedAt.toJson(),
      'explanation': explanation,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrainingReadiness',
      if (id != null) 'id': id,
      'userId': userId,
      'muscleGroupId': muscleGroupId,
      'muscleName': muscleName,
      'trainingLoadScore': trainingLoadScore,
      'readinessBand': readinessBand,
      if (lastTrainedAt != null) 'lastTrainedAt': lastTrainedAt?.toJson(),
      'computedAt': computedAt.toJson(),
      'explanation': explanation,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingReadinessImpl extends TrainingReadiness {
  _TrainingReadinessImpl({
    int? id,
    required int userId,
    required int muscleGroupId,
    required String muscleName,
    required double trainingLoadScore,
    required String readinessBand,
    DateTime? lastTrainedAt,
    required DateTime computedAt,
    required String explanation,
  }) : super._(
         id: id,
         userId: userId,
         muscleGroupId: muscleGroupId,
         muscleName: muscleName,
         trainingLoadScore: trainingLoadScore,
         readinessBand: readinessBand,
         lastTrainedAt: lastTrainedAt,
         computedAt: computedAt,
         explanation: explanation,
       );

  /// Returns a shallow copy of this [TrainingReadiness]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TrainingReadiness copyWith({
    Object? id = _Undefined,
    int? userId,
    int? muscleGroupId,
    String? muscleName,
    double? trainingLoadScore,
    String? readinessBand,
    Object? lastTrainedAt = _Undefined,
    DateTime? computedAt,
    String? explanation,
  }) {
    return TrainingReadiness(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      muscleGroupId: muscleGroupId ?? this.muscleGroupId,
      muscleName: muscleName ?? this.muscleName,
      trainingLoadScore: trainingLoadScore ?? this.trainingLoadScore,
      readinessBand: readinessBand ?? this.readinessBand,
      lastTrainedAt: lastTrainedAt is DateTime?
          ? lastTrainedAt
          : this.lastTrainedAt,
      computedAt: computedAt ?? this.computedAt,
      explanation: explanation ?? this.explanation,
    );
  }
}
