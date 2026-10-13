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

abstract class WorkoutPlanItem
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  WorkoutPlanItem._({
    this.id,
    required this.planId,
    required this.exerciseId,
    required this.orderIndex,
    required this.targetSets,
    required this.targetRepsText,
    this.suggestedWeight,
    required this.restSeconds,
    required this.rationale,
  });

  factory WorkoutPlanItem({
    int? id,
    required int planId,
    required int exerciseId,
    required int orderIndex,
    required int targetSets,
    required String targetRepsText,
    double? suggestedWeight,
    required int restSeconds,
    required String rationale,
  }) = _WorkoutPlanItemImpl;

  factory WorkoutPlanItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutPlanItem(
      id: jsonSerialization['id'] as int?,
      planId: jsonSerialization['planId'] as int,
      exerciseId: jsonSerialization['exerciseId'] as int,
      orderIndex: jsonSerialization['orderIndex'] as int,
      targetSets: jsonSerialization['targetSets'] as int,
      targetRepsText: jsonSerialization['targetRepsText'] as String,
      suggestedWeight: (jsonSerialization['suggestedWeight'] as num?)
          ?.toDouble(),
      restSeconds: jsonSerialization['restSeconds'] as int,
      rationale: jsonSerialization['rationale'] as String,
    );
  }

  static final t = WorkoutPlanItemTable();

  static const db = WorkoutPlanItemRepository._();

  @override
  int? id;

  int planId;

  int exerciseId;

  int orderIndex;

  int targetSets;

  String targetRepsText;

  double? suggestedWeight;

  int restSeconds;

  String rationale;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorkoutPlanItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WorkoutPlanItem copyWith({
    int? id,
    int? planId,
    int? exerciseId,
    int? orderIndex,
    int? targetSets,
    String? targetRepsText,
    double? suggestedWeight,
    int? restSeconds,
    String? rationale,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutPlanItem',
      if (id != null) 'id': id,
      'planId': planId,
      'exerciseId': exerciseId,
      'orderIndex': orderIndex,
      'targetSets': targetSets,
      'targetRepsText': targetRepsText,
      if (suggestedWeight != null) 'suggestedWeight': suggestedWeight,
      'restSeconds': restSeconds,
      'rationale': rationale,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutPlanItem',
      if (id != null) 'id': id,
      'planId': planId,
      'exerciseId': exerciseId,
      'orderIndex': orderIndex,
      'targetSets': targetSets,
      'targetRepsText': targetRepsText,
      if (suggestedWeight != null) 'suggestedWeight': suggestedWeight,
      'restSeconds': restSeconds,
      'rationale': rationale,
    };
  }

  static WorkoutPlanItemInclude include() {
    return WorkoutPlanItemInclude._();
  }

  static WorkoutPlanItemIncludeList includeList({
    _is.WhereExpressionBuilder<WorkoutPlanItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutPlanItemTable>? orderBy,
    _is.OrderByListBuilder<WorkoutPlanItemTable>? orderByList,
    WorkoutPlanItemInclude? include,
  }) {
    return WorkoutPlanItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutPlanItem.t),
      orderByList: orderByList?.call(WorkoutPlanItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutPlanItemImpl extends WorkoutPlanItem {
  _WorkoutPlanItemImpl({
    int? id,
    required int planId,
    required int exerciseId,
    required int orderIndex,
    required int targetSets,
    required String targetRepsText,
    double? suggestedWeight,
    required int restSeconds,
    required String rationale,
  }) : super._(
         id: id,
         planId: planId,
         exerciseId: exerciseId,
         orderIndex: orderIndex,
         targetSets: targetSets,
         targetRepsText: targetRepsText,
         suggestedWeight: suggestedWeight,
         restSeconds: restSeconds,
         rationale: rationale,
       );

  /// Returns a shallow copy of this [WorkoutPlanItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WorkoutPlanItem copyWith({
    Object? id = _Undefined,
    int? planId,
    int? exerciseId,
    int? orderIndex,
    int? targetSets,
    String? targetRepsText,
    Object? suggestedWeight = _Undefined,
    int? restSeconds,
    String? rationale,
  }) {
    return WorkoutPlanItem(
      id: id is int? ? id : this.id,
      planId: planId ?? this.planId,
      exerciseId: exerciseId ?? this.exerciseId,
      orderIndex: orderIndex ?? this.orderIndex,
      targetSets: targetSets ?? this.targetSets,
      targetRepsText: targetRepsText ?? this.targetRepsText,
      suggestedWeight: suggestedWeight is double?
          ? suggestedWeight
          : this.suggestedWeight,
      restSeconds: restSeconds ?? this.restSeconds,
      rationale: rationale ?? this.rationale,
    );
  }
}

