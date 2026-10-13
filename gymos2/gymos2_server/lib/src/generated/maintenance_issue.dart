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

abstract class MaintenanceIssue
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  MaintenanceIssue._({
    this.id,
    required this.societyId,
    required this.societyEquipmentId,
    required this.reportedBy,
    required this.title,
    required this.description,
    required this.severity,
    required this.status,
    this.photoPath,
    required this.createdAt,
    this.resolvedAt,
  });

  factory MaintenanceIssue({
    int? id,
    required int societyId,
    required int societyEquipmentId,
    required int reportedBy,
    required String title,
    required String description,
    required String severity,
    required String status,
    String? photoPath,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) = _MaintenanceIssueImpl;

  factory MaintenanceIssue.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaintenanceIssue(
      id: jsonSerialization['id'] as int?,
      societyId: jsonSerialization['societyId'] as int,
      societyEquipmentId: jsonSerialization['societyEquipmentId'] as int,
      reportedBy: jsonSerialization['reportedBy'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      severity: jsonSerialization['severity'] as String,
      status: jsonSerialization['status'] as String,
      photoPath: jsonSerialization['photoPath'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  static final t = MaintenanceIssueTable();

  static const db = MaintenanceIssueRepository._();

  @override
  int? id;

  int societyId;

  int societyEquipmentId;

  int reportedBy;

  String title;

  String description;

  String severity;

  String status;

  String? photoPath;

  DateTime createdAt;

  DateTime? resolvedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [MaintenanceIssue]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MaintenanceIssue copyWith({
    int? id,
    int? societyId,
    int? societyEquipmentId,
    int? reportedBy,
    String? title,
    String? description,
    String? severity,
    String? status,
    String? photoPath,
    DateTime? createdAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaintenanceIssue',
      if (id != null) 'id': id,
      'societyId': societyId,
      'societyEquipmentId': societyEquipmentId,
      'reportedBy': reportedBy,
      'title': title,
      'description': description,
      'severity': severity,
      'status': status,
      if (photoPath != null) 'photoPath': photoPath,
      'createdAt': createdAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MaintenanceIssue',
      if (id != null) 'id': id,
      'societyId': societyId,
      'societyEquipmentId': societyEquipmentId,
      'reportedBy': reportedBy,
      'title': title,
      'description': description,
      'severity': severity,
      'status': status,
      if (photoPath != null) 'photoPath': photoPath,
      'createdAt': createdAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  static MaintenanceIssueInclude include() {
    return MaintenanceIssueInclude._();
  }

  static MaintenanceIssueIncludeList includeList({
    _is.WhereExpressionBuilder<MaintenanceIssueTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MaintenanceIssueTable>? orderBy,
    _is.OrderByListBuilder<MaintenanceIssueTable>? orderByList,
    MaintenanceIssueInclude? include,
  }) {
    return MaintenanceIssueIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MaintenanceIssue.t),
      orderByList: orderByList?.call(MaintenanceIssue.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MaintenanceIssueImpl extends MaintenanceIssue {
  _MaintenanceIssueImpl({
    int? id,
    required int societyId,
    required int societyEquipmentId,
    required int reportedBy,
    required String title,
    required String description,
    required String severity,
    required String status,
    String? photoPath,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         societyId: societyId,
         societyEquipmentId: societyEquipmentId,
         reportedBy: reportedBy,
         title: title,
         description: description,
         severity: severity,
         status: status,
         photoPath: photoPath,
         createdAt: createdAt,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [MaintenanceIssue]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MaintenanceIssue copyWith({
    Object? id = _Undefined,
    int? societyId,
    int? societyEquipmentId,
    int? reportedBy,
    String? title,
    String? description,
    String? severity,
    String? status,
    Object? photoPath = _Undefined,
    DateTime? createdAt,
    Object? resolvedAt = _Undefined,
  }) {
    return MaintenanceIssue(
      id: id is int? ? id : this.id,
      societyId: societyId ?? this.societyId,
      societyEquipmentId: societyEquipmentId ?? this.societyEquipmentId,
      reportedBy: reportedBy ?? this.reportedBy,
      title: title ?? this.title,
      description: description ?? this.description,
      severity: severity ?? this.severity,
      status: status ?? this.status,
      photoPath: photoPath is String? ? photoPath : this.photoPath,
      createdAt: createdAt ?? this.createdAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}

class MaintenanceIssueUpdateTable
    extends _is.UpdateTable<MaintenanceIssueTable> {
  MaintenanceIssueUpdateTable(super.table);

  _is.ColumnValue<int, int> societyId(int value) => _is.ColumnValue(
    table.societyId,
    value,
  );

  _is.ColumnValue<int, int> societyEquipmentId(int value) => _is.ColumnValue(
    table.societyEquipmentId,
    value,
  );

  _is.ColumnValue<int, int> reportedBy(int value) => _is.ColumnValue(
    table.reportedBy,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> severity(String value) => _is.ColumnValue(
    table.severity,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> photoPath(String? value) => _is.ColumnValue(
    table.photoPath,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _is.ColumnValue(
        table.resolvedAt,
        value,
      );
}

class MaintenanceIssueTable extends _is.Table<int?> {
  MaintenanceIssueTable({super.tableRelation})
    : super(tableName: 'maintenance_issue') {
    updateTable = MaintenanceIssueUpdateTable(this);
    societyId = _is.ColumnInt(
      'societyId',
      this,
    );
    societyEquipmentId = _is.ColumnInt(
      'societyEquipmentId',
      this,
    );
    reportedBy = _is.ColumnInt(
      'reportedBy',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    severity = _is.ColumnString(
      'severity',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    photoPath = _is.ColumnString(
      'photoPath',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    resolvedAt = _is.ColumnDateTime(
      'resolvedAt',
      this,
    );
  }

  late final MaintenanceIssueUpdateTable updateTable;

  late final _is.ColumnInt societyId;

  late final _is.ColumnInt societyEquipmentId;

  late final _is.ColumnInt reportedBy;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnString severity;

  late final _is.ColumnString status;

  late final _is.ColumnString photoPath;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime resolvedAt;

  @override
  List<_is.Column> get columns => [
    id,
    societyId,
    societyEquipmentId,
    reportedBy,
    title,
    description,
    severity,
    status,
    photoPath,
    createdAt,
    resolvedAt,
  ];
}

class MaintenanceIssueInclude extends _is.IncludeObject {
  MaintenanceIssueInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => MaintenanceIssue.t;
}

class MaintenanceIssueIncludeList extends _is.IncludeList {
  MaintenanceIssueIncludeList._({
    _is.WhereExpressionBuilder<MaintenanceIssueTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MaintenanceIssue.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => MaintenanceIssue.t;
}

class MaintenanceIssueRepository {
  const MaintenanceIssueRepository._();

  /// Returns a list of [MaintenanceIssue]s matching the given query parameters.
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
  Future<List<MaintenanceIssue>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MaintenanceIssueTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MaintenanceIssueTable>? orderBy,
    _is.OrderByListBuilder<MaintenanceIssueTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MaintenanceIssue>(
      where: where?.call(MaintenanceIssue.t),
      orderBy: orderBy?.call(MaintenanceIssue.t),
      orderByList: orderByList?.call(MaintenanceIssue.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MaintenanceIssue] matching the given query parameters.
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
  Future<MaintenanceIssue?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MaintenanceIssueTable>? where,
    int? offset,
    _is.OrderByBuilder<MaintenanceIssueTable>? orderBy,
    _is.OrderByListBuilder<MaintenanceIssueTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MaintenanceIssue>(
      where: where?.call(MaintenanceIssue.t),
      orderBy: orderBy?.call(MaintenanceIssue.t),
      orderByList: orderByList?.call(MaintenanceIssue.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MaintenanceIssue] by its [id] or null if no such row exists.
  Future<MaintenanceIssue?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MaintenanceIssue>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MaintenanceIssue]s in the list and returns the inserted rows.
  ///
  /// The returned [MaintenanceIssue]s will have their `id` fields set.
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
  Future<List<MaintenanceIssue>> insert(
    _is.DatabaseSession session,
    List<MaintenanceIssue> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MaintenanceIssue>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MaintenanceIssue] and returns the inserted row.
  ///
  /// The returned [MaintenanceIssue] will have its `id` field set.
  Future<MaintenanceIssue> insertRow(
    _is.DatabaseSession session,
    MaintenanceIssue row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MaintenanceIssue>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [MaintenanceIssue]s in the list and returns the resulting rows.
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
  /// The returned [MaintenanceIssue]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MaintenanceIssue>> upsert(
    _is.DatabaseSession session,
    List<MaintenanceIssue> rows, {
    required _is.ColumnSelections<MaintenanceIssueTable> conflictColumns,
    _is.ColumnSelections<MaintenanceIssueTable>? updateColumns,
    _is.WhereExpressionBuilder<MaintenanceIssueTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MaintenanceIssue>(
      rows,
      conflictColumns: conflictColumns(MaintenanceIssue.t),
      updateColumns: updateColumns?.call(MaintenanceIssue.t),
      updateWhere: updateWhere?.call(MaintenanceIssue.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MaintenanceIssue] and returns the resulting row.
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
  /// The returned [MaintenanceIssue] will have its `id` field set.
  Future<MaintenanceIssue?> upsertRow(
    _is.DatabaseSession session,
    MaintenanceIssue row, {
    required _is.ColumnSelections<MaintenanceIssueTable> conflictColumns,
    _is.ColumnSelections<MaintenanceIssueTable>? updateColumns,
    _is.WhereExpressionBuilder<MaintenanceIssueTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MaintenanceIssue>(
      row,
      conflictColumns: conflictColumns(MaintenanceIssue.t),
      updateColumns: updateColumns?.call(MaintenanceIssue.t),
      updateWhere: updateWhere?.call(MaintenanceIssue.t),
      transaction: transaction,
    );
  }

  /// Updates all [MaintenanceIssue]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MaintenanceIssue>> update(
    _is.DatabaseSession session,
    List<MaintenanceIssue> rows, {
    _is.ColumnSelections<MaintenanceIssueTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MaintenanceIssue>(
      rows,
      columns: columns?.call(MaintenanceIssue.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MaintenanceIssue]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MaintenanceIssue> updateRow(
    _is.DatabaseSession session,
    MaintenanceIssue row, {
    _is.ColumnSelections<MaintenanceIssueTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MaintenanceIssue>(
      row,
      columns: columns?.call(MaintenanceIssue.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MaintenanceIssue] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MaintenanceIssue?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MaintenanceIssueUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MaintenanceIssue>(
      id,
      columnValues: columnValues(MaintenanceIssue.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MaintenanceIssue]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MaintenanceIssue>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MaintenanceIssueUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<MaintenanceIssueTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MaintenanceIssueTable>? orderBy,
    _is.OrderByListBuilder<MaintenanceIssueTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MaintenanceIssue>(
      columnValues: columnValues(MaintenanceIssue.t.updateTable),
      where: where(MaintenanceIssue.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MaintenanceIssue.t),
      orderByList: orderByList?.call(MaintenanceIssue.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MaintenanceIssue]s in the list and returns the deleted rows.
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
  Future<List<MaintenanceIssue>> delete(
    _is.DatabaseSession session,
    List<MaintenanceIssue> rows, {
    _is.OrderByBuilder<MaintenanceIssueTable>? orderBy,
    _is.OrderByListBuilder<MaintenanceIssueTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MaintenanceIssue>(
      rows,
      orderBy: orderBy?.call(MaintenanceIssue.t),
      orderByList: orderByList?.call(MaintenanceIssue.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MaintenanceIssue].
  Future<MaintenanceIssue> deleteRow(
    _is.DatabaseSession session,
    MaintenanceIssue row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MaintenanceIssue>(
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
  Future<List<MaintenanceIssue>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MaintenanceIssueTable> where,
    _is.OrderByBuilder<MaintenanceIssueTable>? orderBy,
    _is.OrderByListBuilder<MaintenanceIssueTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MaintenanceIssue>(
      where: where(MaintenanceIssue.t),
      orderBy: orderBy?.call(MaintenanceIssue.t),
      orderByList: orderByList?.call(MaintenanceIssue.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MaintenanceIssueTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MaintenanceIssue>(
      where: where?.call(MaintenanceIssue.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MaintenanceIssue] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MaintenanceIssueTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MaintenanceIssue>(
      where: where(MaintenanceIssue.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
