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

abstract class WorkoutSession
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  WorkoutSession._({
    this.id,
    required this.userId,
    required this.planId,
    required this.title,
    required this.startedAt,
    this.endedAt,
    this.durationMin,
    required this.notes,
    this.perceivedEffort,
  });

  factory WorkoutSession({
    int? id,
    required int userId,
    required int planId,
    required String title,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMin,
    required String notes,
    double? perceivedEffort,
  }) = _WorkoutSessionImpl;

  factory WorkoutSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutSession(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      planId: jsonSerialization['planId'] as int,
      title: jsonSerialization['title'] as String,
      startedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      durationMin: jsonSerialization['durationMin'] as int?,
      notes: jsonSerialization['notes'] as String,
      perceivedEffort: (jsonSerialization['perceivedEffort'] as num?)
          ?.toDouble(),
    );
  }

  static final t = WorkoutSessionTable();

  static const db = WorkoutSessionRepository._();

  @override
  int? id;

  int userId;

  int planId;

  String title;

  DateTime startedAt;

  DateTime? endedAt;

  int? durationMin;

  String notes;

  double? perceivedEffort;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorkoutSession]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WorkoutSession copyWith({
    int? id,
    int? userId,
    int? planId,
    String? title,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMin,
    String? notes,
    double? perceivedEffort,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutSession',
      if (id != null) 'id': id,
      'userId': userId,
      'planId': planId,
      'title': title,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (durationMin != null) 'durationMin': durationMin,
      'notes': notes,
      if (perceivedEffort != null) 'perceivedEffort': perceivedEffort,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutSession',
      if (id != null) 'id': id,
      'userId': userId,
      'planId': planId,
      'title': title,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (durationMin != null) 'durationMin': durationMin,
      'notes': notes,
      if (perceivedEffort != null) 'perceivedEffort': perceivedEffort,
    };
  }

  static WorkoutSessionInclude include() {
    return WorkoutSessionInclude._();
  }

  static WorkoutSessionIncludeList includeList({
    _is.WhereExpressionBuilder<WorkoutSessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutSessionTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSessionTable>? orderByList,
    WorkoutSessionInclude? include,
  }) {
    return WorkoutSessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutSession.t),
      orderByList: orderByList?.call(WorkoutSession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutSessionImpl extends WorkoutSession {
  _WorkoutSessionImpl({
    int? id,
    required int userId,
    required int planId,
    required String title,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMin,
    required String notes,
    double? perceivedEffort,
  }) : super._(
         id: id,
         userId: userId,
         planId: planId,
         title: title,
         startedAt: startedAt,
         endedAt: endedAt,
         durationMin: durationMin,
         notes: notes,
         perceivedEffort: perceivedEffort,
       );

  /// Returns a shallow copy of this [WorkoutSession]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WorkoutSession copyWith({
    Object? id = _Undefined,
    int? userId,
    int? planId,
    String? title,
    DateTime? startedAt,
    Object? endedAt = _Undefined,
    Object? durationMin = _Undefined,
    String? notes,
    Object? perceivedEffort = _Undefined,
  }) {
    return WorkoutSession(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      planId: planId ?? this.planId,
      title: title ?? this.title,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      durationMin: durationMin is int? ? durationMin : this.durationMin,
      notes: notes ?? this.notes,
      perceivedEffort: perceivedEffort is double?
          ? perceivedEffort
          : this.perceivedEffort,
    );
  }
}

