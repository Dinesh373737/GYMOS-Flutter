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

abstract class Society
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Society._({
    this.id,
    required this.name,
    required this.addressLabel,
    required this.inviteCode,
    required this.createdBy,
    required this.createdAt,
    required this.isActive,
  });

  factory Society({
    int? id,
    required String name,
    required String addressLabel,
    required String inviteCode,
    required String createdBy,
    required DateTime createdAt,
    required bool isActive,
  }) = _SocietyImpl;

  factory Society.fromJson(Map<String, dynamic> jsonSerialization) {
    return Society(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      addressLabel: jsonSerialization['addressLabel'] as String,
      inviteCode: jsonSerialization['inviteCode'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      isActive: _is.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
    );
  }

  static final t = SocietyTable();

  static const db = SocietyRepository._();

  @override
  int? id;

  String name;

  String addressLabel;

  String inviteCode;

  String createdBy;

  DateTime createdAt;

  bool isActive;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Society]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Society copyWith({
    int? id,
    String? name,
    String? addressLabel,
    String? inviteCode,
    String? createdBy,
    DateTime? createdAt,
    bool? isActive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Society',
      if (id != null) 'id': id,
      'name': name,
      'addressLabel': addressLabel,
      'inviteCode': inviteCode,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'isActive': isActive,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Society',
      if (id != null) 'id': id,
      'name': name,
      'addressLabel': addressLabel,
      'inviteCode': inviteCode,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'isActive': isActive,
    };
  }

  static SocietyInclude include() {
    return SocietyInclude._();
  }

  static SocietyIncludeList includeList({
    _is.WhereExpressionBuilder<SocietyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SocietyTable>? orderBy,
    _is.OrderByListBuilder<SocietyTable>? orderByList,
    SocietyInclude? include,
  }) {
    return SocietyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Society.t),
      orderByList: orderByList?.call(Society.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SocietyImpl extends Society {
  _SocietyImpl({
    int? id,
    required String name,
    required String addressLabel,
    required String inviteCode,
    required String createdBy,
    required DateTime createdAt,
    required bool isActive,
  }) : super._(
         id: id,
         name: name,
         addressLabel: addressLabel,
         inviteCode: inviteCode,
         createdBy: createdBy,
         createdAt: createdAt,
         isActive: isActive,
       );

  /// Returns a shallow copy of this [Society]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Society copyWith({
    Object? id = _Undefined,
    String? name,
    String? addressLabel,
    String? inviteCode,
    String? createdBy,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return Society(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      addressLabel: addressLabel ?? this.addressLabel,
      inviteCode: inviteCode ?? this.inviteCode,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }
}

class SocietyUpdateTable extends _is.UpdateTable<SocietyTable> {
  SocietyUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> addressLabel(String value) => _is.ColumnValue(
    table.addressLabel,
    value,
  );

  _is.ColumnValue<String, String> inviteCode(String value) => _is.ColumnValue(
    table.inviteCode,
    value,
  );

  _is.ColumnValue<String, String> createdBy(String value) => _is.ColumnValue(
    table.createdBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<bool, bool> isActive(bool value) => _is.ColumnValue(
    table.isActive,
    value,
  );
}

class SocietyTable extends _is.Table<int?> {
  SocietyTable({super.tableRelation}) : super(tableName: 'society') {
    updateTable = SocietyUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    addressLabel = _is.ColumnString(
      'addressLabel',
      this,
    );
    inviteCode = _is.ColumnString(
      'inviteCode',
      this,
    );
    createdBy = _is.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    isActive = _is.ColumnBool(
      'isActive',
      this,
    );
  }

  late final SocietyUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString addressLabel;

  late final _is.ColumnString inviteCode;

  late final _is.ColumnString createdBy;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnBool isActive;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    addressLabel,
    inviteCode,
    createdBy,
    createdAt,
    isActive,
  ];
}

class SocietyInclude extends _is.IncludeObject {
  SocietyInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Society.t;
}

class SocietyIncludeList extends _is.IncludeList {
  SocietyIncludeList._({
    _is.WhereExpressionBuilder<SocietyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Society.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Society.t;
}

class SocietyRepository {
  const SocietyRepository._();

  /// Returns a list of [Society]s matching the given query parameters.
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
  Future<List<Society>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SocietyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SocietyTable>? orderBy,
    _is.OrderByListBuilder<SocietyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Society>(
      where: where?.call(Society.t),
      orderBy: orderBy?.call(Society.t),
      orderByList: orderByList?.call(Society.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Society] matching the given query parameters.
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
  Future<Society?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SocietyTable>? where,
    int? offset,
    _is.OrderByBuilder<SocietyTable>? orderBy,
    _is.OrderByListBuilder<SocietyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Society>(
      where: where?.call(Society.t),
      orderBy: orderBy?.call(Society.t),
      orderByList: orderByList?.call(Society.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Society] by its [id] or null if no such row exists.
  Future<Society?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Society>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Society]s in the list and returns the inserted rows.
  ///
  /// The returned [Society]s will have their `id` fields set.
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
  Future<List<Society>> insert(
    _is.DatabaseSession session,
    List<Society> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Society>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Society] and returns the inserted row.
  ///
  /// The returned [Society] will have its `id` field set.
  Future<Society> insertRow(
    _is.DatabaseSession session,
    Society row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Society>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Society]s in the list and returns the resulting rows.
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
  /// The returned [Society]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Society>> upsert(
    _is.DatabaseSession session,
    List<Society> rows, {
    required _is.ColumnSelections<SocietyTable> conflictColumns,
    _is.ColumnSelections<SocietyTable>? updateColumns,
    _is.WhereExpressionBuilder<SocietyTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Society>(
      rows,
      conflictColumns: conflictColumns(Society.t),
      updateColumns: updateColumns?.call(Society.t),
      updateWhere: updateWhere?.call(Society.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Society] and returns the resulting row.
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
  /// The returned [Society] will have its `id` field set.
  Future<Society?> upsertRow(
    _is.DatabaseSession session,
    Society row, {
    required _is.ColumnSelections<SocietyTable> conflictColumns,
    _is.ColumnSelections<SocietyTable>? updateColumns,
    _is.WhereExpressionBuilder<SocietyTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Society>(
      row,
      conflictColumns: conflictColumns(Society.t),
      updateColumns: updateColumns?.call(Society.t),
      updateWhere: updateWhere?.call(Society.t),
      transaction: transaction,
    );
  }

  /// Updates all [Society]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Society>> update(
    _is.DatabaseSession session,
    List<Society> rows, {
    _is.ColumnSelections<SocietyTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Society>(
      rows,
      columns: columns?.call(Society.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Society]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Society> updateRow(
    _is.DatabaseSession session,
    Society row, {
    _is.ColumnSelections<SocietyTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Society>(
      row,
      columns: columns?.call(Society.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Society] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Society?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SocietyUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Society>(
      id,
      columnValues: columnValues(Society.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Society]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Society>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SocietyUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SocietyTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SocietyTable>? orderBy,
    _is.OrderByListBuilder<SocietyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Society>(
      columnValues: columnValues(Society.t.updateTable),
      where: where(Society.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Society.t),
      orderByList: orderByList?.call(Society.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Society]s in the list and returns the deleted rows.
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
  Future<List<Society>> delete(
    _is.DatabaseSession session,
    List<Society> rows, {
    _is.OrderByBuilder<SocietyTable>? orderBy,
    _is.OrderByListBuilder<SocietyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Society>(
      rows,
      orderBy: orderBy?.call(Society.t),
      orderByList: orderByList?.call(Society.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Society].
  Future<Society> deleteRow(
    _is.DatabaseSession session,
    Society row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Society>(
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
  Future<List<Society>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SocietyTable> where,
    _is.OrderByBuilder<SocietyTable>? orderBy,
    _is.OrderByListBuilder<SocietyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Society>(
      where: where(Society.t),
      orderBy: orderBy?.call(Society.t),
      orderByList: orderByList?.call(Society.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SocietyTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Society>(
      where: where?.call(Society.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Society] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SocietyTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Society>(
      where: where(Society.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
