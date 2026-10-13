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

abstract class CommunityEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CommunityEvent._({
    this.id,
    required this.societyId,
    required this.organizerUserId,
    required this.title,
    required this.description,
    required this.category,
    required this.startsAt,
    required this.endsAt,
    required this.latitude,
    required this.longitude,
    required this.venueLabel,
    required this.capacity,
    required this.status,
    required this.isDemo,
  });

  factory CommunityEvent({
    int? id,
    required int societyId,
    required int organizerUserId,
    required String title,
    required String description,
    required String category,
    required DateTime startsAt,
    required DateTime endsAt,
    required double latitude,
    required double longitude,
    required String venueLabel,
    required int capacity,
    required String status,
    required bool isDemo,
  }) = _CommunityEventImpl;

  factory CommunityEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommunityEvent(
      id: jsonSerialization['id'] as int?,
      societyId: jsonSerialization['societyId'] as int,
      organizerUserId: jsonSerialization['organizerUserId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      category: jsonSerialization['category'] as String,
      startsAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      venueLabel: jsonSerialization['venueLabel'] as String,
      capacity: jsonSerialization['capacity'] as int,
      status: jsonSerialization['status'] as String,
      isDemo: _is.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
    );
  }

  static final t = CommunityEventTable();

  static const db = CommunityEventRepository._();

  @override
  int? id;

  int societyId;

  int organizerUserId;

  String title;

  String description;

  String category;

  DateTime startsAt;

  DateTime endsAt;

  double latitude;

  double longitude;

  String venueLabel;

  int capacity;

  String status;

  bool isDemo;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CommunityEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CommunityEvent copyWith({
    int? id,
    int? societyId,
    int? organizerUserId,
    String? title,
    String? description,
    String? category,
    DateTime? startsAt,
    DateTime? endsAt,
    double? latitude,
    double? longitude,
    String? venueLabel,
    int? capacity,
    String? status,
    bool? isDemo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommunityEvent',
      if (id != null) 'id': id,
      'societyId': societyId,
      'organizerUserId': organizerUserId,
      'title': title,
      'description': description,
      'category': category,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'latitude': latitude,
      'longitude': longitude,
      'venueLabel': venueLabel,
      'capacity': capacity,
      'status': status,
      'isDemo': isDemo,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CommunityEvent',
      if (id != null) 'id': id,
      'societyId': societyId,
      'organizerUserId': organizerUserId,
      'title': title,
      'description': description,
      'category': category,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'latitude': latitude,
      'longitude': longitude,
      'venueLabel': venueLabel,
      'capacity': capacity,
      'status': status,
      'isDemo': isDemo,
    };
  }

  static CommunityEventInclude include() {
    return CommunityEventInclude._();
  }

  static CommunityEventIncludeList includeList({
    _is.WhereExpressionBuilder<CommunityEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CommunityEventTable>? orderBy,
    _is.OrderByListBuilder<CommunityEventTable>? orderByList,
    CommunityEventInclude? include,
  }) {
    return CommunityEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CommunityEvent.t),
      orderByList: orderByList?.call(CommunityEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommunityEventImpl extends CommunityEvent {
  _CommunityEventImpl({
    int? id,
    required int societyId,
    required int organizerUserId,
    required String title,
    required String description,
    required String category,
    required DateTime startsAt,
    required DateTime endsAt,
    required double latitude,
    required double longitude,
    required String venueLabel,
    required int capacity,
    required String status,
    required bool isDemo,
  }) : super._(
         id: id,
         societyId: societyId,
         organizerUserId: organizerUserId,
         title: title,
         description: description,
         category: category,
         startsAt: startsAt,
         endsAt: endsAt,
         latitude: latitude,
         longitude: longitude,
         venueLabel: venueLabel,
         capacity: capacity,
         status: status,
         isDemo: isDemo,
       );

  /// Returns a shallow copy of this [CommunityEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CommunityEvent copyWith({
    Object? id = _Undefined,
    int? societyId,
    int? organizerUserId,
    String? title,
    String? description,
    String? category,
    DateTime? startsAt,
    DateTime? endsAt,
    double? latitude,
    double? longitude,
    String? venueLabel,
    int? capacity,
    String? status,
    bool? isDemo,
  }) {
    return CommunityEvent(
      id: id is int? ? id : this.id,
      societyId: societyId ?? this.societyId,
      organizerUserId: organizerUserId ?? this.organizerUserId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      venueLabel: venueLabel ?? this.venueLabel,
      capacity: capacity ?? this.capacity,
      status: status ?? this.status,
      isDemo: isDemo ?? this.isDemo,
    );
  }
}

