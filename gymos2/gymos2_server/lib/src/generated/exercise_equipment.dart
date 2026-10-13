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

abstract class ExerciseEquipment
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ExerciseEquipment._({
    this.id,
    required this.exerciseId,
    required this.equipmentId,
    required this.required,
  });

  factory ExerciseEquipment({
    int? id,
    required int exerciseId,
    required int equipmentId,
    required bool required,
  }) = _ExerciseEquipmentImpl;

  factory ExerciseEquipment.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseEquipment(
      id: jsonSerialization['id'] as int?,
      exerciseId: jsonSerialization['exerciseId'] as int,
      equipmentId: jsonSerialization['equipmentId'] as int,
      required: _is.BoolJsonExtension.fromJson(jsonSerialization['required']),
    );
  }

  static final t = ExerciseEquipmentTable();

  static const db = ExerciseEquipmentRepository._();

  @override
  int? id;

  int exerciseId;

  int equipmentId;

  bool required;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ExerciseEquipment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ExerciseEquipment copyWith({
    int? id,
    int? exerciseId,
    int? equipmentId,
    bool? required,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseEquipment',
      if (id != null) 'id': id,
      'exerciseId': exerciseId,
      'equipmentId': equipmentId,
      'required': required,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExerciseEquipment',
      if (id != null) 'id': id,
      'exerciseId': exerciseId,
      'equipmentId': equipmentId,
      'required': required,
    };
  }

  static ExerciseEquipmentInclude include() {
    return ExerciseEquipmentInclude._();
  }

  static ExerciseEquipmentIncludeList includeList({
    _is.WhereExpressionBuilder<ExerciseEquipmentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExerciseEquipmentTable>? orderBy,
    _is.OrderByListBuilder<ExerciseEquipmentTable>? orderByList,
    ExerciseEquipmentInclude? include,
  }) {
    return ExerciseEquipmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseEquipment.t),
      orderByList: orderByList?.call(ExerciseEquipment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseEquipmentImpl extends ExerciseEquipment {
  _ExerciseEquipmentImpl({
    int? id,
    required int exerciseId,
    required int equipmentId,
    required bool required,
  }) : super._(
         id: id,
         exerciseId: exerciseId,
         equipmentId: equipmentId,
         required: required,
       );

  /// Returns a shallow copy of this [ExerciseEquipment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ExerciseEquipment copyWith({
    Object? id = _Undefined,
    int? exerciseId,
    int? equipmentId,
    bool? required,
  }) {
    return ExerciseEquipment(
      id: id is int? ? id : this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      equipmentId: equipmentId ?? this.equipmentId,
      required: required ?? this.required,
    );
  }
}

class ExerciseEquipmentUpdateTable
    extends _is.UpdateTable<ExerciseEquipmentTable> {
  ExerciseEquipmentUpdateTable(super.table);

  _is.ColumnValue<int, int> exerciseId(int value) => _is.ColumnValue(
    table.exerciseId,
    value,
  );

  _is.ColumnValue<int, int> equipmentId(int value) => _is.ColumnValue(
    table.equipmentId,
    value,
  );

  _is.ColumnValue<bool, bool> required(bool value) => _is.ColumnValue(
    table.required,
    value,
  );
}

class ExerciseEquipmentTable extends _is.Table<int?> {
  ExerciseEquipmentTable({super.tableRelation})
    : super(tableName: 'exercise_equipment') {
    updateTable = ExerciseEquipmentUpdateTable(this);
    exerciseId = _is.ColumnInt(
      'exerciseId',
      this,
    );
    equipmentId = _is.ColumnInt(
      'equipmentId',
      this,
    );
    required = _is.ColumnBool(
      'required',
      this,
    );
  }

  late final ExerciseEquipmentUpdateTable updateTable;

  late final _is.ColumnInt exerciseId;

  late final _is.ColumnInt equipmentId;

  late final _is.ColumnBool required;

  @override
  List<_is.Column> get columns => [
    id,
    exerciseId,
    equipmentId,
    required,
  ];
}

class ExerciseEquipmentInclude extends _is.IncludeObject {
  ExerciseEquipmentInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ExerciseEquipment.t;
}

