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

abstract class ExerciseMuscle
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ExerciseMuscle._({
    this.id,
    required this.exerciseId,
    required this.muscleGroupId,
    required this.contribution,
  });

  factory ExerciseMuscle({
    int? id,
    required int exerciseId,
    required int muscleGroupId,
    required double contribution,
  }) = _ExerciseMuscleImpl;

  factory ExerciseMuscle.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseMuscle(
      id: jsonSerialization['id'] as int?,
      exerciseId: jsonSerialization['exerciseId'] as int,
      muscleGroupId: jsonSerialization['muscleGroupId'] as int,
      contribution: (jsonSerialization['contribution'] as num).toDouble(),
    );
  }

  static final t = ExerciseMuscleTable();

  static const db = ExerciseMuscleRepository._();

  @override
  int? id;

  int exerciseId;

  int muscleGroupId;

  double contribution;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ExerciseMuscle]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ExerciseMuscle copyWith({
    int? id,
    int? exerciseId,
    int? muscleGroupId,
    double? contribution,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseMuscle',
      if (id != null) 'id': id,
      'exerciseId': exerciseId,
      'muscleGroupId': muscleGroupId,
      'contribution': contribution,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExerciseMuscle',
      if (id != null) 'id': id,
      'exerciseId': exerciseId,
      'muscleGroupId': muscleGroupId,
      'contribution': contribution,
    };
  }

  static ExerciseMuscleInclude include() {
    return ExerciseMuscleInclude._();
  }

  static ExerciseMuscleIncludeList includeList({
    _is.WhereExpressionBuilder<ExerciseMuscleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExerciseMuscleTable>? orderBy,
    _is.OrderByListBuilder<ExerciseMuscleTable>? orderByList,
    ExerciseMuscleInclude? include,
  }) {
    return ExerciseMuscleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseMuscle.t),
      orderByList: orderByList?.call(ExerciseMuscle.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseMuscleImpl extends ExerciseMuscle {
  _ExerciseMuscleImpl({
    int? id,
    required int exerciseId,
    required int muscleGroupId,
    required double contribution,
  }) : super._(
         id: id,
         exerciseId: exerciseId,
         muscleGroupId: muscleGroupId,
         contribution: contribution,
       );

  /// Returns a shallow copy of this [ExerciseMuscle]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ExerciseMuscle copyWith({
    Object? id = _Undefined,
    int? exerciseId,
    int? muscleGroupId,
    double? contribution,
  }) {
    return ExerciseMuscle(
      id: id is int? ? id : this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      muscleGroupId: muscleGroupId ?? this.muscleGroupId,
      contribution: contribution ?? this.contribution,
    );
  }
}

class ExerciseMuscleUpdateTable extends _is.UpdateTable<ExerciseMuscleTable> {
  ExerciseMuscleUpdateTable(super.table);

  _is.ColumnValue<int, int> exerciseId(int value) => _is.ColumnValue(
    table.exerciseId,
    value,
  );

  _is.ColumnValue<int, int> muscleGroupId(int value) => _is.ColumnValue(
    table.muscleGroupId,
    value,
  );

  _is.ColumnValue<double, double> contribution(double value) => _is.ColumnValue(
    table.contribution,
    value,
  );
}

class ExerciseMuscleTable extends _is.Table<int?> {
  ExerciseMuscleTable({super.tableRelation})
    : super(tableName: 'exercise_muscle') {
    updateTable = ExerciseMuscleUpdateTable(this);
    exerciseId = _is.ColumnInt(
      'exerciseId',
      this,
    );
    muscleGroupId = _is.ColumnInt(
      'muscleGroupId',
      this,
    );
    contribution = _is.ColumnDouble(
      'contribution',
      this,
    );
  }

  late final ExerciseMuscleUpdateTable updateTable;

  late final _is.ColumnInt exerciseId;

  late final _is.ColumnInt muscleGroupId;

  late final _is.ColumnDouble contribution;

  @override
  List<_is.Column> get columns => [
    id,
    exerciseId,
    muscleGroupId,
    contribution,
  ];
}

class ExerciseMuscleInclude extends _is.IncludeObject {
  ExerciseMuscleInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ExerciseMuscle.t;
}

