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

abstract class SocietyEquipment
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SocietyEquipment._({
    this.id,
    required this.societyId,
    required this.equipmentId,
    required this.label,
    required this.quantity,
    required this.status,
    required this.locationLabel,
    this.lastServicedAt,
  });

  factory SocietyEquipment({
    int? id,
    required int societyId,
    required int equipmentId,
    required String label,
    required int quantity,
    required String status,
    required String locationLabel,
    DateTime? lastServicedAt,
  }) = _SocietyEquipmentImpl;

  factory SocietyEquipment.fromJson(Map<String, dynamic> jsonSerialization) {
    return SocietyEquipment(
      id: jsonSerialization['id'] as int?,
      societyId: jsonSerialization['societyId'] as int,
      equipmentId: jsonSerialization['equipmentId'] as int,
      label: jsonSerialization['label'] as String,
      quantity: jsonSerialization['quantity'] as int,
      status: jsonSerialization['status'] as String,
      locationLabel: jsonSerialization['locationLabel'] as String,
      lastServicedAt: jsonSerialization['lastServicedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastServicedAt'],
            ),
    );
  }

  static final t = SocietyEquipmentTable();

  static const db = SocietyEquipmentRepository._();

  @override
  int? id;

  int societyId;

  int equipmentId;

  String label;

  int quantity;

  String status;

  String locationLabel;

  DateTime? lastServicedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SocietyEquipment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SocietyEquipment copyWith({
    int? id,
    int? societyId,
    int? equipmentId,
    String? label,
    int? quantity,
    String? status,
    String? locationLabel,
    DateTime? lastServicedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SocietyEquipment',
      if (id != null) 'id': id,
      'societyId': societyId,
      'equipmentId': equipmentId,
      'label': label,
      'quantity': quantity,
      'status': status,
      'locationLabel': locationLabel,
      if (lastServicedAt != null) 'lastServicedAt': lastServicedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SocietyEquipment',
      if (id != null) 'id': id,
      'societyId': societyId,
      'equipmentId': equipmentId,
      'label': label,
      'quantity': quantity,
      'status': status,
      'locationLabel': locationLabel,
      if (lastServicedAt != null) 'lastServicedAt': lastServicedAt?.toJson(),
    };
  }

  static SocietyEquipmentInclude include() {
    return SocietyEquipmentInclude._();
  }

  static SocietyEquipmentIncludeList includeList({
    _is.WhereExpressionBuilder<SocietyEquipmentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SocietyEquipmentTable>? orderBy,
    _is.OrderByListBuilder<SocietyEquipmentTable>? orderByList,
    SocietyEquipmentInclude? include,
  }) {
    return SocietyEquipmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SocietyEquipment.t),
      orderByList: orderByList?.call(SocietyEquipment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SocietyEquipmentImpl extends SocietyEquipment {
  _SocietyEquipmentImpl({
    int? id,
    required int societyId,
    required int equipmentId,
    required String label,
    required int quantity,
    required String status,
    required String locationLabel,
    DateTime? lastServicedAt,
  }) : super._(
         id: id,
         societyId: societyId,
         equipmentId: equipmentId,
         label: label,
         quantity: quantity,
         status: status,
         locationLabel: locationLabel,
         lastServicedAt: lastServicedAt,
       );

  /// Returns a shallow copy of this [SocietyEquipment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SocietyEquipment copyWith({
    Object? id = _Undefined,
    int? societyId,
    int? equipmentId,
    String? label,
    int? quantity,
    String? status,
    String? locationLabel,
    Object? lastServicedAt = _Undefined,
  }) {
    return SocietyEquipment(
      id: id is int? ? id : this.id,
      societyId: societyId ?? this.societyId,
      equipmentId: equipmentId ?? this.equipmentId,
      label: label ?? this.label,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      locationLabel: locationLabel ?? this.locationLabel,
      lastServicedAt: lastServicedAt is DateTime?
          ? lastServicedAt
          : this.lastServicedAt,
    );
  }
}

