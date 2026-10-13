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

abstract class EventParticipant
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  EventParticipant._({
    this.id,
    required this.eventId,
    required this.userId,
    required this.joinedAt,
    required this.status,
  });

  factory EventParticipant({
    int? id,
    required int eventId,
    required int userId,
    required DateTime joinedAt,
    required String status,
  }) = _EventParticipantImpl;

  factory EventParticipant.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventParticipant(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      userId: jsonSerialization['userId'] as int,
      joinedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
      status: jsonSerialization['status'] as String,
    );
  }

  static final t = EventParticipantTable();

  static const db = EventParticipantRepository._();

  @override
  int? id;

  int eventId;

  int userId;

  DateTime joinedAt;

  String status;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EventParticipant]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EventParticipant copyWith({
    int? id,
    int? eventId,
    int? userId,
    DateTime? joinedAt,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventParticipant',
      if (id != null) 'id': id,
      'eventId': eventId,
      'userId': userId,
      'joinedAt': joinedAt.toJson(),
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventParticipant',
      if (id != null) 'id': id,
      'eventId': eventId,
      'userId': userId,
      'joinedAt': joinedAt.toJson(),
      'status': status,
    };
  }

  static EventParticipantInclude include() {
    return EventParticipantInclude._();
  }

  static EventParticipantIncludeList includeList({
    _is.WhereExpressionBuilder<EventParticipantTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventParticipantTable>? orderBy,
    _is.OrderByListBuilder<EventParticipantTable>? orderByList,
    EventParticipantInclude? include,
  }) {
    return EventParticipantIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EventParticipant.t),
      orderByList: orderByList?.call(EventParticipant.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventParticipantImpl extends EventParticipant {
  _EventParticipantImpl({
    int? id,
    required int eventId,
    required int userId,
    required DateTime joinedAt,
    required String status,
  }) : super._(
         id: id,
         eventId: eventId,
         userId: userId,
         joinedAt: joinedAt,
         status: status,
       );

  /// Returns a shallow copy of this [EventParticipant]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EventParticipant copyWith({
    Object? id = _Undefined,
    int? eventId,
    int? userId,
    DateTime? joinedAt,
    String? status,
  }) {
    return EventParticipant(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      joinedAt: joinedAt ?? this.joinedAt,
      status: status ?? this.status,
    );
  }
}

class EventParticipantUpdateTable
    extends _is.UpdateTable<EventParticipantTable> {
  EventParticipantUpdateTable(super.table);

  _is.ColumnValue<int, int> eventId(int value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> joinedAt(DateTime value) =>
      _is.ColumnValue(
        table.joinedAt,
        value,
      );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );
}