class WorkoutPlanItemUpdateTable extends _is.UpdateTable<WorkoutPlanItemTable> {
  WorkoutPlanItemUpdateTable(super.table);

  _is.ColumnValue<int, int> planId(int value) => _is.ColumnValue(
    table.planId,
    value,
  );

  _is.ColumnValue<int, int> exerciseId(int value) => _is.ColumnValue(
    table.exerciseId,
    value,
  );

  _is.ColumnValue<int, int> orderIndex(int value) => _is.ColumnValue(
    table.orderIndex,
    value,
  );

  _is.ColumnValue<int, int> targetSets(int value) => _is.ColumnValue(
    table.targetSets,
    value,
  );

  _is.ColumnValue<String, String> targetRepsText(String value) =>
      _is.ColumnValue(
        table.targetRepsText,
        value,
      );

  _is.ColumnValue<double, double> suggestedWeight(double? value) =>
      _is.ColumnValue(
        table.suggestedWeight,
        value,
      );

  _is.ColumnValue<int, int> restSeconds(int value) => _is.ColumnValue(
    table.restSeconds,
    value,
  );

  _is.ColumnValue<String, String> rationale(String value) => _is.ColumnValue(
    table.rationale,
    value,
  );
}

class WorkoutPlanItemTable extends _is.Table<int?> {
  WorkoutPlanItemTable({super.tableRelation})
    : super(tableName: 'workout_plan_item') {
    updateTable = WorkoutPlanItemUpdateTable(this);
    planId = _is.ColumnInt(
      'planId',
      this,
    );
    exerciseId = _is.ColumnInt(
      'exerciseId',
      this,
    );
    orderIndex = _is.ColumnInt(
      'orderIndex',
      this,
    );
    targetSets = _is.ColumnInt(
      'targetSets',
      this,
    );
    targetRepsText = _is.ColumnString(
      'targetRepsText',
      this,
    );
    suggestedWeight = _is.ColumnDouble(
      'suggestedWeight',
      this,
    );
    restSeconds = _is.ColumnInt(
      'restSeconds',
      this,
    );
    rationale = _is.ColumnString(
      'rationale',
      this,
    );
  }

  late final WorkoutPlanItemUpdateTable updateTable;

  late final _is.ColumnInt planId;

  late final _is.ColumnInt exerciseId;

  late final _is.ColumnInt orderIndex;

  late final _is.ColumnInt targetSets;

  late final _is.ColumnString targetRepsText;

  late final _is.ColumnDouble suggestedWeight;

  late final _is.ColumnInt restSeconds;

  late final _is.ColumnString rationale;

  @override
  List<_is.Column> get columns => [
    id,
    planId,
    exerciseId,
    orderIndex,
    targetSets,
    targetRepsText,
    suggestedWeight,
    restSeconds,
    rationale,
  ];
}

class WorkoutPlanItemInclude extends _is.IncludeObject {
  WorkoutPlanItemInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => WorkoutPlanItem.t;
}

