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
import 'package:serverpod/serverpod.dart' as _is;

abstract class TrainingReadiness
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastTrainedAt'],
            ),
      computedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['computedAt'],
      ),
      explanation: jsonSerialization['explanation'] as String,
    );
  }

  static final t = TrainingReadinessTable();

  static const db = TrainingReadinessRepository._();

  @override
  int? id;

  int userId;

  int muscleGroupId;

  String muscleName;

  double trainingLoadScore;

  String readinessBand;

  DateTime? lastTrainedAt;

  DateTime computedAt;

  String explanation;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TrainingReadiness]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static TrainingReadinessInclude include() {
    return TrainingReadinessInclude._();
  }

  static TrainingReadinessIncludeList includeList({
    _is.WhereExpressionBuilder<TrainingReadinessTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TrainingReadinessTable>? orderBy,
    _is.OrderByListBuilder<TrainingReadinessTable>? orderByList,
    TrainingReadinessInclude? include,
  }) {
    return TrainingReadinessIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingReadiness.t),
      orderByList: orderByList?.call(TrainingReadiness.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class TrainingReadinessUpdateTable
    extends _is.UpdateTable<TrainingReadinessTable> {
  TrainingReadinessUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> muscleGroupId(int value) => _is.ColumnValue(
    table.muscleGroupId,
    value,
  );

  _is.ColumnValue<String, String> muscleName(String value) => _is.ColumnValue(
    table.muscleName,
    value,
  );

  _is.ColumnValue<double, double> trainingLoadScore(double value) =>
      _is.ColumnValue(
        table.trainingLoadScore,
        value,
      );

  _is.ColumnValue<String, String> readinessBand(String value) =>
      _is.ColumnValue(
        table.readinessBand,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastTrainedAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastTrainedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> computedAt(DateTime value) =>
      _is.ColumnValue(
        table.computedAt,
        value,
      );

  _is.ColumnValue<String, String> explanation(String value) => _is.ColumnValue(
    table.explanation,
    value,
  );
}

class TrainingReadinessTable extends _is.Table<int?> {
  TrainingReadinessTable({super.tableRelation})
    : super(tableName: 'training_readiness') {
    updateTable = TrainingReadinessUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    muscleGroupId = _is.ColumnInt(
      'muscleGroupId',
      this,
    );
    muscleName = _is.ColumnString(
      'muscleName',
      this,
    );
    trainingLoadScore = _is.ColumnDouble(
      'trainingLoadScore',
      this,
    );
    readinessBand = _is.ColumnString(
      'readinessBand',
      this,
    );
    lastTrainedAt = _is.ColumnDateTime(
      'lastTrainedAt',
      this,
    );
    computedAt = _is.ColumnDateTime(
      'computedAt',
      this,
    );
    explanation = _is.ColumnString(
      'explanation',
      this,
    );
  }

  late final TrainingReadinessUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt muscleGroupId;

  late final _is.ColumnString muscleName;

  late final _is.ColumnDouble trainingLoadScore;

  late final _is.ColumnString readinessBand;

  late final _is.ColumnDateTime lastTrainedAt;

  late final _is.ColumnDateTime computedAt;

  late final _is.ColumnString explanation;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    muscleGroupId,
    muscleName,
    trainingLoadScore,
    readinessBand,
    lastTrainedAt,
    computedAt,
    explanation,
  ];
}

class TrainingReadinessInclude extends _is.IncludeObject {
  TrainingReadinessInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => TrainingReadiness.t;
}

class TrainingReadinessIncludeList extends _is.IncludeList {
  TrainingReadinessIncludeList._({
    _is.WhereExpressionBuilder<TrainingReadinessTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingReadiness.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TrainingReadiness.t;
}

class TrainingReadinessRepository {
  const TrainingReadinessRepository._();

  /// Returns a list of [TrainingReadiness]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<TrainingReadiness>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TrainingReadinessTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TrainingReadinessTable>? orderBy,
    _is.OrderByListBuilder<TrainingReadinessTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingReadiness>(
      where: where?.call(TrainingReadiness.t),
      orderBy: orderBy?.call(TrainingReadiness.t),
      orderByList: orderByList?.call(TrainingReadiness.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingReadiness] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<TrainingReadiness?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TrainingReadinessTable>? where,
    int? offset,
    _is.OrderByBuilder<TrainingReadinessTable>? orderBy,
    _is.OrderByListBuilder<TrainingReadinessTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingReadiness>(
      where: where?.call(TrainingReadiness.t),
      orderBy: orderBy?.call(TrainingReadiness.t),
      orderByList: orderByList?.call(TrainingReadiness.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingReadiness] by its [id] or null if no such row exists.
  Future<TrainingReadiness?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingReadiness>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingReadiness]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingReadiness]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TrainingReadiness>> insert(
    _is.DatabaseSession session,
    List<TrainingReadiness> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TrainingReadiness>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TrainingReadiness] and returns the inserted row.
  ///
  /// The returned [TrainingReadiness] will have its `id` field set.
  Future<TrainingReadiness> insertRow(
    _is.DatabaseSession session,
    TrainingReadiness row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingReadiness>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TrainingReadiness]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [TrainingReadiness]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TrainingReadiness>> upsert(
    _is.DatabaseSession session,
    List<TrainingReadiness> rows, {
    required _is.ColumnSelections<TrainingReadinessTable> conflictColumns,
    _is.ColumnSelections<TrainingReadinessTable>? updateColumns,
    _is.WhereExpressionBuilder<TrainingReadinessTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TrainingReadiness>(
      rows,
      conflictColumns: conflictColumns(TrainingReadiness.t),
      updateColumns: updateColumns?.call(TrainingReadiness.t),
      updateWhere: updateWhere?.call(TrainingReadiness.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TrainingReadiness] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [TrainingReadiness] will have its `id` field set.
  Future<TrainingReadiness?> upsertRow(
    _is.DatabaseSession session,
    TrainingReadiness row, {
    required _is.ColumnSelections<TrainingReadinessTable> conflictColumns,
    _is.ColumnSelections<TrainingReadinessTable>? updateColumns,
    _is.WhereExpressionBuilder<TrainingReadinessTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TrainingReadiness>(
      row,
      conflictColumns: conflictColumns(TrainingReadiness.t),
      updateColumns: updateColumns?.call(TrainingReadiness.t),
      updateWhere: updateWhere?.call(TrainingReadiness.t),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingReadiness]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TrainingReadiness>> update(
    _is.DatabaseSession session,
    List<TrainingReadiness> rows, {
    _is.ColumnSelections<TrainingReadinessTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TrainingReadiness>(
      rows,
      columns: columns?.call(TrainingReadiness.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TrainingReadiness]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingReadiness> updateRow(
    _is.DatabaseSession session,
    TrainingReadiness row, {
    _is.ColumnSelections<TrainingReadinessTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingReadiness>(
      row,
      columns: columns?.call(TrainingReadiness.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingReadiness] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingReadiness?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TrainingReadinessUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingReadiness>(
      id,
      columnValues: columnValues(TrainingReadiness.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingReadiness]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TrainingReadiness>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TrainingReadinessUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<TrainingReadinessTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TrainingReadinessTable>? orderBy,
    _is.OrderByListBuilder<TrainingReadinessTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TrainingReadiness>(
      columnValues: columnValues(TrainingReadiness.t.updateTable),
      where: where(TrainingReadiness.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingReadiness.t),
      orderByList: orderByList?.call(TrainingReadiness.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TrainingReadiness]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TrainingReadiness>> delete(
    _is.DatabaseSession session,
    List<TrainingReadiness> rows, {
    _is.OrderByBuilder<TrainingReadinessTable>? orderBy,
    _is.OrderByListBuilder<TrainingReadinessTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TrainingReadiness>(
      rows,
      orderBy: orderBy?.call(TrainingReadiness.t),
      orderByList: orderByList?.call(TrainingReadiness.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TrainingReadiness].
  Future<TrainingReadiness> deleteRow(
    _is.DatabaseSession session,
    TrainingReadiness row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingReadiness>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TrainingReadiness>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TrainingReadinessTable> where,
    _is.OrderByBuilder<TrainingReadinessTable>? orderBy,
    _is.OrderByListBuilder<TrainingReadinessTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TrainingReadiness>(
      where: where(TrainingReadiness.t),
      orderBy: orderBy?.call(TrainingReadiness.t),
      orderByList: orderByList?.call(TrainingReadiness.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TrainingReadinessTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TrainingReadiness>(
      where: where?.call(TrainingReadiness.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingReadiness] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TrainingReadinessTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingReadiness>(
      where: where(TrainingReadiness.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
