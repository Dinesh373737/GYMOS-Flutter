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

abstract class FormMetric
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FormMetric._({
    this.id,
    required this.formAnalysisId,
    required this.metricName,
    required this.measuredValue,
    required this.unit,
    required this.targetRangeText,
    required this.status,
    required this.confidence,
    required this.cue,
  });

  factory FormMetric({
    int? id,
    required int formAnalysisId,
    required String metricName,
    required double measuredValue,
    required String unit,
    required String targetRangeText,
    required String status,
    required double confidence,
    required String cue,
  }) = _FormMetricImpl;

  factory FormMetric.fromJson(Map<String, dynamic> jsonSerialization) {
    return FormMetric(
      id: jsonSerialization['id'] as int?,
      formAnalysisId: jsonSerialization['formAnalysisId'] as int,
      metricName: jsonSerialization['metricName'] as String,
      measuredValue: (jsonSerialization['measuredValue'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
      targetRangeText: jsonSerialization['targetRangeText'] as String,
      status: jsonSerialization['status'] as String,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      cue: jsonSerialization['cue'] as String,
    );
  }

  static final t = FormMetricTable();

  static const db = FormMetricRepository._();

  @override
  int? id;

  int formAnalysisId;

  String metricName;

  double measuredValue;

  String unit;

  String targetRangeText;

  String status;

  double confidence;

  String cue;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FormMetric]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FormMetric copyWith({
    int? id,
    int? formAnalysisId,
    String? metricName,
    double? measuredValue,
    String? unit,
    String? targetRangeText,
    String? status,
    double? confidence,
    String? cue,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FormMetric',
      if (id != null) 'id': id,
      'formAnalysisId': formAnalysisId,
      'metricName': metricName,
      'measuredValue': measuredValue,
      'unit': unit,
      'targetRangeText': targetRangeText,
      'status': status,
      'confidence': confidence,
      'cue': cue,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FormMetric',
      if (id != null) 'id': id,
      'formAnalysisId': formAnalysisId,
      'metricName': metricName,
      'measuredValue': measuredValue,
      'unit': unit,
      'targetRangeText': targetRangeText,
      'status': status,
      'confidence': confidence,
      'cue': cue,
    };
  }

  static FormMetricInclude include() {
    return FormMetricInclude._();
  }

  static FormMetricIncludeList includeList({
    _is.WhereExpressionBuilder<FormMetricTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FormMetricTable>? orderBy,
    _is.OrderByListBuilder<FormMetricTable>? orderByList,
    FormMetricInclude? include,
  }) {
    return FormMetricIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FormMetric.t),
      orderByList: orderByList?.call(FormMetric.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FormMetricImpl extends FormMetric {
  _FormMetricImpl({
    int? id,
    required int formAnalysisId,
    required String metricName,
    required double measuredValue,
    required String unit,
    required String targetRangeText,
    required String status,
    required double confidence,
    required String cue,
  }) : super._(
         id: id,
         formAnalysisId: formAnalysisId,
         metricName: metricName,
         measuredValue: measuredValue,
         unit: unit,
         targetRangeText: targetRangeText,
         status: status,
         confidence: confidence,
         cue: cue,
       );

  /// Returns a shallow copy of this [FormMetric]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FormMetric copyWith({
    Object? id = _Undefined,
    int? formAnalysisId,
    String? metricName,
    double? measuredValue,
    String? unit,
    String? targetRangeText,
    String? status,
    double? confidence,
    String? cue,
  }) {
    return FormMetric(
      id: id is int? ? id : this.id,
      formAnalysisId: formAnalysisId ?? this.formAnalysisId,
      metricName: metricName ?? this.metricName,
      measuredValue: measuredValue ?? this.measuredValue,
      unit: unit ?? this.unit,
      targetRangeText: targetRangeText ?? this.targetRangeText,
      status: status ?? this.status,
      confidence: confidence ?? this.confidence,
      cue: cue ?? this.cue,
    );
  }
}

class FormMetricUpdateTable extends _is.UpdateTable<FormMetricTable> {
  FormMetricUpdateTable(super.table);

  _is.ColumnValue<int, int> formAnalysisId(int value) => _is.ColumnValue(
    table.formAnalysisId,
    value,
  );

  _is.ColumnValue<String, String> metricName(String value) => _is.ColumnValue(
    table.metricName,
    value,
  );

  _is.ColumnValue<double, double> measuredValue(double value) =>
      _is.ColumnValue(
        table.measuredValue,
        value,
      );

  _is.ColumnValue<String, String> unit(String value) => _is.ColumnValue(
    table.unit,
    value,
  );

  _is.ColumnValue<String, String> targetRangeText(String value) =>
      _is.ColumnValue(
        table.targetRangeText,
        value,
      );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<double, double> confidence(double value) => _is.ColumnValue(
    table.confidence,
    value,
  );

  _is.ColumnValue<String, String> cue(String value) => _is.ColumnValue(
    table.cue,
    value,
  );
}