class EventParticipantTable extends _is.Table<int?> {
  EventParticipantTable({super.tableRelation})
    : super(tableName: 'event_participant') {
    updateTable = EventParticipantUpdateTable(this);
    eventId = _is.ColumnInt(
      'eventId',
      this,
    );
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    joinedAt = _is.ColumnDateTime(
      'joinedAt',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
  }

  late final EventParticipantUpdateTable updateTable;

  late final _is.ColumnInt eventId;

  late final _is.ColumnInt userId;

  late final _is.ColumnDateTime joinedAt;

  late final _is.ColumnString status;

  @override
  List<_is.Column> get columns => [
    id,
    eventId,
    userId,
    joinedAt,
    status,
  ];
}

class EventParticipantInclude extends _is.IncludeObject {
  EventParticipantInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EventParticipant.t;
}

class EventParticipantIncludeList extends _is.IncludeList {
  EventParticipantIncludeList._({
    _is.WhereExpressionBuilder<EventParticipantTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EventParticipant.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EventParticipant.t;
}

class EventParticipantRepository {
  const EventParticipantRepository._();

  /// Returns a list of [EventParticipant]s matching the given query parameters.
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
  Future<List<EventParticipant>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventParticipantTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventParticipantTable>? orderBy,
    _is.OrderByListBuilder<EventParticipantTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EventParticipant>(
      where: where?.call(EventParticipant.t),
      orderBy: orderBy?.call(EventParticipant.t),
      orderByList: orderByList?.call(EventParticipant.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EventParticipant] matching the given query parameters.
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
  Future<EventParticipant?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventParticipantTable>? where,
    int? offset,
    _is.OrderByBuilder<EventParticipantTable>? orderBy,
    _is.OrderByListBuilder<EventParticipantTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EventParticipant>(
      where: where?.call(EventParticipant.t),
      orderBy: orderBy?.call(EventParticipant.t),
      orderByList: orderByList?.call(EventParticipant.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EventParticipant] by its [id] or null if no such row exists.
  Future<EventParticipant?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EventParticipant>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EventParticipant]s in the list and returns the inserted rows.
  ///
  /// The returned [EventParticipant]s will have their `id` fields set.
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
  Future<List<EventParticipant>> insert(
    _is.DatabaseSession session,
    List<EventParticipant> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EventParticipant>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EventParticipant] and returns the inserted row.
  ///
  /// The returned [EventParticipant] will have its `id` field set.
  Future<EventParticipant> insertRow(
    _is.DatabaseSession session,
    EventParticipant row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EventParticipant>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EventParticipant]s in the list and returns the resulting rows.
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
  /// The returned [EventParticipant]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventParticipant>> upsert(
    _is.DatabaseSession session,
    List<EventParticipant> rows, {
    required _is.ColumnSelections<EventParticipantTable> conflictColumns,
    _is.ColumnSelections<EventParticipantTable>? updateColumns,
    _is.WhereExpressionBuilder<EventParticipantTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EventParticipant>(
      rows,
      conflictColumns: conflictColumns(EventParticipant.t),
      updateColumns: updateColumns?.call(EventParticipant.t),
      updateWhere: updateWhere?.call(EventParticipant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EventParticipant] and returns the resulting row.
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
  /// The returned [EventParticipant] will have its `id` field set.
  Future<EventParticipant?> upsertRow(
    _is.DatabaseSession session,
    EventParticipant row, {
    required _is.ColumnSelections<EventParticipantTable> conflictColumns,
    _is.ColumnSelections<EventParticipantTable>? updateColumns,
    _is.WhereExpressionBuilder<EventParticipantTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EventParticipant>(
      row,
      conflictColumns: conflictColumns(EventParticipant.t),
      updateColumns: updateColumns?.call(EventParticipant.t),
      updateWhere: updateWhere?.call(EventParticipant.t),
      transaction: transaction,
    );
  }

  /// Updates all [EventParticipant]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventParticipant>> update(
    _is.DatabaseSession session,
    List<EventParticipant> rows, {
    _is.ColumnSelections<EventParticipantTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EventParticipant>(
      rows,
      columns: columns?.call(EventParticipant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EventParticipant]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EventParticipant> updateRow(
    _is.DatabaseSession session,
    EventParticipant row, {
    _is.ColumnSelections<EventParticipantTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EventParticipant>(
      row,
      columns: columns?.call(EventParticipant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EventParticipant] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EventParticipant?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EventParticipantUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EventParticipant>(
      id,
      columnValues: columnValues(EventParticipant.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EventParticipant]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventParticipant>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EventParticipantUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<EventParticipantTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventParticipantTable>? orderBy,
    _is.OrderByListBuilder<EventParticipantTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EventParticipant>(
      columnValues: columnValues(EventParticipant.t.updateTable),
      where: where(EventParticipant.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EventParticipant.t),
      orderByList: orderByList?.call(EventParticipant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EventParticipant]s in the list and returns the deleted rows.
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
  Future<List<EventParticipant>> delete(
    _is.DatabaseSession session,
    List<EventParticipant> rows, {
    _is.OrderByBuilder<EventParticipantTable>? orderBy,
    _is.OrderByListBuilder<EventParticipantTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EventParticipant>(
      rows,
      orderBy: orderBy?.call(EventParticipant.t),
      orderByList: orderByList?.call(EventParticipant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EventParticipant].
  Future<EventParticipant> deleteRow(
    _is.DatabaseSession session,
    EventParticipant row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EventParticipant>(
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
  Future<List<EventParticipant>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EventParticipantTable> where,
    _is.OrderByBuilder<EventParticipantTable>? orderBy,
    _is.OrderByListBuilder<EventParticipantTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EventParticipant>(
      where: where(EventParticipant.t),
      orderBy: orderBy?.call(EventParticipant.t),
      orderByList: orderByList?.call(EventParticipant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventParticipantTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EventParticipant>(
      where: where?.call(EventParticipant.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EventParticipant] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EventParticipantTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EventParticipant>(
      where: where(EventParticipant.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
