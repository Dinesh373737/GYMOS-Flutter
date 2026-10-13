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

abstract class EquipmentCatalog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  EquipmentCatalog._({
    this.id,
    required this.name,
    required this.category,
    required this.description,
  });

  factory EquipmentCatalog({
    int? id,
    required String name,
    required String category,
    required String description,
  }) = _EquipmentCatalogImpl;

  factory EquipmentCatalog.fromJson(Map<String, dynamic> jsonSerialization) {
    return EquipmentCatalog(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      category: jsonSerialization['category'] as String,
      description: jsonSerialization['description'] as String,
    );
  }

  static final t = EquipmentCatalogTable();

  static const db = EquipmentCatalogRepository._();

  @override
  int? id;

  String name;

  String category;

  String description;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EquipmentCatalog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EquipmentCatalog copyWith({
    int? id,
    String? name,
    String? category,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EquipmentCatalog',
      if (id != null) 'id': id,
      'name': name,
      'category': category,
      'description': description,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EquipmentCatalog',
      if (id != null) 'id': id,
      'name': name,
      'category': category,
      'description': description,
    };
  }

  static EquipmentCatalogInclude include() {
    return EquipmentCatalogInclude._();
  }

  static EquipmentCatalogIncludeList includeList({
    _is.WhereExpressionBuilder<EquipmentCatalogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EquipmentCatalogTable>? orderBy,
    _is.OrderByListBuilder<EquipmentCatalogTable>? orderByList,
    EquipmentCatalogInclude? include,
  }) {
    return EquipmentCatalogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EquipmentCatalog.t),
      orderByList: orderByList?.call(EquipmentCatalog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EquipmentCatalogImpl extends EquipmentCatalog {
  _EquipmentCatalogImpl({
    int? id,
    required String name,
    required String category,
    required String description,
  }) : super._(
         id: id,
         name: name,
         category: category,
         description: description,
       );

  /// Returns a shallow copy of this [EquipmentCatalog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EquipmentCatalog copyWith({
    Object? id = _Undefined,
    String? name,
    String? category,
    String? description,
  }) {
    return EquipmentCatalog(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }
}

class EquipmentCatalogUpdateTable
    extends _is.UpdateTable<EquipmentCatalogTable> {
  EquipmentCatalogUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> category(String value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );
}

class EquipmentCatalogTable extends _is.Table<int?> {
  EquipmentCatalogTable({super.tableRelation})
    : super(tableName: 'equipment_catalog') {
    updateTable = EquipmentCatalogUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
  }

  late final EquipmentCatalogUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString category;

  late final _is.ColumnString description;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    category,
    description,
  ];
}

class EquipmentCatalogInclude extends _is.IncludeObject {
  EquipmentCatalogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EquipmentCatalog.t;
}

