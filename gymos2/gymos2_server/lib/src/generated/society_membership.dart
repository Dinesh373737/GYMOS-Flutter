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

abstract class SocietyMembership
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SocietyMembership._({
    this.id,
    required this.societyId,
    required this.userId,
    required this.role,
    required this.joinedAt,
    required this.isActive,
  });

  factory SocietyMembership({
    int? id,
    required int societyId,
    required int userId,
    required String role,
    required DateTime joinedAt,
    required bool isActive,
  }) = _SocietyMembershipImpl;

  factory SocietyMembership.fromJson(Map<String, dynamic> jsonSerialization) {
    return SocietyMembership(
      id: jsonSerialization['id'] as int?,
      societyId: jsonSerialization['societyId'] as int,
      userId: jsonSerialization['userId'] as int,
      role: jsonSerialization['role'] as String,
      joinedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
      isActive: _is.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
    );
  }

  static final t = SocietyMembershipTable();

  static const db = SocietyMembershipRepository._();

  @override
  int? id;

  int societyId;

  int userId;

  String role;

  DateTime joinedAt;

  bool isActive;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SocietyMembership]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SocietyMembership copyWith({
    int? id,
    int? societyId,
    int? userId,
    String? role,
    DateTime? joinedAt,
    bool? isActive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SocietyMembership',
      if (id != null) 'id': id,
      'societyId': societyId,
      'userId': userId,
      'role': role,
      'joinedAt': joinedAt.toJson(),
      'isActive': isActive,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SocietyMembership',
      if (id != null) 'id': id,
      'societyId': societyId,
      'userId': userId,
      'role': role,
      'joinedAt': joinedAt.toJson(),
      'isActive': isActive,
    };
  }

  static SocietyMembershipInclude include() {
    return SocietyMembershipInclude._();
  }

  static SocietyMembershipIncludeList includeList({
    _is.WhereExpressionBuilder<SocietyMembershipTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SocietyMembershipTable>? orderBy,
    _is.OrderByListBuilder<SocietyMembershipTable>? orderByList,
    SocietyMembershipInclude? include,
  }) {
    return SocietyMembershipIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SocietyMembership.t),
      orderByList: orderByList?.call(SocietyMembership.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SocietyMembershipImpl extends SocietyMembership {
  _SocietyMembershipImpl({
    int? id,
    required int societyId,
    required int userId,
    required String role,
    required DateTime joinedAt,
    required bool isActive,
  }) : super._(
         id: id,
         societyId: societyId,
         userId: userId,
         role: role,
         joinedAt: joinedAt,
         isActive: isActive,
       );

  /// Returns a shallow copy of this [SocietyMembership]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SocietyMembership copyWith({
    Object? id = _Undefined,
    int? societyId,
    int? userId,
    String? role,
    DateTime? joinedAt,
    bool? isActive,
  }) {
    return SocietyMembership(
      id: id is int? ? id : this.id,
      societyId: societyId ?? this.societyId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}

class SocietyMembershipUpdateTable
    extends _is.UpdateTable<SocietyMembershipTable> {
  SocietyMembershipUpdateTable(super.table);

  _is.ColumnValue<int, int> societyId(int value) => _is.ColumnValue(
    table.societyId,
    value,
  );

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> role(String value) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> joinedAt(DateTime value) =>
      _is.ColumnValue(
        table.joinedAt,
        value,
      );

  _is.ColumnValue<bool, bool> isActive(bool value) => _is.ColumnValue(
    table.isActive,
    value,
  );
}

class SocietyMembershipTable extends _is.Table<int?> {
  SocietyMembershipTable({super.tableRelation})
    : super(tableName: 'society_membership') {
    updateTable = SocietyMembershipUpdateTable(this);
    societyId = _is.ColumnInt(
      'societyId',
      this,
    );
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    role = _is.ColumnString(
      'role',
      this,
    );
    joinedAt = _is.ColumnDateTime(
      'joinedAt',
      this,
    );
    isActive = _is.ColumnBool(
      'isActive',
      this,
    );
  }

  late final SocietyMembershipUpdateTable updateTable;

  late final _is.ColumnInt societyId;

  late final _is.ColumnInt userId;

  late final _is.ColumnString role;

  late final _is.ColumnDateTime joinedAt;

  late final _is.ColumnBool isActive;

  @override
  List<_is.Column> get columns => [
    id,
    societyId,
    userId,
    role,
    joinedAt,
    isActive,
  ];
}

class SocietyMembershipInclude extends _is.IncludeObject {
  SocietyMembershipInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SocietyMembership.t;
}

class SocietyMembershipIncludeList extends _is.IncludeList {
  SocietyMembershipIncludeList._({
    _is.WhereExpressionBuilder<SocietyMembershipTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SocietyMembership.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SocietyMembership.t;
}

class SocietyMembershipRepository {
  const SocietyMembershipRepository._();

  /// Returns a list of [SocietyMembership]s matching the given query parameters.
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
  Future<List<SocietyMembership>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SocietyMembershipTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SocietyMembershipTable>? orderBy,
    _is.OrderByListBuilder<SocietyMembershipTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SocietyMembership>(
      where: where?.call(SocietyMembership.t),
      orderBy: orderBy?.call(SocietyMembership.t),
      orderByList: orderByList?.call(SocietyMembership.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SocietyMembership] matching the given query parameters.
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
  Future<SocietyMembership?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SocietyMembershipTable>? where,
    int? offset,
    _is.OrderByBuilder<SocietyMembershipTable>? orderBy,
    _is.OrderByListBuilder<SocietyMembershipTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SocietyMembership>(
      where: where?.call(SocietyMembership.t),
      orderBy: orderBy?.call(SocietyMembership.t),
      orderByList: orderByList?.call(SocietyMembership.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SocietyMembership] by its [id] or null if no such row exists.
  Future<SocietyMembership?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SocietyMembership>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SocietyMembership]s in the list and returns the inserted rows.
  ///
  /// The returned [SocietyMembership]s will have their `id` fields set.
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
  Future<List<SocietyMembership>> insert(
    _is.DatabaseSession session,
    List<SocietyMembership> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SocietyMembership>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SocietyMembership] and returns the inserted row.
  ///
  /// The returned [SocietyMembership] will have its `id` field set.
  Future<SocietyMembership> insertRow(
    _is.DatabaseSession session,
    SocietyMembership row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SocietyMembership>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SocietyMembership]s in the list and returns the resulting rows.
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
  /// The returned [SocietyMembership]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SocietyMembership>> upsert(
    _is.DatabaseSession session,
    List<SocietyMembership> rows, {
    required _is.ColumnSelections<SocietyMembershipTable> conflictColumns,
    _is.ColumnSelections<SocietyMembershipTable>? updateColumns,
    _is.WhereExpressionBuilder<SocietyMembershipTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SocietyMembership>(
      rows,
      conflictColumns: conflictColumns(SocietyMembership.t),
      updateColumns: updateColumns?.call(SocietyMembership.t),
      updateWhere: updateWhere?.call(SocietyMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SocietyMembership] and returns the resulting row.
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
  /// The returned [SocietyMembership] will have its `id` field set.
  Future<SocietyMembership?> upsertRow(
    _is.DatabaseSession session,
    SocietyMembership row, {
    required _is.ColumnSelections<SocietyMembershipTable> conflictColumns,
    _is.ColumnSelections<SocietyMembershipTable>? updateColumns,
    _is.WhereExpressionBuilder<SocietyMembershipTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SocietyMembership>(
      row,
      conflictColumns: conflictColumns(SocietyMembership.t),
      updateColumns: updateColumns?.call(SocietyMembership.t),
      updateWhere: updateWhere?.call(SocietyMembership.t),
      transaction: transaction,
    );
  }

  /// Updates all [SocietyMembership]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SocietyMembership>> update(
    _is.DatabaseSession session,
    List<SocietyMembership> rows, {
    _is.ColumnSelections<SocietyMembershipTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SocietyMembership>(
      rows,
      columns: columns?.call(SocietyMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SocietyMembership]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SocietyMembership> updateRow(
    _is.DatabaseSession session,
    SocietyMembership row, {
    _is.ColumnSelections<SocietyMembershipTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SocietyMembership>(
      row,
      columns: columns?.call(SocietyMembership.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SocietyMembership] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SocietyMembership?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SocietyMembershipUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SocietyMembership>(
      id,
      columnValues: columnValues(SocietyMembership.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SocietyMembership]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SocietyMembership>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SocietyMembershipUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SocietyMembershipTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SocietyMembershipTable>? orderBy,
    _is.OrderByListBuilder<SocietyMembershipTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SocietyMembership>(
      columnValues: columnValues(SocietyMembership.t.updateTable),
      where: where(SocietyMembership.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SocietyMembership.t),
      orderByList: orderByList?.call(SocietyMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SocietyMembership]s in the list and returns the deleted rows.
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
  Future<List<SocietyMembership>> delete(
    _is.DatabaseSession session,
    List<SocietyMembership> rows, {
    _is.OrderByBuilder<SocietyMembershipTable>? orderBy,
    _is.OrderByListBuilder<SocietyMembershipTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SocietyMembership>(
      rows,
      orderBy: orderBy?.call(SocietyMembership.t),
      orderByList: orderByList?.call(SocietyMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SocietyMembership].
  Future<SocietyMembership> deleteRow(
    _is.DatabaseSession session,
    SocietyMembership row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SocietyMembership>(
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
  Future<List<SocietyMembership>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SocietyMembershipTable> where,
    _is.OrderByBuilder<SocietyMembershipTable>? orderBy,
    _is.OrderByListBuilder<SocietyMembershipTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SocietyMembership>(
      where: where(SocietyMembership.t),
      orderBy: orderBy?.call(SocietyMembership.t),
      orderByList: orderByList?.call(SocietyMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SocietyMembershipTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SocietyMembership>(
      where: where?.call(SocietyMembership.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SocietyMembership] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SocietyMembershipTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SocietyMembership>(
      where: where(SocietyMembership.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
