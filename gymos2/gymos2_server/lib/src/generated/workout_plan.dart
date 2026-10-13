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

abstract class WorkoutPlan
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  WorkoutPlan._({
    this.id,
    required this.userId,
    required this.title,
    required this.createdByType,
    required this.target,
    required this.plannedDurationMin,
    required this.createdAt,
    required this.status,
  });

  factory WorkoutPlan({
    int? id,
    required int userId,
    required String title,
    required String createdByType,
    required String target,
    required int plannedDurationMin,
    required DateTime createdAt,
    required String status,
  }) = _WorkoutPlanImpl;

  factory WorkoutPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutPlan(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      createdByType: jsonSerialization['createdByType'] as String,
      target: jsonSerialization['target'] as String,
      plannedDurationMin: jsonSerialization['plannedDurationMin'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      status: jsonSerialization['status'] as String,
    );
  }

  static final t = WorkoutPlanTable();

  static const db = WorkoutPlanRepository._();

  @override
  int? id;

  int userId;

  String title;

  String createdByType;

  String target;

  int plannedDurationMin;

  DateTime createdAt;

  String status;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorkoutPlan]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WorkoutPlan copyWith({
    int? id,
    int? userId,
    String? title,
    String? createdByType,
    String? target,
    int? plannedDurationMin,
    DateTime? createdAt,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutPlan',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'createdByType': createdByType,
      'target': target,
      'plannedDurationMin': plannedDurationMin,
      'createdAt': createdAt.toJson(),
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutPlan',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'createdByType': createdByType,
      'target': target,
      'plannedDurationMin': plannedDurationMin,
      'createdAt': createdAt.toJson(),
      'status': status,
    };
  }

  static WorkoutPlanInclude include() {
    return WorkoutPlanInclude._();
  }

  static WorkoutPlanIncludeList includeList({
    _is.WhereExpressionBuilder<WorkoutPlanTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutPlanTable>? orderBy,
    _is.OrderByListBuilder<WorkoutPlanTable>? orderByList,
    WorkoutPlanInclude? include,
  }) {
    return WorkoutPlanIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutPlan.t),
      orderByList: orderByList?.call(WorkoutPlan.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutPlanImpl extends WorkoutPlan {
  _WorkoutPlanImpl({
    int? id,
    required int userId,
    required String title,
    required String createdByType,
    required String target,
    required int plannedDurationMin,
    required DateTime createdAt,
    required String status,
  }) : super._(
         id: id,
         userId: userId,
         title: title,
         createdByType: createdByType,
         target: target,
         plannedDurationMin: plannedDurationMin,
         createdAt: createdAt,
         status: status,
       );

  /// Returns a shallow copy of this [WorkoutPlan]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WorkoutPlan copyWith({
    Object? id = _Undefined,
    int? userId,
    String? title,
    String? createdByType,
    String? target,
    int? plannedDurationMin,
    DateTime? createdAt,
    String? status,
  }) {
    return WorkoutPlan(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      createdByType: createdByType ?? this.createdByType,
      target: target ?? this.target,
      plannedDurationMin: plannedDurationMin ?? this.plannedDurationMin,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}

class WorkoutPlanUpdateTable extends _is.UpdateTable<WorkoutPlanTable> {
  WorkoutPlanUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> createdByType(String value) =>
      _is.ColumnValue(
        table.createdByType,
        value,
      );

  _is.ColumnValue<String, String> target(String value) => _is.ColumnValue(
    table.target,
    value,
  );

  _is.ColumnValue<int, int> plannedDurationMin(int value) => _is.ColumnValue(
    table.plannedDurationMin,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );
}

class WorkoutPlanTable extends _is.Table<int?> {
  WorkoutPlanTable({super.tableRelation}) : super(tableName: 'workout_plan') {
    updateTable = WorkoutPlanUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    createdByType = _is.ColumnString(
      'createdByType',
      this,
    );
    target = _is.ColumnString(
      'target',
      this,
    );
    plannedDurationMin = _is.ColumnInt(
      'plannedDurationMin',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
  }

  late final WorkoutPlanUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnString title;

  late final _is.ColumnString createdByType;

  late final _is.ColumnString target;

  late final _is.ColumnInt plannedDurationMin;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnString status;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    title,
    createdByType,
    target,
    plannedDurationMin,
    createdAt,
    status,
  ];
}

class WorkoutPlanInclude extends _is.IncludeObject {
  WorkoutPlanInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => WorkoutPlan.t;
}

class WorkoutPlanIncludeList extends _is.IncludeList {
  WorkoutPlanIncludeList._({
    _is.WhereExpressionBuilder<WorkoutPlanTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutPlan.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => WorkoutPlan.t;
}

class WorkoutPlanRepository {
  const WorkoutPlanRepository._();

  /// Returns a list of [WorkoutPlan]s matching the given query parameters.
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
  Future<List<WorkoutPlan>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutPlanTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutPlanTable>? orderBy,
    _is.OrderByListBuilder<WorkoutPlanTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorkoutPlan>(
      where: where?.call(WorkoutPlan.t),
      orderBy: orderBy?.call(WorkoutPlan.t),
      orderByList: orderByList?.call(WorkoutPlan.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorkoutPlan] matching the given query parameters.
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
  Future<WorkoutPlan?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutPlanTable>? where,
    int? offset,
    _is.OrderByBuilder<WorkoutPlanTable>? orderBy,
    _is.OrderByListBuilder<WorkoutPlanTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorkoutPlan>(
      where: where?.call(WorkoutPlan.t),
      orderBy: orderBy?.call(WorkoutPlan.t),
      orderByList: orderByList?.call(WorkoutPlan.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorkoutPlan] by its [id] or null if no such row exists.
  Future<WorkoutPlan?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorkoutPlan>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorkoutPlan]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutPlan]s will have their `id` fields set.
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
  Future<List<WorkoutPlan>> insert(
    _is.DatabaseSession session,
    List<WorkoutPlan> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<WorkoutPlan>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [WorkoutPlan] and returns the inserted row.
  ///
  /// The returned [WorkoutPlan] will have its `id` field set.
  Future<WorkoutPlan> insertRow(
    _is.DatabaseSession session,
    WorkoutPlan row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [WorkoutPlan]s in the list and returns the resulting rows.
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
  /// The returned [WorkoutPlan]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutPlan>> upsert(
    _is.DatabaseSession session,
    List<WorkoutPlan> rows, {
    required _is.ColumnSelections<WorkoutPlanTable> conflictColumns,
    _is.ColumnSelections<WorkoutPlanTable>? updateColumns,
    _is.WhereExpressionBuilder<WorkoutPlanTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<WorkoutPlan>(
      rows,
      conflictColumns: conflictColumns(WorkoutPlan.t),
      updateColumns: updateColumns?.call(WorkoutPlan.t),
      updateWhere: updateWhere?.call(WorkoutPlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [WorkoutPlan] and returns the resulting row.
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
  /// The returned [WorkoutPlan] will have its `id` field set.
  Future<WorkoutPlan?> upsertRow(
    _is.DatabaseSession session,
    WorkoutPlan row, {
    required _is.ColumnSelections<WorkoutPlanTable> conflictColumns,
    _is.ColumnSelections<WorkoutPlanTable>? updateColumns,
    _is.WhereExpressionBuilder<WorkoutPlanTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<WorkoutPlan>(
      row,
      conflictColumns: conflictColumns(WorkoutPlan.t),
      updateColumns: updateColumns?.call(WorkoutPlan.t),
      updateWhere: updateWhere?.call(WorkoutPlan.t),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutPlan]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutPlan>> update(
    _is.DatabaseSession session,
    List<WorkoutPlan> rows, {
    _is.ColumnSelections<WorkoutPlanTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<WorkoutPlan>(
      rows,
      columns: columns?.call(WorkoutPlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [WorkoutPlan]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutPlan> updateRow(
    _is.DatabaseSession session,
    WorkoutPlan row, {
    _is.ColumnSelections<WorkoutPlanTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutPlan>(
      row,
      columns: columns?.call(WorkoutPlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutPlan] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutPlan?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<WorkoutPlanUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutPlan>(
      id,
      columnValues: columnValues(WorkoutPlan.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutPlan]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutPlan>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<WorkoutPlanUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<WorkoutPlanTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutPlanTable>? orderBy,
    _is.OrderByListBuilder<WorkoutPlanTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<WorkoutPlan>(
      columnValues: columnValues(WorkoutPlan.t.updateTable),
      where: where(WorkoutPlan.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutPlan.t),
      orderByList: orderByList?.call(WorkoutPlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [WorkoutPlan]s in the list and returns the deleted rows.
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
  Future<List<WorkoutPlan>> delete(
    _is.DatabaseSession session,
    List<WorkoutPlan> rows, {
    _is.OrderByBuilder<WorkoutPlanTable>? orderBy,
    _is.OrderByListBuilder<WorkoutPlanTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<WorkoutPlan>(
      rows,
      orderBy: orderBy?.call(WorkoutPlan.t),
      orderByList: orderByList?.call(WorkoutPlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [WorkoutPlan].
  Future<WorkoutPlan> deleteRow(
    _is.DatabaseSession session,
    WorkoutPlan row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutPlan>(
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
  Future<List<WorkoutPlan>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorkoutPlanTable> where,
    _is.OrderByBuilder<WorkoutPlanTable>? orderBy,
    _is.OrderByListBuilder<WorkoutPlanTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<WorkoutPlan>(
      where: where(WorkoutPlan.t),
      orderBy: orderBy?.call(WorkoutPlan.t),
      orderByList: orderByList?.call(WorkoutPlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutPlanTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutPlan>(
      where: where?.call(WorkoutPlan.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorkoutPlan] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorkoutPlanTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorkoutPlan>(
      where: where(WorkoutPlan.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