class WorkoutSessionUpdateTable extends _is.UpdateTable<WorkoutSessionTable> {
  WorkoutSessionUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> planId(int value) => _is.ColumnValue(
    table.planId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endedAt(DateTime? value) =>
      _is.ColumnValue(
        table.endedAt,
        value,
      );

  _is.ColumnValue<int, int> durationMin(int? value) => _is.ColumnValue(
    table.durationMin,
    value,
  );

  _is.ColumnValue<String, String> notes(String value) => _is.ColumnValue(
    table.notes,
    value,
  );

  _is.ColumnValue<double, double> perceivedEffort(double? value) =>
      _is.ColumnValue(
        table.perceivedEffort,
        value,
      );
}

class WorkoutSessionTable extends _is.Table<int?> {
  WorkoutSessionTable({super.tableRelation})
    : super(tableName: 'workout_session') {
    updateTable = WorkoutSessionUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    planId = _is.ColumnInt(
      'planId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
    endedAt = _is.ColumnDateTime(
      'endedAt',
      this,
    );
    durationMin = _is.ColumnInt(
      'durationMin',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
    perceivedEffort = _is.ColumnDouble(
      'perceivedEffort',
      this,
    );
  }

  late final WorkoutSessionUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt planId;

  late final _is.ColumnString title;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnDateTime endedAt;

  late final _is.ColumnInt durationMin;

  late final _is.ColumnString notes;

  late final _is.ColumnDouble perceivedEffort;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    planId,
    title,
    startedAt,
    endedAt,
    durationMin,
    notes,
    perceivedEffort,
  ];
}

class WorkoutSessionInclude extends _is.IncludeObject {
  WorkoutSessionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => WorkoutSession.t;
}

class WorkoutSessionIncludeList extends _is.IncludeList {
  WorkoutSessionIncludeList._({
    _is.WhereExpressionBuilder<WorkoutSessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutSession.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => WorkoutSession.t;
}

class WorkoutSessionRepository {
  const WorkoutSessionRepository._();

  /// Returns a list of [WorkoutSession]s matching the given query parameters.
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
  Future<List<WorkoutSession>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutSessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutSessionTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSessionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorkoutSession>(
      where: where?.call(WorkoutSession.t),
      orderBy: orderBy?.call(WorkoutSession.t),
      orderByList: orderByList?.call(WorkoutSession.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorkoutSession] matching the given query parameters.
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
  Future<WorkoutSession?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutSessionTable>? where,
    int? offset,
    _is.OrderByBuilder<WorkoutSessionTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSessionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorkoutSession>(
      where: where?.call(WorkoutSession.t),
      orderBy: orderBy?.call(WorkoutSession.t),
      orderByList: orderByList?.call(WorkoutSession.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorkoutSession] by its [id] or null if no such row exists.
  Future<WorkoutSession?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorkoutSession>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorkoutSession]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutSession]s will have their `id` fields set.
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
  Future<List<WorkoutSession>> insert(
    _is.DatabaseSession session,
    List<WorkoutSession> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<WorkoutSession>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [WorkoutSession] and returns the inserted row.
  ///
  /// The returned [WorkoutSession] will have its `id` field set.
  Future<WorkoutSession> insertRow(
    _is.DatabaseSession session,
    WorkoutSession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutSession>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [WorkoutSession]s in the list and returns the resulting rows.
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
  /// The returned [WorkoutSession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutSession>> upsert(
    _is.DatabaseSession session,
    List<WorkoutSession> rows, {
    required _is.ColumnSelections<WorkoutSessionTable> conflictColumns,
    _is.ColumnSelections<WorkoutSessionTable>? updateColumns,
    _is.WhereExpressionBuilder<WorkoutSessionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<WorkoutSession>(
      rows,
      conflictColumns: conflictColumns(WorkoutSession.t),
      updateColumns: updateColumns?.call(WorkoutSession.t),
      updateWhere: updateWhere?.call(WorkoutSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [WorkoutSession] and returns the resulting row.
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
  /// The returned [WorkoutSession] will have its `id` field set.
  Future<WorkoutSession?> upsertRow(
    _is.DatabaseSession session,
    WorkoutSession row, {
    required _is.ColumnSelections<WorkoutSessionTable> conflictColumns,
    _is.ColumnSelections<WorkoutSessionTable>? updateColumns,
    _is.WhereExpressionBuilder<WorkoutSessionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<WorkoutSession>(
      row,
      conflictColumns: conflictColumns(WorkoutSession.t),
      updateColumns: updateColumns?.call(WorkoutSession.t),
      updateWhere: updateWhere?.call(WorkoutSession.t),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutSession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutSession>> update(
    _is.DatabaseSession session,
    List<WorkoutSession> rows, {
    _is.ColumnSelections<WorkoutSessionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<WorkoutSession>(
      rows,
      columns: columns?.call(WorkoutSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [WorkoutSession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutSession> updateRow(
    _is.DatabaseSession session,
    WorkoutSession row, {
    _is.ColumnSelections<WorkoutSessionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutSession>(
      row,
      columns: columns?.call(WorkoutSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutSession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutSession?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<WorkoutSessionUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutSession>(
      id,
      columnValues: columnValues(WorkoutSession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutSession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutSession>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<WorkoutSessionUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<WorkoutSessionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutSessionTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<WorkoutSession>(
      columnValues: columnValues(WorkoutSession.t.updateTable),
      where: where(WorkoutSession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutSession.t),
      orderByList: orderByList?.call(WorkoutSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [WorkoutSession]s in the list and returns the deleted rows.
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
  Future<List<WorkoutSession>> delete(
    _is.DatabaseSession session,
    List<WorkoutSession> rows, {
    _is.OrderByBuilder<WorkoutSessionTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<WorkoutSession>(
      rows,
      orderBy: orderBy?.call(WorkoutSession.t),
      orderByList: orderByList?.call(WorkoutSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [WorkoutSession].
  Future<WorkoutSession> deleteRow(
    _is.DatabaseSession session,
    WorkoutSession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutSession>(
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
  Future<List<WorkoutSession>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorkoutSessionTable> where,
    _is.OrderByBuilder<WorkoutSessionTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<WorkoutSession>(
      where: where(WorkoutSession.t),
      orderBy: orderBy?.call(WorkoutSession.t),
      orderByList: orderByList?.call(WorkoutSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutSessionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutSession>(
      where: where?.call(WorkoutSession.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorkoutSession] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorkoutSessionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorkoutSession>(
      where: where(WorkoutSession.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
