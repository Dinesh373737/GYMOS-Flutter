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

abstract class WorkoutSet
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  WorkoutSet._({
    this.id,
    required this.sessionId,
    required this.exerciseId,
    required this.setNumber,
    this.reps,
    this.weightKg,
    this.durationSec,
    this.rpe,
    required this.completedAt,
  });

  factory WorkoutSet({
    int? id,
    required int sessionId,
    required int exerciseId,
    required int setNumber,
    int? reps,
    double? weightKg,
    int? durationSec,
    double? rpe,
    required DateTime completedAt,
  }) = _WorkoutSetImpl;

  factory WorkoutSet.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutSet(
      id: jsonSerialization['id'] as int?,
      sessionId: jsonSerialization['sessionId'] as int,
      exerciseId: jsonSerialization['exerciseId'] as int,
      setNumber: jsonSerialization['setNumber'] as int,
      reps: jsonSerialization['reps'] as int?,
      weightKg: (jsonSerialization['weightKg'] as num?)?.toDouble(),
      durationSec: jsonSerialization['durationSec'] as int?,
      rpe: (jsonSerialization['rpe'] as num?)?.toDouble(),
      completedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['completedAt'],
      ),
    );
  }

  static final t = WorkoutSetTable();

  static const db = WorkoutSetRepository._();

  @override
  int? id;

  int sessionId;

  int exerciseId;

  int setNumber;

  int? reps;

  double? weightKg;

  int? durationSec;

  double? rpe;

  DateTime completedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorkoutSet]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WorkoutSet copyWith({
    int? id,
    int? sessionId,
    int? exerciseId,
    int? setNumber,
    int? reps,
    double? weightKg,
    int? durationSec,
    double? rpe,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutSet',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'exerciseId': exerciseId,
      'setNumber': setNumber,
      if (reps != null) 'reps': reps,
      if (weightKg != null) 'weightKg': weightKg,
      if (durationSec != null) 'durationSec': durationSec,
      if (rpe != null) 'rpe': rpe,
      'completedAt': completedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutSet',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'exerciseId': exerciseId,
      'setNumber': setNumber,
      if (reps != null) 'reps': reps,
      if (weightKg != null) 'weightKg': weightKg,
      if (durationSec != null) 'durationSec': durationSec,
      if (rpe != null) 'rpe': rpe,
      'completedAt': completedAt.toJson(),
    };
  }

  static WorkoutSetInclude include() {
    return WorkoutSetInclude._();
  }

  static WorkoutSetIncludeList includeList({
    _is.WhereExpressionBuilder<WorkoutSetTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutSetTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSetTable>? orderByList,
    WorkoutSetInclude? include,
  }) {
    return WorkoutSetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutSet.t),
      orderByList: orderByList?.call(WorkoutSet.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutSetImpl extends WorkoutSet {
  _WorkoutSetImpl({
    int? id,
    required int sessionId,
    required int exerciseId,
    required int setNumber,
    int? reps,
    double? weightKg,
    int? durationSec,
    double? rpe,
    required DateTime completedAt,
  }) : super._(
         id: id,
         sessionId: sessionId,
         exerciseId: exerciseId,
         setNumber: setNumber,
         reps: reps,
         weightKg: weightKg,
         durationSec: durationSec,
         rpe: rpe,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [WorkoutSet]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WorkoutSet copyWith({
    Object? id = _Undefined,
    int? sessionId,
    int? exerciseId,
    int? setNumber,
    Object? reps = _Undefined,
    Object? weightKg = _Undefined,
    Object? durationSec = _Undefined,
    Object? rpe = _Undefined,
    DateTime? completedAt,
  }) {
    return WorkoutSet(
      id: id is int? ? id : this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseId: exerciseId ?? this.exerciseId,
      setNumber: setNumber ?? this.setNumber,
      reps: reps is int? ? reps : this.reps,
      weightKg: weightKg is double? ? weightKg : this.weightKg,
      durationSec: durationSec is int? ? durationSec : this.durationSec,
      rpe: rpe is double? ? rpe : this.rpe,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

class WorkoutSetUpdateTable extends _is.UpdateTable<WorkoutSetTable> {
  WorkoutSetUpdateTable(super.table);

  _is.ColumnValue<int, int> sessionId(int value) => _is.ColumnValue(
    table.sessionId,
    value,
  );

  _is.ColumnValue<int, int> exerciseId(int value) => _is.ColumnValue(
    table.exerciseId,
    value,
  );

  _is.ColumnValue<int, int> setNumber(int value) => _is.ColumnValue(
    table.setNumber,
    value,
  );

  _is.ColumnValue<int, int> reps(int? value) => _is.ColumnValue(
    table.reps,
    value,
  );

  _is.ColumnValue<double, double> weightKg(double? value) => _is.ColumnValue(
    table.weightKg,
    value,
  );

  _is.ColumnValue<int, int> durationSec(int? value) => _is.ColumnValue(
    table.durationSec,
    value,
  );

  _is.ColumnValue<double, double> rpe(double? value) => _is.ColumnValue(
    table.rpe,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime value) =>
      _is.ColumnValue(
        table.completedAt,
        value,
      );
}

class WorkoutSetTable extends _is.Table<int?> {
  WorkoutSetTable({super.tableRelation}) : super(tableName: 'workout_set') {
    updateTable = WorkoutSetUpdateTable(this);
    sessionId = _is.ColumnInt(
      'sessionId',
      this,
    );
    exerciseId = _is.ColumnInt(
      'exerciseId',
      this,
    );
    setNumber = _is.ColumnInt(
      'setNumber',
      this,
    );
    reps = _is.ColumnInt(
      'reps',
      this,
    );
    weightKg = _is.ColumnDouble(
      'weightKg',
      this,
    );
    durationSec = _is.ColumnInt(
      'durationSec',
      this,
    );
    rpe = _is.ColumnDouble(
      'rpe',
      this,
    );
    completedAt = _is.ColumnDateTime(
      'completedAt',
      this,
    );
  }

  late final WorkoutSetUpdateTable updateTable;

  late final _is.ColumnInt sessionId;

  late final _is.ColumnInt exerciseId;

  late final _is.ColumnInt setNumber;

  late final _is.ColumnInt reps;

  late final _is.ColumnDouble weightKg;

  late final _is.ColumnInt durationSec;

  late final _is.ColumnDouble rpe;

  late final _is.ColumnDateTime completedAt;

  @override
  List<_is.Column> get columns => [
    id,
    sessionId,
    exerciseId,
    setNumber,
    reps,
    weightKg,
    durationSec,
    rpe,
    completedAt,
  ];
}

class WorkoutSetInclude extends _is.IncludeObject {
  WorkoutSetInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => WorkoutSet.t;
}

class WorkoutSetIncludeList extends _is.IncludeList {
  WorkoutSetIncludeList._({
    _is.WhereExpressionBuilder<WorkoutSetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutSet.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => WorkoutSet.t;
}

class WorkoutSetRepository {
  const WorkoutSetRepository._();

  /// Returns a list of [WorkoutSet]s matching the given query parameters.
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
  Future<List<WorkoutSet>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutSetTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutSetTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSetTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorkoutSet>(
      where: where?.call(WorkoutSet.t),
      orderBy: orderBy?.call(WorkoutSet.t),
      orderByList: orderByList?.call(WorkoutSet.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorkoutSet] matching the given query parameters.
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
  Future<WorkoutSet?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutSetTable>? where,
    int? offset,
    _is.OrderByBuilder<WorkoutSetTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSetTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorkoutSet>(
      where: where?.call(WorkoutSet.t),
      orderBy: orderBy?.call(WorkoutSet.t),
      orderByList: orderByList?.call(WorkoutSet.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorkoutSet] by its [id] or null if no such row exists.
  Future<WorkoutSet?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorkoutSet>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorkoutSet]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutSet]s will have their `id` fields set.
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
  Future<List<WorkoutSet>> insert(
    _is.DatabaseSession session,
    List<WorkoutSet> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<WorkoutSet>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [WorkoutSet] and returns the inserted row.
  ///
  /// The returned [WorkoutSet] will have its `id` field set.
  Future<WorkoutSet> insertRow(
    _is.DatabaseSession session,
    WorkoutSet row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutSet>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [WorkoutSet]s in the list and returns the resulting rows.
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
  /// The returned [WorkoutSet]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutSet>> upsert(
    _is.DatabaseSession session,
    List<WorkoutSet> rows, {
    required _is.ColumnSelections<WorkoutSetTable> conflictColumns,
    _is.ColumnSelections<WorkoutSetTable>? updateColumns,
    _is.WhereExpressionBuilder<WorkoutSetTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<WorkoutSet>(
      rows,
      conflictColumns: conflictColumns(WorkoutSet.t),
      updateColumns: updateColumns?.call(WorkoutSet.t),
      updateWhere: updateWhere?.call(WorkoutSet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [WorkoutSet] and returns the resulting row.
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
  /// The returned [WorkoutSet] will have its `id` field set.
  Future<WorkoutSet?> upsertRow(
    _is.DatabaseSession session,
    WorkoutSet row, {
    required _is.ColumnSelections<WorkoutSetTable> conflictColumns,
    _is.ColumnSelections<WorkoutSetTable>? updateColumns,
    _is.WhereExpressionBuilder<WorkoutSetTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<WorkoutSet>(
      row,
      conflictColumns: conflictColumns(WorkoutSet.t),
      updateColumns: updateColumns?.call(WorkoutSet.t),
      updateWhere: updateWhere?.call(WorkoutSet.t),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutSet]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutSet>> update(
    _is.DatabaseSession session,
    List<WorkoutSet> rows, {
    _is.ColumnSelections<WorkoutSetTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<WorkoutSet>(
      rows,
      columns: columns?.call(WorkoutSet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [WorkoutSet]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutSet> updateRow(
    _is.DatabaseSession session,
    WorkoutSet row, {
    _is.ColumnSelections<WorkoutSetTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutSet>(
      row,
      columns: columns?.call(WorkoutSet.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutSet] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutSet?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<WorkoutSetUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutSet>(
      id,
      columnValues: columnValues(WorkoutSet.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutSet]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutSet>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<WorkoutSetUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<WorkoutSetTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutSetTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<WorkoutSet>(
      columnValues: columnValues(WorkoutSet.t.updateTable),
      where: where(WorkoutSet.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutSet.t),
      orderByList: orderByList?.call(WorkoutSet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [WorkoutSet]s in the list and returns the deleted rows.
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
  Future<List<WorkoutSet>> delete(
    _is.DatabaseSession session,
    List<WorkoutSet> rows, {
    _is.OrderByBuilder<WorkoutSetTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<WorkoutSet>(
      rows,
      orderBy: orderBy?.call(WorkoutSet.t),
      orderByList: orderByList?.call(WorkoutSet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [WorkoutSet].
  Future<WorkoutSet> deleteRow(
    _is.DatabaseSession session,
    WorkoutSet row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutSet>(
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
  Future<List<WorkoutSet>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorkoutSetTable> where,
    _is.OrderByBuilder<WorkoutSetTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<WorkoutSet>(
      where: where(WorkoutSet.t),
      orderBy: orderBy?.call(WorkoutSet.t),
      orderByList: orderByList?.call(WorkoutSet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutSetTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutSet>(
      where: where?.call(WorkoutSet.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorkoutSet] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorkoutSetTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorkoutSet>(
      where: where(WorkoutSet.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