class EquipmentCatalogIncludeList extends _is.IncludeList {
  EquipmentCatalogIncludeList._({
    _is.WhereExpressionBuilder<EquipmentCatalogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EquipmentCatalog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EquipmentCatalog.t;
}

class EquipmentCatalogRepository {
  const EquipmentCatalogRepository._();

  /// Returns a list of [EquipmentCatalog]s matching the given query parameters.
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
  Future<List<EquipmentCatalog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EquipmentCatalogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EquipmentCatalogTable>? orderBy,
    _is.OrderByListBuilder<EquipmentCatalogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EquipmentCatalog>(
      where: where?.call(EquipmentCatalog.t),
      orderBy: orderBy?.call(EquipmentCatalog.t),
      orderByList: orderByList?.call(EquipmentCatalog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EquipmentCatalog] matching the given query parameters.
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
  Future<EquipmentCatalog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EquipmentCatalogTable>? where,
    int? offset,
    _is.OrderByBuilder<EquipmentCatalogTable>? orderBy,
    _is.OrderByListBuilder<EquipmentCatalogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EquipmentCatalog>(
      where: where?.call(EquipmentCatalog.t),
      orderBy: orderBy?.call(EquipmentCatalog.t),
      orderByList: orderByList?.call(EquipmentCatalog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EquipmentCatalog] by its [id] or null if no such row exists.
  Future<EquipmentCatalog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EquipmentCatalog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EquipmentCatalog]s in the list and returns the inserted rows.
  ///
  /// The returned [EquipmentCatalog]s will have their `id` fields set.
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
  Future<List<EquipmentCatalog>> insert(
    _is.DatabaseSession session,
    List<EquipmentCatalog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EquipmentCatalog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EquipmentCatalog] and returns the inserted row.
  ///
  /// The returned [EquipmentCatalog] will have its `id` field set.
  Future<EquipmentCatalog> insertRow(
    _is.DatabaseSession session,
    EquipmentCatalog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EquipmentCatalog>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EquipmentCatalog]s in the list and returns the resulting rows.
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
  /// The returned [EquipmentCatalog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EquipmentCatalog>> upsert(
    _is.DatabaseSession session,
    List<EquipmentCatalog> rows, {
    required _is.ColumnSelections<EquipmentCatalogTable> conflictColumns,
    _is.ColumnSelections<EquipmentCatalogTable>? updateColumns,
    _is.WhereExpressionBuilder<EquipmentCatalogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EquipmentCatalog>(
      rows,
      conflictColumns: conflictColumns(EquipmentCatalog.t),
      updateColumns: updateColumns?.call(EquipmentCatalog.t),
      updateWhere: updateWhere?.call(EquipmentCatalog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EquipmentCatalog] and returns the resulting row.
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
  /// The returned [EquipmentCatalog] will have its `id` field set.
  Future<EquipmentCatalog?> upsertRow(
    _is.DatabaseSession session,
    EquipmentCatalog row, {
    required _is.ColumnSelections<EquipmentCatalogTable> conflictColumns,
    _is.ColumnSelections<EquipmentCatalogTable>? updateColumns,
    _is.WhereExpressionBuilder<EquipmentCatalogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EquipmentCatalog>(
      row,
      conflictColumns: conflictColumns(EquipmentCatalog.t),
      updateColumns: updateColumns?.call(EquipmentCatalog.t),
      updateWhere: updateWhere?.call(EquipmentCatalog.t),
      transaction: transaction,
    );
  }

  /// Updates all [EquipmentCatalog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EquipmentCatalog>> update(
    _is.DatabaseSession session,
    List<EquipmentCatalog> rows, {
    _is.ColumnSelections<EquipmentCatalogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EquipmentCatalog>(
      rows,
      columns: columns?.call(EquipmentCatalog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EquipmentCatalog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EquipmentCatalog> updateRow(
    _is.DatabaseSession session,
    EquipmentCatalog row, {
    _is.ColumnSelections<EquipmentCatalogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EquipmentCatalog>(
      row,
      columns: columns?.call(EquipmentCatalog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EquipmentCatalog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EquipmentCatalog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EquipmentCatalogUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EquipmentCatalog>(
      id,
      columnValues: columnValues(EquipmentCatalog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EquipmentCatalog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EquipmentCatalog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EquipmentCatalogUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<EquipmentCatalogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EquipmentCatalogTable>? orderBy,
    _is.OrderByListBuilder<EquipmentCatalogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EquipmentCatalog>(
      columnValues: columnValues(EquipmentCatalog.t.updateTable),
      where: where(EquipmentCatalog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EquipmentCatalog.t),
      orderByList: orderByList?.call(EquipmentCatalog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EquipmentCatalog]s in the list and returns the deleted rows.
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
  Future<List<EquipmentCatalog>> delete(
    _is.DatabaseSession session,
    List<EquipmentCatalog> rows, {
    _is.OrderByBuilder<EquipmentCatalogTable>? orderBy,
    _is.OrderByListBuilder<EquipmentCatalogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EquipmentCatalog>(
      rows,
      orderBy: orderBy?.call(EquipmentCatalog.t),
      orderByList: orderByList?.call(EquipmentCatalog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EquipmentCatalog].
  Future<EquipmentCatalog> deleteRow(
    _is.DatabaseSession session,
    EquipmentCatalog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EquipmentCatalog>(
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
  Future<List<EquipmentCatalog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EquipmentCatalogTable> where,
    _is.OrderByBuilder<EquipmentCatalogTable>? orderBy,
    _is.OrderByListBuilder<EquipmentCatalogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EquipmentCatalog>(
      where: where(EquipmentCatalog.t),
      orderBy: orderBy?.call(EquipmentCatalog.t),
      orderByList: orderByList?.call(EquipmentCatalog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EquipmentCatalogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EquipmentCatalog>(
      where: where?.call(EquipmentCatalog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EquipmentCatalog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EquipmentCatalogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EquipmentCatalog>(
      where: where(EquipmentCatalog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
