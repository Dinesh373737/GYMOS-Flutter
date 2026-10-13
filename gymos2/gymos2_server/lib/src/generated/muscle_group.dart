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

abstract class MuscleGroup
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  MuscleGroup._({
    this.id,
    required this.name,
    required this.bodyArea,
  });

  factory MuscleGroup({
    int? id,
    required String name,
    required String bodyArea,
  }) = _MuscleGroupImpl;

  factory MuscleGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return MuscleGroup(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      bodyArea: jsonSerialization['bodyArea'] as String,
    );
  }

  static final t = MuscleGroupTable();

  static const db = MuscleGroupRepository._();

  @override
  int? id;

  String name;

  String bodyArea;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [MuscleGroup]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MuscleGroup copyWith({
    int? id,
    String? name,
    String? bodyArea,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MuscleGroup',
      if (id != null) 'id': id,
      'name': name,
      'bodyArea': bodyArea,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MuscleGroup',
      if (id != null) 'id': id,
      'name': name,
      'bodyArea': bodyArea,
    };
  }

  static MuscleGroupInclude include() {
    return MuscleGroupInclude._();
  }

  static MuscleGroupIncludeList includeList({
    _is.WhereExpressionBuilder<MuscleGroupTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MuscleGroupTable>? orderBy,
    _is.OrderByListBuilder<MuscleGroupTable>? orderByList,
    MuscleGroupInclude? include,
  }) {
    return MuscleGroupIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MuscleGroup.t),
      orderByList: orderByList?.call(MuscleGroup.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MuscleGroupImpl extends MuscleGroup {
  _MuscleGroupImpl({
    int? id,
    required String name,
    required String bodyArea,
  }) : super._(
         id: id,
         name: name,
         bodyArea: bodyArea,
       );

  /// Returns a shallow copy of this [MuscleGroup]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MuscleGroup copyWith({
    Object? id = _Undefined,
    String? name,
    String? bodyArea,
  }) {
    return MuscleGroup(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      bodyArea: bodyArea ?? this.bodyArea,
    );
  }
}

class MuscleGroupUpdateTable extends _is.UpdateTable<MuscleGroupTable> {
  MuscleGroupUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> bodyArea(String value) => _is.ColumnValue(
    table.bodyArea,
    value,
  );
}

class MuscleGroupTable extends _is.Table<int?> {
  MuscleGroupTable({super.tableRelation}) : super(tableName: 'muscle_group') {
    updateTable = MuscleGroupUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    bodyArea = _is.ColumnString(
      'bodyArea',
      this,
    );
  }

  late final MuscleGroupUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString bodyArea;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    bodyArea,
  ];
}

class MuscleGroupInclude extends _is.IncludeObject {
  MuscleGroupInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => MuscleGroup.t;
}