class ExerciseEquipmentIncludeList extends _is.IncludeList {
  ExerciseEquipmentIncludeList._({
    _is.WhereExpressionBuilder<ExerciseEquipmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ExerciseEquipment.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ExerciseEquipment.t;
}

class ExerciseEquipmentRepository {
  const ExerciseEquipmentRepository._();

  /// Returns a list of [ExerciseEquipment]s matching the given query parameters.
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
  Future<List<ExerciseEquipment>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExerciseEquipmentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExerciseEquipmentTable>? orderBy,
    _is.OrderByListBuilder<ExerciseEquipmentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ExerciseEquipment>(
      where: where?.call(ExerciseEquipment.t),
      orderBy: orderBy?.call(ExerciseEquipment.t),
      orderByList: orderByList?.call(ExerciseEquipment.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ExerciseEquipment] matching the given query parameters.
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
  Future<ExerciseEquipment?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExerciseEquipmentTable>? where,
    int? offset,
    _is.OrderByBuilder<ExerciseEquipmentTable>? orderBy,
    _is.OrderByListBuilder<ExerciseEquipmentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ExerciseEquipment>(
      where: where?.call(ExerciseEquipment.t),
      orderBy: orderBy?.call(ExerciseEquipment.t),
      orderByList: orderByList?.call(ExerciseEquipment.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ExerciseEquipment] by its [id] or null if no such row exists.
  Future<ExerciseEquipment?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ExerciseEquipment>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ExerciseEquipment]s in the list and returns the inserted rows.
  ///
  /// The returned [ExerciseEquipment]s will have their `id` fields set.
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
  Future<List<ExerciseEquipment>> insert(
    _is.DatabaseSession session,
    List<ExerciseEquipment> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ExerciseEquipment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ExerciseEquipment] and returns the inserted row.
  ///
  /// The returned [ExerciseEquipment] will have its `id` field set.
  Future<ExerciseEquipment> insertRow(
    _is.DatabaseSession session,
    ExerciseEquipment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ExerciseEquipment>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ExerciseEquipment]s in the list and returns the resulting rows.
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
  /// The returned [ExerciseEquipment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ExerciseEquipment>> upsert(
    _is.DatabaseSession session,
    List<ExerciseEquipment> rows, {
    required _is.ColumnSelections<ExerciseEquipmentTable> conflictColumns,
    _is.ColumnSelections<ExerciseEquipmentTable>? updateColumns,
    _is.WhereExpressionBuilder<ExerciseEquipmentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ExerciseEquipment>(
      rows,
      conflictColumns: conflictColumns(ExerciseEquipment.t),
      updateColumns: updateColumns?.call(ExerciseEquipment.t),
      updateWhere: updateWhere?.call(ExerciseEquipment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ExerciseEquipment] and returns the resulting row.
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
  /// The returned [ExerciseEquipment] will have its `id` field set.
  Future<ExerciseEquipment?> upsertRow(
    _is.DatabaseSession session,
    ExerciseEquipment row, {
    required _is.ColumnSelections<ExerciseEquipmentTable> conflictColumns,
    _is.ColumnSelections<ExerciseEquipmentTable>? updateColumns,
    _is.WhereExpressionBuilder<ExerciseEquipmentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ExerciseEquipment>(
      row,
      conflictColumns: conflictColumns(ExerciseEquipment.t),
      updateColumns: updateColumns?.call(ExerciseEquipment.t),
      updateWhere: updateWhere?.call(ExerciseEquipment.t),
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseEquipment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ExerciseEquipment>> update(
    _is.DatabaseSession session,
    List<ExerciseEquipment> rows, {
    _is.ColumnSelections<ExerciseEquipmentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ExerciseEquipment>(
      rows,
      columns: columns?.call(ExerciseEquipment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ExerciseEquipment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ExerciseEquipment> updateRow(
    _is.DatabaseSession session,
    ExerciseEquipment row, {
    _is.ColumnSelections<ExerciseEquipmentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ExerciseEquipment>(
      row,
      columns: columns?.call(ExerciseEquipment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExerciseEquipment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ExerciseEquipment?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ExerciseEquipmentUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ExerciseEquipment>(
      id,
      columnValues: columnValues(ExerciseEquipment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseEquipment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ExerciseEquipment>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ExerciseEquipmentUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ExerciseEquipmentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExerciseEquipmentTable>? orderBy,
    _is.OrderByListBuilder<ExerciseEquipmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ExerciseEquipment>(
      columnValues: columnValues(ExerciseEquipment.t.updateTable),
      where: where(ExerciseEquipment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseEquipment.t),
      orderByList: orderByList?.call(ExerciseEquipment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ExerciseEquipment]s in the list and returns the deleted rows.
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
  Future<List<ExerciseEquipment>> delete(
    _is.DatabaseSession session,
    List<ExerciseEquipment> rows, {
    _is.OrderByBuilder<ExerciseEquipmentTable>? orderBy,
    _is.OrderByListBuilder<ExerciseEquipmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ExerciseEquipment>(
      rows,
      orderBy: orderBy?.call(ExerciseEquipment.t),
      orderByList: orderByList?.call(ExerciseEquipment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ExerciseEquipment].
  Future<ExerciseEquipment> deleteRow(
    _is.DatabaseSession session,
    ExerciseEquipment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ExerciseEquipment>(
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
  Future<List<ExerciseEquipment>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ExerciseEquipmentTable> where,
    _is.OrderByBuilder<ExerciseEquipmentTable>? orderBy,
    _is.OrderByListBuilder<ExerciseEquipmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ExerciseEquipment>(
      where: where(ExerciseEquipment.t),
      orderBy: orderBy?.call(ExerciseEquipment.t),
      orderByList: orderByList?.call(ExerciseEquipment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExerciseEquipmentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ExerciseEquipment>(
      where: where?.call(ExerciseEquipment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ExerciseEquipment] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ExerciseEquipmentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ExerciseEquipment>(
      where: where(ExerciseEquipment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