class WorkoutPlanItemIncludeList extends _is.IncludeList {
  WorkoutPlanItemIncludeList._({
    _is.WhereExpressionBuilder<WorkoutPlanItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutPlanItem.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => WorkoutPlanItem.t;
}

class WorkoutPlanItemRepository {
  const WorkoutPlanItemRepository._();

  /// Returns a list of [WorkoutPlanItem]s matching the given query parameters.
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
  Future<List<WorkoutPlanItem>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutPlanItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutPlanItemTable>? orderBy,
    _is.OrderByListBuilder<WorkoutPlanItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorkoutPlanItem>(
      where: where?.call(WorkoutPlanItem.t),
      orderBy: orderBy?.call(WorkoutPlanItem.t),
      orderByList: orderByList?.call(WorkoutPlanItem.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorkoutPlanItem] matching the given query parameters.
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
  Future<WorkoutPlanItem?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutPlanItemTable>? where,
    int? offset,
    _is.OrderByBuilder<WorkoutPlanItemTable>? orderBy,
    _is.OrderByListBuilder<WorkoutPlanItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorkoutPlanItem>(
      where: where?.call(WorkoutPlanItem.t),
      orderBy: orderBy?.call(WorkoutPlanItem.t),
      orderByList: orderByList?.call(WorkoutPlanItem.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorkoutPlanItem] by its [id] or null if no such row exists.
  Future<WorkoutPlanItem?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorkoutPlanItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorkoutPlanItem]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutPlanItem]s will have their `id` fields set.
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
  Future<List<WorkoutPlanItem>> insert(
    _is.DatabaseSession session,
    List<WorkoutPlanItem> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<WorkoutPlanItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [WorkoutPlanItem] and returns the inserted row.
  ///
  /// The returned [WorkoutPlanItem] will have its `id` field set.
  Future<WorkoutPlanItem> insertRow(
    _is.DatabaseSession session,
    WorkoutPlanItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutPlanItem>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [WorkoutPlanItem]s in the list and returns the resulting rows.
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
  /// The returned [WorkoutPlanItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutPlanItem>> upsert(
    _is.DatabaseSession session,
    List<WorkoutPlanItem> rows, {
    required _is.ColumnSelections<WorkoutPlanItemTable> conflictColumns,
    _is.ColumnSelections<WorkoutPlanItemTable>? updateColumns,
    _is.WhereExpressionBuilder<WorkoutPlanItemTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<WorkoutPlanItem>(
      rows,
      conflictColumns: conflictColumns(WorkoutPlanItem.t),
      updateColumns: updateColumns?.call(WorkoutPlanItem.t),
      updateWhere: updateWhere?.call(WorkoutPlanItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [WorkoutPlanItem] and returns the resulting row.
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
  /// The returned [WorkoutPlanItem] will have its `id` field set.
  Future<WorkoutPlanItem?> upsertRow(
    _is.DatabaseSession session,
    WorkoutPlanItem row, {
    required _is.ColumnSelections<WorkoutPlanItemTable> conflictColumns,
    _is.ColumnSelections<WorkoutPlanItemTable>? updateColumns,
    _is.WhereExpressionBuilder<WorkoutPlanItemTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<WorkoutPlanItem>(
      row,
      conflictColumns: conflictColumns(WorkoutPlanItem.t),
      updateColumns: updateColumns?.call(WorkoutPlanItem.t),
      updateWhere: updateWhere?.call(WorkoutPlanItem.t),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutPlanItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutPlanItem>> update(
    _is.DatabaseSession session,
    List<WorkoutPlanItem> rows, {
    _is.ColumnSelections<WorkoutPlanItemTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<WorkoutPlanItem>(
      rows,
      columns: columns?.call(WorkoutPlanItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [WorkoutPlanItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutPlanItem> updateRow(
    _is.DatabaseSession session,
    WorkoutPlanItem row, {
    _is.ColumnSelections<WorkoutPlanItemTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutPlanItem>(
      row,
      columns: columns?.call(WorkoutPlanItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutPlanItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutPlanItem?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<WorkoutPlanItemUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutPlanItem>(
      id,
      columnValues: columnValues(WorkoutPlanItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutPlanItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutPlanItem>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<WorkoutPlanItemUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<WorkoutPlanItemTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutPlanItemTable>? orderBy,
    _is.OrderByListBuilder<WorkoutPlanItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<WorkoutPlanItem>(
      columnValues: columnValues(WorkoutPlanItem.t.updateTable),
      where: where(WorkoutPlanItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutPlanItem.t),
      orderByList: orderByList?.call(WorkoutPlanItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [WorkoutPlanItem]s in the list and returns the deleted rows.
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
  Future<List<WorkoutPlanItem>> delete(
    _is.DatabaseSession session,
    List<WorkoutPlanItem> rows, {
    _is.OrderByBuilder<WorkoutPlanItemTable>? orderBy,
    _is.OrderByListBuilder<WorkoutPlanItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<WorkoutPlanItem>(
      rows,
      orderBy: orderBy?.call(WorkoutPlanItem.t),
      orderByList: orderByList?.call(WorkoutPlanItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [WorkoutPlanItem].
  Future<WorkoutPlanItem> deleteRow(
    _is.DatabaseSession session,
    WorkoutPlanItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutPlanItem>(
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
  Future<List<WorkoutPlanItem>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorkoutPlanItemTable> where,
    _is.OrderByBuilder<WorkoutPlanItemTable>? orderBy,
    _is.OrderByListBuilder<WorkoutPlanItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<WorkoutPlanItem>(
      where: where(WorkoutPlanItem.t),
      orderBy: orderBy?.call(WorkoutPlanItem.t),
      orderByList: orderByList?.call(WorkoutPlanItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutPlanItemTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutPlanItem>(
      where: where?.call(WorkoutPlanItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorkoutPlanItem] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorkoutPlanItemTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorkoutPlanItem>(
      where: where(WorkoutPlanItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