class FormMetricTable extends _is.Table<int?> {
  FormMetricTable({super.tableRelation}) : super(tableName: 'form_metric') {
    updateTable = FormMetricUpdateTable(this);
    formAnalysisId = _is.ColumnInt(
      'formAnalysisId',
      this,
    );
    metricName = _is.ColumnString(
      'metricName',
      this,
    );
    measuredValue = _is.ColumnDouble(
      'measuredValue',
      this,
    );
    unit = _is.ColumnString(
      'unit',
      this,
    );
    targetRangeText = _is.ColumnString(
      'targetRangeText',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    confidence = _is.ColumnDouble(
      'confidence',
      this,
    );
    cue = _is.ColumnString(
      'cue',
      this,
    );
  }

  late final FormMetricUpdateTable updateTable;

  late final _is.ColumnInt formAnalysisId;

  late final _is.ColumnString metricName;

  late final _is.ColumnDouble measuredValue;

  late final _is.ColumnString unit;

  late final _is.ColumnString targetRangeText;

  late final _is.ColumnString status;

  late final _is.ColumnDouble confidence;

  late final _is.ColumnString cue;

  @override
  List<_is.Column> get columns => [
    id,
    formAnalysisId,
    metricName,
    measuredValue,
    unit,
    targetRangeText,
    status,
    confidence,
    cue,
  ];
}

class FormMetricInclude extends _is.IncludeObject {
  FormMetricInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FormMetric.t;
}

class FormMetricIncludeList extends _is.IncludeList {
  FormMetricIncludeList._({
    _is.WhereExpressionBuilder<FormMetricTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FormMetric.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FormMetric.t;
}

class FormMetricRepository {
  const FormMetricRepository._();

  /// Returns a list of [FormMetric]s matching the given query parameters.
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
  Future<List<FormMetric>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FormMetricTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FormMetricTable>? orderBy,
    _is.OrderByListBuilder<FormMetricTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FormMetric>(
      where: where?.call(FormMetric.t),
      orderBy: orderBy?.call(FormMetric.t),
      orderByList: orderByList?.call(FormMetric.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FormMetric] matching the given query parameters.
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
  Future<FormMetric?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FormMetricTable>? where,
    int? offset,
    _is.OrderByBuilder<FormMetricTable>? orderBy,
    _is.OrderByListBuilder<FormMetricTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FormMetric>(
      where: where?.call(FormMetric.t),
      orderBy: orderBy?.call(FormMetric.t),
      orderByList: orderByList?.call(FormMetric.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FormMetric] by its [id] or null if no such row exists.
  Future<FormMetric?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FormMetric>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FormMetric]s in the list and returns the inserted rows.
  ///
  /// The returned [FormMetric]s will have their `id` fields set.
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
  Future<List<FormMetric>> insert(
    _is.DatabaseSession session,
    List<FormMetric> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FormMetric>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FormMetric] and returns the inserted row.
  ///
  /// The returned [FormMetric] will have its `id` field set.
  Future<FormMetric> insertRow(
    _is.DatabaseSession session,
    FormMetric row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FormMetric>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FormMetric]s in the list and returns the resulting rows.
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
  /// The returned [FormMetric]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FormMetric>> upsert(
    _is.DatabaseSession session,
    List<FormMetric> rows, {
    required _is.ColumnSelections<FormMetricTable> conflictColumns,
    _is.ColumnSelections<FormMetricTable>? updateColumns,
    _is.WhereExpressionBuilder<FormMetricTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FormMetric>(
      rows,
      conflictColumns: conflictColumns(FormMetric.t),
      updateColumns: updateColumns?.call(FormMetric.t),
      updateWhere: updateWhere?.call(FormMetric.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FormMetric] and returns the resulting row.
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
  /// The returned [FormMetric] will have its `id` field set.
  Future<FormMetric?> upsertRow(
    _is.DatabaseSession session,
    FormMetric row, {
    required _is.ColumnSelections<FormMetricTable> conflictColumns,
    _is.ColumnSelections<FormMetricTable>? updateColumns,
    _is.WhereExpressionBuilder<FormMetricTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FormMetric>(
      row,
      conflictColumns: conflictColumns(FormMetric.t),
      updateColumns: updateColumns?.call(FormMetric.t),
      updateWhere: updateWhere?.call(FormMetric.t),
      transaction: transaction,
    );
  }

  /// Updates all [FormMetric]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FormMetric>> update(
    _is.DatabaseSession session,
    List<FormMetric> rows, {
    _is.ColumnSelections<FormMetricTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FormMetric>(
      rows,
      columns: columns?.call(FormMetric.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FormMetric]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FormMetric> updateRow(
    _is.DatabaseSession session,
    FormMetric row, {
    _is.ColumnSelections<FormMetricTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FormMetric>(
      row,
      columns: columns?.call(FormMetric.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FormMetric] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FormMetric?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FormMetricUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FormMetric>(
      id,
      columnValues: columnValues(FormMetric.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FormMetric]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FormMetric>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FormMetricUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FormMetricTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FormMetricTable>? orderBy,
    _is.OrderByListBuilder<FormMetricTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FormMetric>(
      columnValues: columnValues(FormMetric.t.updateTable),
      where: where(FormMetric.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FormMetric.t),
      orderByList: orderByList?.call(FormMetric.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FormMetric]s in the list and returns the deleted rows.
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
  Future<List<FormMetric>> delete(
    _is.DatabaseSession session,
    List<FormMetric> rows, {
    _is.OrderByBuilder<FormMetricTable>? orderBy,
    _is.OrderByListBuilder<FormMetricTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FormMetric>(
      rows,
      orderBy: orderBy?.call(FormMetric.t),
      orderByList: orderByList?.call(FormMetric.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FormMetric].
  Future<FormMetric> deleteRow(
    _is.DatabaseSession session,
    FormMetric row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FormMetric>(
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
  Future<List<FormMetric>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FormMetricTable> where,
    _is.OrderByBuilder<FormMetricTable>? orderBy,
    _is.OrderByListBuilder<FormMetricTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FormMetric>(
      where: where(FormMetric.t),
      orderBy: orderBy?.call(FormMetric.t),
      orderByList: orderByList?.call(FormMetric.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FormMetricTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FormMetric>(
      where: where?.call(FormMetric.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FormMetric] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FormMetricTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FormMetric>(
      where: where(FormMetric.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