class ExerciseMuscleIncludeList extends _is.IncludeList {
  ExerciseMuscleIncludeList._({
    _is.WhereExpressionBuilder<ExerciseMuscleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ExerciseMuscle.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ExerciseMuscle.t;
}

class ExerciseMuscleRepository {
  const ExerciseMuscleRepository._();

  /// Returns a list of [ExerciseMuscle]s matching the given query parameters.
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
  Future<List<ExerciseMuscle>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExerciseMuscleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExerciseMuscleTable>? orderBy,
    _is.OrderByListBuilder<ExerciseMuscleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ExerciseMuscle>(
      where: where?.call(ExerciseMuscle.t),
      orderBy: orderBy?.call(ExerciseMuscle.t),
      orderByList: orderByList?.call(ExerciseMuscle.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ExerciseMuscle] matching the given query parameters.
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
  Future<ExerciseMuscle?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExerciseMuscleTable>? where,
    int? offset,
    _is.OrderByBuilder<ExerciseMuscleTable>? orderBy,
    _is.OrderByListBuilder<ExerciseMuscleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ExerciseMuscle>(
      where: where?.call(ExerciseMuscle.t),
      orderBy: orderBy?.call(ExerciseMuscle.t),
      orderByList: orderByList?.call(ExerciseMuscle.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ExerciseMuscle] by its [id] or null if no such row exists.
  Future<ExerciseMuscle?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ExerciseMuscle>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ExerciseMuscle]s in the list and returns the inserted rows.
  ///
  /// The returned [ExerciseMuscle]s will have their `id` fields set.
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
  Future<List<ExerciseMuscle>> insert(
    _is.DatabaseSession session,
    List<ExerciseMuscle> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ExerciseMuscle>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ExerciseMuscle] and returns the inserted row.
  ///
  /// The returned [ExerciseMuscle] will have its `id` field set.
  Future<ExerciseMuscle> insertRow(
    _is.DatabaseSession session,
    ExerciseMuscle row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ExerciseMuscle>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ExerciseMuscle]s in the list and returns the resulting rows.
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
  /// The returned [ExerciseMuscle]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ExerciseMuscle>> upsert(
    _is.DatabaseSession session,
    List<ExerciseMuscle> rows, {
    required _is.ColumnSelections<ExerciseMuscleTable> conflictColumns,
    _is.ColumnSelections<ExerciseMuscleTable>? updateColumns,
    _is.WhereExpressionBuilder<ExerciseMuscleTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ExerciseMuscle>(
      rows,
      conflictColumns: conflictColumns(ExerciseMuscle.t),
      updateColumns: updateColumns?.call(ExerciseMuscle.t),
      updateWhere: updateWhere?.call(ExerciseMuscle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ExerciseMuscle] and returns the resulting row.
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
  /// The returned [ExerciseMuscle] will have its `id` field set.
  Future<ExerciseMuscle?> upsertRow(
    _is.DatabaseSession session,
    ExerciseMuscle row, {
    required _is.ColumnSelections<ExerciseMuscleTable> conflictColumns,
    _is.ColumnSelections<ExerciseMuscleTable>? updateColumns,
    _is.WhereExpressionBuilder<ExerciseMuscleTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ExerciseMuscle>(
      row,
      conflictColumns: conflictColumns(ExerciseMuscle.t),
      updateColumns: updateColumns?.call(ExerciseMuscle.t),
      updateWhere: updateWhere?.call(ExerciseMuscle.t),
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseMuscle]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ExerciseMuscle>> update(
    _is.DatabaseSession session,
    List<ExerciseMuscle> rows, {
    _is.ColumnSelections<ExerciseMuscleTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ExerciseMuscle>(
      rows,
      columns: columns?.call(ExerciseMuscle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ExerciseMuscle]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ExerciseMuscle> updateRow(
    _is.DatabaseSession session,
    ExerciseMuscle row, {
    _is.ColumnSelections<ExerciseMuscleTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ExerciseMuscle>(
      row,
      columns: columns?.call(ExerciseMuscle.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExerciseMuscle] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ExerciseMuscle?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ExerciseMuscleUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ExerciseMuscle>(
      id,
      columnValues: columnValues(ExerciseMuscle.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseMuscle]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ExerciseMuscle>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ExerciseMuscleUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ExerciseMuscleTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExerciseMuscleTable>? orderBy,
    _is.OrderByListBuilder<ExerciseMuscleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ExerciseMuscle>(
      columnValues: columnValues(ExerciseMuscle.t.updateTable),
      where: where(ExerciseMuscle.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseMuscle.t),
      orderByList: orderByList?.call(ExerciseMuscle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ExerciseMuscle]s in the list and returns the deleted rows.
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
  Future<List<ExerciseMuscle>> delete(
    _is.DatabaseSession session,
    List<ExerciseMuscle> rows, {
    _is.OrderByBuilder<ExerciseMuscleTable>? orderBy,
    _is.OrderByListBuilder<ExerciseMuscleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ExerciseMuscle>(
      rows,
      orderBy: orderBy?.call(ExerciseMuscle.t),
      orderByList: orderByList?.call(ExerciseMuscle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ExerciseMuscle].
  Future<ExerciseMuscle> deleteRow(
    _is.DatabaseSession session,
    ExerciseMuscle row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ExerciseMuscle>(
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
  Future<List<ExerciseMuscle>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ExerciseMuscleTable> where,
    _is.OrderByBuilder<ExerciseMuscleTable>? orderBy,
    _is.OrderByListBuilder<ExerciseMuscleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ExerciseMuscle>(
      where: where(ExerciseMuscle.t),
      orderBy: orderBy?.call(ExerciseMuscle.t),
      orderByList: orderByList?.call(ExerciseMuscle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExerciseMuscleTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ExerciseMuscle>(
      where: where?.call(ExerciseMuscle.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ExerciseMuscle] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ExerciseMuscleTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ExerciseMuscle>(
      where: where(ExerciseMuscle.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