class SocietyEquipmentUpdateTable
    extends _is.UpdateTable<SocietyEquipmentTable> {
  SocietyEquipmentUpdateTable(super.table);

  _is.ColumnValue<int, int> societyId(int value) => _is.ColumnValue(
    table.societyId,
    value,
  );

  _is.ColumnValue<int, int> equipmentId(int value) => _is.ColumnValue(
    table.equipmentId,
    value,
  );

  _is.ColumnValue<String, String> label(String value) => _is.ColumnValue(
    table.label,
    value,
  );

  _is.ColumnValue<int, int> quantity(int value) => _is.ColumnValue(
    table.quantity,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> locationLabel(String value) =>
      _is.ColumnValue(
        table.locationLabel,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastServicedAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastServicedAt,
        value,
      );
}

class SocietyEquipmentTable extends _is.Table<int?> {
  SocietyEquipmentTable({super.tableRelation})
    : super(tableName: 'society_equipment') {
    updateTable = SocietyEquipmentUpdateTable(this);
    societyId = _is.ColumnInt(
      'societyId',
      this,
    );
    equipmentId = _is.ColumnInt(
      'equipmentId',
      this,
    );
    label = _is.ColumnString(
      'label',
      this,
    );
    quantity = _is.ColumnInt(
      'quantity',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    locationLabel = _is.ColumnString(
      'locationLabel',
      this,
    );
    lastServicedAt = _is.ColumnDateTime(
      'lastServicedAt',
      this,
    );
  }

  late final SocietyEquipmentUpdateTable updateTable;

  late final _is.ColumnInt societyId;

  late final _is.ColumnInt equipmentId;

  late final _is.ColumnString label;

  late final _is.ColumnInt quantity;

  late final _is.ColumnString status;

  late final _is.ColumnString locationLabel;

  late final _is.ColumnDateTime lastServicedAt;

  @override
  List<_is.Column> get columns => [
    id,
    societyId,
    equipmentId,
    label,
    quantity,
    status,
    locationLabel,
    lastServicedAt,
  ];
}

class SocietyEquipmentInclude extends _is.IncludeObject {
  SocietyEquipmentInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SocietyEquipment.t;
}

class SocietyEquipmentIncludeList extends _is.IncludeList {
  SocietyEquipmentIncludeList._({
    _is.WhereExpressionBuilder<SocietyEquipmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SocietyEquipment.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SocietyEquipment.t;
}

class SocietyEquipmentRepository {
  const SocietyEquipmentRepository._();

  /// Returns a list of [SocietyEquipment]s matching the given query parameters.
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
  Future<List<SocietyEquipment>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SocietyEquipmentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SocietyEquipmentTable>? orderBy,
    _is.OrderByListBuilder<SocietyEquipmentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SocietyEquipment>(
      where: where?.call(SocietyEquipment.t),
      orderBy: orderBy?.call(SocietyEquipment.t),
      orderByList: orderByList?.call(SocietyEquipment.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SocietyEquipment] matching the given query parameters.
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
  Future<SocietyEquipment?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SocietyEquipmentTable>? where,
    int? offset,
    _is.OrderByBuilder<SocietyEquipmentTable>? orderBy,
    _is.OrderByListBuilder<SocietyEquipmentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SocietyEquipment>(
      where: where?.call(SocietyEquipment.t),
      orderBy: orderBy?.call(SocietyEquipment.t),
      orderByList: orderByList?.call(SocietyEquipment.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SocietyEquipment] by its [id] or null if no such row exists.
  Future<SocietyEquipment?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SocietyEquipment>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SocietyEquipment]s in the list and returns the inserted rows.
  ///
  /// The returned [SocietyEquipment]s will have their `id` fields set.
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
  Future<List<SocietyEquipment>> insert(
    _is.DatabaseSession session,
    List<SocietyEquipment> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SocietyEquipment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SocietyEquipment] and returns the inserted row.
  ///
  /// The returned [SocietyEquipment] will have its `id` field set.
  Future<SocietyEquipment> insertRow(
    _is.DatabaseSession session,
    SocietyEquipment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SocietyEquipment>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SocietyEquipment]s in the list and returns the resulting rows.
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
  /// The returned [SocietyEquipment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SocietyEquipment>> upsert(
    _is.DatabaseSession session,
    List<SocietyEquipment> rows, {
    required _is.ColumnSelections<SocietyEquipmentTable> conflictColumns,
    _is.ColumnSelections<SocietyEquipmentTable>? updateColumns,
    _is.WhereExpressionBuilder<SocietyEquipmentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SocietyEquipment>(
      rows,
      conflictColumns: conflictColumns(SocietyEquipment.t),
      updateColumns: updateColumns?.call(SocietyEquipment.t),
      updateWhere: updateWhere?.call(SocietyEquipment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SocietyEquipment] and returns the resulting row.
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
  /// The returned [SocietyEquipment] will have its `id` field set.
  Future<SocietyEquipment?> upsertRow(
    _is.DatabaseSession session,
    SocietyEquipment row, {
    required _is.ColumnSelections<SocietyEquipmentTable> conflictColumns,
    _is.ColumnSelections<SocietyEquipmentTable>? updateColumns,
    _is.WhereExpressionBuilder<SocietyEquipmentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SocietyEquipment>(
      row,
      conflictColumns: conflictColumns(SocietyEquipment.t),
      updateColumns: updateColumns?.call(SocietyEquipment.t),
      updateWhere: updateWhere?.call(SocietyEquipment.t),
      transaction: transaction,
    );
  }

  /// Updates all [SocietyEquipment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SocietyEquipment>> update(
    _is.DatabaseSession session,
    List<SocietyEquipment> rows, {
    _is.ColumnSelections<SocietyEquipmentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SocietyEquipment>(
      rows,
      columns: columns?.call(SocietyEquipment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SocietyEquipment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SocietyEquipment> updateRow(
    _is.DatabaseSession session,
    SocietyEquipment row, {
    _is.ColumnSelections<SocietyEquipmentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SocietyEquipment>(
      row,
      columns: columns?.call(SocietyEquipment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SocietyEquipment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SocietyEquipment?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SocietyEquipmentUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SocietyEquipment>(
      id,
      columnValues: columnValues(SocietyEquipment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SocietyEquipment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SocietyEquipment>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SocietyEquipmentUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SocietyEquipmentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SocietyEquipmentTable>? orderBy,
    _is.OrderByListBuilder<SocietyEquipmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SocietyEquipment>(
      columnValues: columnValues(SocietyEquipment.t.updateTable),
      where: where(SocietyEquipment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SocietyEquipment.t),
      orderByList: orderByList?.call(SocietyEquipment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SocietyEquipment]s in the list and returns the deleted rows.
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
  Future<List<SocietyEquipment>> delete(
    _is.DatabaseSession session,
    List<SocietyEquipment> rows, {
    _is.OrderByBuilder<SocietyEquipmentTable>? orderBy,
    _is.OrderByListBuilder<SocietyEquipmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SocietyEquipment>(
      rows,
      orderBy: orderBy?.call(SocietyEquipment.t),
      orderByList: orderByList?.call(SocietyEquipment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SocietyEquipment].
  Future<SocietyEquipment> deleteRow(
    _is.DatabaseSession session,
    SocietyEquipment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SocietyEquipment>(
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
  Future<List<SocietyEquipment>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SocietyEquipmentTable> where,
    _is.OrderByBuilder<SocietyEquipmentTable>? orderBy,
    _is.OrderByListBuilder<SocietyEquipmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SocietyEquipment>(
      where: where(SocietyEquipment.t),
      orderBy: orderBy?.call(SocietyEquipment.t),
      orderByList: orderByList?.call(SocietyEquipment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SocietyEquipmentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SocietyEquipment>(
      where: where?.call(SocietyEquipment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SocietyEquipment] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SocietyEquipmentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SocietyEquipment>(
      where: where(SocietyEquipment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