class CommunityEventUpdateTable extends _is.UpdateTable<CommunityEventTable> {
  CommunityEventUpdateTable(super.table);

  _is.ColumnValue<int, int> societyId(int value) => _is.ColumnValue(
    table.societyId,
    value,
  );

  _is.ColumnValue<int, int> organizerUserId(int value) => _is.ColumnValue(
    table.organizerUserId,
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

  _is.ColumnValue<String, String> category(String value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startsAt(DateTime value) =>
      _is.ColumnValue(
        table.startsAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endsAt(DateTime value) => _is.ColumnValue(
    table.endsAt,
    value,
  );

  _is.ColumnValue<double, double> latitude(double value) => _is.ColumnValue(
    table.latitude,
    value,
  );

  _is.ColumnValue<double, double> longitude(double value) => _is.ColumnValue(
    table.longitude,
    value,
  );

  _is.ColumnValue<String, String> venueLabel(String value) => _is.ColumnValue(
    table.venueLabel,
    value,
  );

  _is.ColumnValue<int, int> capacity(int value) => _is.ColumnValue(
    table.capacity,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<bool, bool> isDemo(bool value) => _is.ColumnValue(
    table.isDemo,
    value,
  );
}

class CommunityEventTable extends _is.Table<int?> {
  CommunityEventTable({super.tableRelation})
    : super(tableName: 'community_event') {
    updateTable = CommunityEventUpdateTable(this);
    societyId = _is.ColumnInt(
      'societyId',
      this,
    );
    organizerUserId = _is.ColumnInt(
      'organizerUserId',
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
    category = _is.ColumnString(
      'category',
      this,
    );
    startsAt = _is.ColumnDateTime(
      'startsAt',
      this,
    );
    endsAt = _is.ColumnDateTime(
      'endsAt',
      this,
    );
    latitude = _is.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _is.ColumnDouble(
      'longitude',
      this,
    );
    venueLabel = _is.ColumnString(
      'venueLabel',
      this,
    );
    capacity = _is.ColumnInt(
      'capacity',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    isDemo = _is.ColumnBool(
      'isDemo',
      this,
    );
  }

  late final CommunityEventUpdateTable updateTable;

  late final _is.ColumnInt societyId;

  late final _is.ColumnInt organizerUserId;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnString category;

  late final _is.ColumnDateTime startsAt;

  late final _is.ColumnDateTime endsAt;

  late final _is.ColumnDouble latitude;

  late final _is.ColumnDouble longitude;

  late final _is.ColumnString venueLabel;

  late final _is.ColumnInt capacity;

  late final _is.ColumnString status;

  late final _is.ColumnBool isDemo;

  @override
  List<_is.Column> get columns => [
    id,
    societyId,
    organizerUserId,
    title,
    description,
    category,
    startsAt,
    endsAt,
    latitude,
    longitude,
    venueLabel,
    capacity,
    status,
    isDemo,
  ];
}

class CommunityEventInclude extends _is.IncludeObject {
  CommunityEventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CommunityEvent.t;
}

class CommunityEventIncludeList extends _is.IncludeList {
  CommunityEventIncludeList._({
    _is.WhereExpressionBuilder<CommunityEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CommunityEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CommunityEvent.t;
}

class CommunityEventRepository {
  const CommunityEventRepository._();

  /// Returns a list of [CommunityEvent]s matching the given query parameters.
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
  Future<List<CommunityEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CommunityEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CommunityEventTable>? orderBy,
    _is.OrderByListBuilder<CommunityEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CommunityEvent>(
      where: where?.call(CommunityEvent.t),
      orderBy: orderBy?.call(CommunityEvent.t),
      orderByList: orderByList?.call(CommunityEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CommunityEvent] matching the given query parameters.
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
  Future<CommunityEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CommunityEventTable>? where,
    int? offset,
    _is.OrderByBuilder<CommunityEventTable>? orderBy,
    _is.OrderByListBuilder<CommunityEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CommunityEvent>(
      where: where?.call(CommunityEvent.t),
      orderBy: orderBy?.call(CommunityEvent.t),
      orderByList: orderByList?.call(CommunityEvent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CommunityEvent] by its [id] or null if no such row exists.
  Future<CommunityEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CommunityEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CommunityEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [CommunityEvent]s will have their `id` fields set.
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
  Future<List<CommunityEvent>> insert(
    _is.DatabaseSession session,
    List<CommunityEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CommunityEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CommunityEvent] and returns the inserted row.
  ///
  /// The returned [CommunityEvent] will have its `id` field set.
  Future<CommunityEvent> insertRow(
    _is.DatabaseSession session,
    CommunityEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CommunityEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CommunityEvent]s in the list and returns the resulting rows.
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
  /// The returned [CommunityEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CommunityEvent>> upsert(
    _is.DatabaseSession session,
    List<CommunityEvent> rows, {
    required _is.ColumnSelections<CommunityEventTable> conflictColumns,
    _is.ColumnSelections<CommunityEventTable>? updateColumns,
    _is.WhereExpressionBuilder<CommunityEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CommunityEvent>(
      rows,
      conflictColumns: conflictColumns(CommunityEvent.t),
      updateColumns: updateColumns?.call(CommunityEvent.t),
      updateWhere: updateWhere?.call(CommunityEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CommunityEvent] and returns the resulting row.
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
  /// The returned [CommunityEvent] will have its `id` field set.
  Future<CommunityEvent?> upsertRow(
    _is.DatabaseSession session,
    CommunityEvent row, {
    required _is.ColumnSelections<CommunityEventTable> conflictColumns,
    _is.ColumnSelections<CommunityEventTable>? updateColumns,
    _is.WhereExpressionBuilder<CommunityEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CommunityEvent>(
      row,
      conflictColumns: conflictColumns(CommunityEvent.t),
      updateColumns: updateColumns?.call(CommunityEvent.t),
      updateWhere: updateWhere?.call(CommunityEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [CommunityEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CommunityEvent>> update(
    _is.DatabaseSession session,
    List<CommunityEvent> rows, {
    _is.ColumnSelections<CommunityEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CommunityEvent>(
      rows,
      columns: columns?.call(CommunityEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CommunityEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CommunityEvent> updateRow(
    _is.DatabaseSession session,
    CommunityEvent row, {
    _is.ColumnSelections<CommunityEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CommunityEvent>(
      row,
      columns: columns?.call(CommunityEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CommunityEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CommunityEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CommunityEventUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CommunityEvent>(
      id,
      columnValues: columnValues(CommunityEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CommunityEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CommunityEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CommunityEventUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CommunityEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CommunityEventTable>? orderBy,
    _is.OrderByListBuilder<CommunityEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CommunityEvent>(
      columnValues: columnValues(CommunityEvent.t.updateTable),
      where: where(CommunityEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CommunityEvent.t),
      orderByList: orderByList?.call(CommunityEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CommunityEvent]s in the list and returns the deleted rows.
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
  Future<List<CommunityEvent>> delete(
    _is.DatabaseSession session,
    List<CommunityEvent> rows, {
    _is.OrderByBuilder<CommunityEventTable>? orderBy,
    _is.OrderByListBuilder<CommunityEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CommunityEvent>(
      rows,
      orderBy: orderBy?.call(CommunityEvent.t),
      orderByList: orderByList?.call(CommunityEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CommunityEvent].
  Future<CommunityEvent> deleteRow(
    _is.DatabaseSession session,
    CommunityEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CommunityEvent>(
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
  Future<List<CommunityEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CommunityEventTable> where,
    _is.OrderByBuilder<CommunityEventTable>? orderBy,
    _is.OrderByListBuilder<CommunityEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CommunityEvent>(
      where: where(CommunityEvent.t),
      orderBy: orderBy?.call(CommunityEvent.t),
      orderByList: orderByList?.call(CommunityEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CommunityEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CommunityEvent>(
      where: where?.call(CommunityEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CommunityEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CommunityEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CommunityEvent>(
      where: where(CommunityEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