class MuscleGroupIncludeList extends _is.IncludeList {
  MuscleGroupIncludeList._({
    _is.WhereExpressionBuilder<MuscleGroupTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MuscleGroup.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => MuscleGroup.t;
}

class MuscleGroupRepository {
  const MuscleGroupRepository._();

  /// Returns a list of [MuscleGroup]s matching the given query parameters.
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
  Future<List<MuscleGroup>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MuscleGroupTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MuscleGroupTable>? orderBy,
    _is.OrderByListBuilder<MuscleGroupTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MuscleGroup>(
      where: where?.call(MuscleGroup.t),
      orderBy: orderBy?.call(MuscleGroup.t),
      orderByList: orderByList?.call(MuscleGroup.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MuscleGroup] matching the given query parameters.
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
  Future<MuscleGroup?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MuscleGroupTable>? where,
    int? offset,
    _is.OrderByBuilder<MuscleGroupTable>? orderBy,
    _is.OrderByListBuilder<MuscleGroupTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MuscleGroup>(
      where: where?.call(MuscleGroup.t),
      orderBy: orderBy?.call(MuscleGroup.t),
      orderByList: orderByList?.call(MuscleGroup.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MuscleGroup] by its [id] or null if no such row exists.
  Future<MuscleGroup?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MuscleGroup>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MuscleGroup]s in the list and returns the inserted rows.
  ///
  /// The returned [MuscleGroup]s will have their `id` fields set.
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
  Future<List<MuscleGroup>> insert(
    _is.DatabaseSession session,
    List<MuscleGroup> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MuscleGroup>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MuscleGroup] and returns the inserted row.
  ///
  /// The returned [MuscleGroup] will have its `id` field set.
  Future<MuscleGroup> insertRow(
    _is.DatabaseSession session,
    MuscleGroup row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MuscleGroup>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [MuscleGroup]s in the list and returns the resulting rows.
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
  /// The returned [MuscleGroup]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MuscleGroup>> upsert(
    _is.DatabaseSession session,
    List<MuscleGroup> rows, {
    required _is.ColumnSelections<MuscleGroupTable> conflictColumns,
    _is.ColumnSelections<MuscleGroupTable>? updateColumns,
    _is.WhereExpressionBuilder<MuscleGroupTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MuscleGroup>(
      rows,
      conflictColumns: conflictColumns(MuscleGroup.t),
      updateColumns: updateColumns?.call(MuscleGroup.t),
      updateWhere: updateWhere?.call(MuscleGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MuscleGroup] and returns the resulting row.
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
  /// The returned [MuscleGroup] will have its `id` field set.
  Future<MuscleGroup?> upsertRow(
    _is.DatabaseSession session,
    MuscleGroup row, {
    required _is.ColumnSelections<MuscleGroupTable> conflictColumns,
    _is.ColumnSelections<MuscleGroupTable>? updateColumns,
    _is.WhereExpressionBuilder<MuscleGroupTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MuscleGroup>(
      row,
      conflictColumns: conflictColumns(MuscleGroup.t),
      updateColumns: updateColumns?.call(MuscleGroup.t),
      updateWhere: updateWhere?.call(MuscleGroup.t),
      transaction: transaction,
    );
  }

  /// Updates all [MuscleGroup]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MuscleGroup>> update(
    _is.DatabaseSession session,
    List<MuscleGroup> rows, {
    _is.ColumnSelections<MuscleGroupTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MuscleGroup>(
      rows,
      columns: columns?.call(MuscleGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MuscleGroup]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MuscleGroup> updateRow(
    _is.DatabaseSession session,
    MuscleGroup row, {
    _is.ColumnSelections<MuscleGroupTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MuscleGroup>(
      row,
      columns: columns?.call(MuscleGroup.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MuscleGroup] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MuscleGroup?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MuscleGroupUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MuscleGroup>(
      id,
      columnValues: columnValues(MuscleGroup.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MuscleGroup]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MuscleGroup>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MuscleGroupUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MuscleGroupTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MuscleGroupTable>? orderBy,
    _is.OrderByListBuilder<MuscleGroupTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MuscleGroup>(
      columnValues: columnValues(MuscleGroup.t.updateTable),
      where: where(MuscleGroup.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MuscleGroup.t),
      orderByList: orderByList?.call(MuscleGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MuscleGroup]s in the list and returns the deleted rows.
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
  Future<List<MuscleGroup>> delete(
    _is.DatabaseSession session,
    List<MuscleGroup> rows, {
    _is.OrderByBuilder<MuscleGroupTable>? orderBy,
    _is.OrderByListBuilder<MuscleGroupTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MuscleGroup>(
      rows,
      orderBy: orderBy?.call(MuscleGroup.t),
      orderByList: orderByList?.call(MuscleGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MuscleGroup].
  Future<MuscleGroup> deleteRow(
    _is.DatabaseSession session,
    MuscleGroup row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MuscleGroup>(
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
  Future<List<MuscleGroup>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MuscleGroupTable> where,
    _is.OrderByBuilder<MuscleGroupTable>? orderBy,
    _is.OrderByListBuilder<MuscleGroupTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MuscleGroup>(
      where: where(MuscleGroup.t),
      orderBy: orderBy?.call(MuscleGroup.t),
      orderByList: orderByList?.call(MuscleGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MuscleGroupTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MuscleGroup>(
      where: where?.call(MuscleGroup.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MuscleGroup] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MuscleGroupTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MuscleGroup>(
      where: where(MuscleGroup.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
