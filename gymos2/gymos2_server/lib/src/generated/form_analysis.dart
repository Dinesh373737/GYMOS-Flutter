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

abstract class FormAnalysis
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FormAnalysis._({
    this.id,
    required this.userId,
    required this.exerciseId,
    required this.checkpoint,
    required this.capturedAt,
    required this.analysisType,
    required this.resultBand,
    required this.confidence,
    required this.summary,
    this.retainedImagePath,
  });

  factory FormAnalysis({
    int? id,
    required int userId,
    required int exerciseId,
    required String checkpoint,
    required DateTime capturedAt,
    required String analysisType,
    required String resultBand,
    required double confidence,
    required String summary,
    String? retainedImagePath,
  }) = _FormAnalysisImpl;

  factory FormAnalysis.fromJson(Map<String, dynamic> jsonSerialization) {
    return FormAnalysis(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      exerciseId: jsonSerialization['exerciseId'] as int,
      checkpoint: jsonSerialization['checkpoint'] as String,
      capturedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['capturedAt'],
      ),
      analysisType: jsonSerialization['analysisType'] as String,
      resultBand: jsonSerialization['resultBand'] as String,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      summary: jsonSerialization['summary'] as String,
      retainedImagePath: jsonSerialization['retainedImagePath'] as String?,
    );
  }

  static final t = FormAnalysisTable();

  static const db = FormAnalysisRepository._();

  @override
  int? id;

  int userId;

  int exerciseId;

  String checkpoint;

  DateTime capturedAt;

  String analysisType;

  String resultBand;

  double confidence;

  String summary;

  String? retainedImagePath;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FormAnalysis]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FormAnalysis copyWith({
    int? id,
    int? userId,
    int? exerciseId,
    String? checkpoint,
    DateTime? capturedAt,
    String? analysisType,
    String? resultBand,
    double? confidence,
    String? summary,
    String? retainedImagePath,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FormAnalysis',
      if (id != null) 'id': id,
      'userId': userId,
      'exerciseId': exerciseId,
      'checkpoint': checkpoint,
      'capturedAt': capturedAt.toJson(),
      'analysisType': analysisType,
      'resultBand': resultBand,
      'confidence': confidence,
      'summary': summary,
      if (retainedImagePath != null) 'retainedImagePath': retainedImagePath,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FormAnalysis',
      if (id != null) 'id': id,
      'userId': userId,
      'exerciseId': exerciseId,
      'checkpoint': checkpoint,
      'capturedAt': capturedAt.toJson(),
      'analysisType': analysisType,
      'resultBand': resultBand,
      'confidence': confidence,
      'summary': summary,
      if (retainedImagePath != null) 'retainedImagePath': retainedImagePath,
    };
  }

  static FormAnalysisInclude include() {
    return FormAnalysisInclude._();
  }

  static FormAnalysisIncludeList includeList({
    _is.WhereExpressionBuilder<FormAnalysisTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FormAnalysisTable>? orderBy,
    _is.OrderByListBuilder<FormAnalysisTable>? orderByList,
    FormAnalysisInclude? include,
  }) {
    return FormAnalysisIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FormAnalysis.t),
      orderByList: orderByList?.call(FormAnalysis.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FormAnalysisImpl extends FormAnalysis {
  _FormAnalysisImpl({
    int? id,
    required int userId,
    required int exerciseId,
    required String checkpoint,
    required DateTime capturedAt,
    required String analysisType,
    required String resultBand,
    required double confidence,
    required String summary,
    String? retainedImagePath,
  }) : super._(
         id: id,
         userId: userId,
         exerciseId: exerciseId,
         checkpoint: checkpoint,
         capturedAt: capturedAt,
         analysisType: analysisType,
         resultBand: resultBand,
         confidence: confidence,
         summary: summary,
         retainedImagePath: retainedImagePath,
       );

  /// Returns a shallow copy of this [FormAnalysis]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FormAnalysis copyWith({
    Object? id = _Undefined,
    int? userId,
    int? exerciseId,
    String? checkpoint,
    DateTime? capturedAt,
    String? analysisType,
    String? resultBand,
    double? confidence,
    String? summary,
    Object? retainedImagePath = _Undefined,
  }) {
    return FormAnalysis(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      exerciseId: exerciseId ?? this.exerciseId,
      checkpoint: checkpoint ?? this.checkpoint,
      capturedAt: capturedAt ?? this.capturedAt,
      analysisType: analysisType ?? this.analysisType,
      resultBand: resultBand ?? this.resultBand,
      confidence: confidence ?? this.confidence,
      summary: summary ?? this.summary,
      retainedImagePath: retainedImagePath is String?
          ? retainedImagePath
          : this.retainedImagePath,
    );
  }
}

class FormAnalysisUpdateTable extends _is.UpdateTable<FormAnalysisTable> {
  FormAnalysisUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> exerciseId(int value) => _is.ColumnValue(
    table.exerciseId,
    value,
  );

  _is.ColumnValue<String, String> checkpoint(String value) => _is.ColumnValue(
    table.checkpoint,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> capturedAt(DateTime value) =>
      _is.ColumnValue(
        table.capturedAt,
        value,
      );

  _is.ColumnValue<String, String> analysisType(String value) => _is.ColumnValue(
    table.analysisType,
    value,
  );

  _is.ColumnValue<String, String> resultBand(String value) => _is.ColumnValue(
    table.resultBand,
    value,
  );

  _is.ColumnValue<double, double> confidence(double value) => _is.ColumnValue(
    table.confidence,
    value,
  );

  _is.ColumnValue<String, String> summary(String value) => _is.ColumnValue(
    table.summary,
    value,
  );

  _is.ColumnValue<String, String> retainedImagePath(String? value) =>
      _is.ColumnValue(
        table.retainedImagePath,
        value,
      );
}

class FormAnalysisTable extends _is.Table<int?> {
  FormAnalysisTable({super.tableRelation}) : super(tableName: 'form_analysis') {
    updateTable = FormAnalysisUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    exerciseId = _is.ColumnInt(
      'exerciseId',
      this,
    );
    checkpoint = _is.ColumnString(
      'checkpoint',
      this,
    );
    capturedAt = _is.ColumnDateTime(
      'capturedAt',
      this,
    );
    analysisType = _is.ColumnString(
      'analysisType',
      this,
    );
    resultBand = _is.ColumnString(
      'resultBand',
      this,
    );
    confidence = _is.ColumnDouble(
      'confidence',
      this,
    );
    summary = _is.ColumnString(
      'summary',
      this,
    );
    retainedImagePath = _is.ColumnString(
      'retainedImagePath',
      this,
    );
  }

  late final FormAnalysisUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt exerciseId;

  late final _is.ColumnString checkpoint;

  late final _is.ColumnDateTime capturedAt;

  late final _is.ColumnString analysisType;

  late final _is.ColumnString resultBand;

  late final _is.ColumnDouble confidence;

  late final _is.ColumnString summary;

  late final _is.ColumnString retainedImagePath;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    exerciseId,
    checkpoint,
    capturedAt,
    analysisType,
    resultBand,
    confidence,
    summary,
    retainedImagePath,
  ];
}

class FormAnalysisInclude extends _is.IncludeObject {
  FormAnalysisInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FormAnalysis.t;
}

class FormAnalysisIncludeList extends _is.IncludeList {
  FormAnalysisIncludeList._({
    _is.WhereExpressionBuilder<FormAnalysisTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FormAnalysis.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FormAnalysis.t;
}

class FormAnalysisRepository {
  const FormAnalysisRepository._();

  /// Returns a list of [FormAnalysis]s matching the given query parameters.
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
  Future<List<FormAnalysis>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FormAnalysisTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FormAnalysisTable>? orderBy,
    _is.OrderByListBuilder<FormAnalysisTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FormAnalysis>(
      where: where?.call(FormAnalysis.t),
      orderBy: orderBy?.call(FormAnalysis.t),
      orderByList: orderByList?.call(FormAnalysis.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FormAnalysis] matching the given query parameters.
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
  Future<FormAnalysis?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FormAnalysisTable>? where,
    int? offset,
    _is.OrderByBuilder<FormAnalysisTable>? orderBy,
    _is.OrderByListBuilder<FormAnalysisTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FormAnalysis>(
      where: where?.call(FormAnalysis.t),
      orderBy: orderBy?.call(FormAnalysis.t),
      orderByList: orderByList?.call(FormAnalysis.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FormAnalysis] by its [id] or null if no such row exists.
  Future<FormAnalysis?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FormAnalysis>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FormAnalysis]s in the list and returns the inserted rows.
  ///
  /// The returned [FormAnalysis]s will have their `id` fields set.
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
  Future<List<FormAnalysis>> insert(
    _is.DatabaseSession session,
    List<FormAnalysis> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FormAnalysis>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FormAnalysis] and returns the inserted row.
  ///
  /// The returned [FormAnalysis] will have its `id` field set.
  Future<FormAnalysis> insertRow(
    _is.DatabaseSession session,
    FormAnalysis row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FormAnalysis>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FormAnalysis]s in the list and returns the resulting rows.
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
  /// The returned [FormAnalysis]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FormAnalysis>> upsert(
    _is.DatabaseSession session,
    List<FormAnalysis> rows, {
    required _is.ColumnSelections<FormAnalysisTable> conflictColumns,
    _is.ColumnSelections<FormAnalysisTable>? updateColumns,
    _is.WhereExpressionBuilder<FormAnalysisTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FormAnalysis>(
      rows,
      conflictColumns: conflictColumns(FormAnalysis.t),
      updateColumns: updateColumns?.call(FormAnalysis.t),
      updateWhere: updateWhere?.call(FormAnalysis.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FormAnalysis] and returns the resulting row.
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
  /// The returned [FormAnalysis] will have its `id` field set.
  Future<FormAnalysis?> upsertRow(
    _is.DatabaseSession session,
    FormAnalysis row, {
    required _is.ColumnSelections<FormAnalysisTable> conflictColumns,
    _is.ColumnSelections<FormAnalysisTable>? updateColumns,
    _is.WhereExpressionBuilder<FormAnalysisTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FormAnalysis>(
      row,
      conflictColumns: conflictColumns(FormAnalysis.t),
      updateColumns: updateColumns?.call(FormAnalysis.t),
      updateWhere: updateWhere?.call(FormAnalysis.t),
      transaction: transaction,
    );
  }

  /// Updates all [FormAnalysis]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FormAnalysis>> update(
    _is.DatabaseSession session,
    List<FormAnalysis> rows, {
    _is.ColumnSelections<FormAnalysisTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FormAnalysis>(
      rows,
      columns: columns?.call(FormAnalysis.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FormAnalysis]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FormAnalysis> updateRow(
    _is.DatabaseSession session,
    FormAnalysis row, {
    _is.ColumnSelections<FormAnalysisTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FormAnalysis>(
      row,
      columns: columns?.call(FormAnalysis.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FormAnalysis] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FormAnalysis?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FormAnalysisUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FormAnalysis>(
      id,
      columnValues: columnValues(FormAnalysis.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FormAnalysis]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FormAnalysis>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FormAnalysisUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FormAnalysisTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FormAnalysisTable>? orderBy,
    _is.OrderByListBuilder<FormAnalysisTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FormAnalysis>(
      columnValues: columnValues(FormAnalysis.t.updateTable),
      where: where(FormAnalysis.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FormAnalysis.t),
      orderByList: orderByList?.call(FormAnalysis.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FormAnalysis]s in the list and returns the deleted rows.
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
  Future<List<FormAnalysis>> delete(
    _is.DatabaseSession session,
    List<FormAnalysis> rows, {
    _is.OrderByBuilder<FormAnalysisTable>? orderBy,
    _is.OrderByListBuilder<FormAnalysisTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FormAnalysis>(
      rows,
      orderBy: orderBy?.call(FormAnalysis.t),
      orderByList: orderByList?.call(FormAnalysis.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FormAnalysis].
  Future<FormAnalysis> deleteRow(
    _is.DatabaseSession session,
    FormAnalysis row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FormAnalysis>(
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
  Future<List<FormAnalysis>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FormAnalysisTable> where,
    _is.OrderByBuilder<FormAnalysisTable>? orderBy,
    _is.OrderByListBuilder<FormAnalysisTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FormAnalysis>(
      where: where(FormAnalysis.t),
      orderBy: orderBy?.call(FormAnalysis.t),
      orderByList: orderByList?.call(FormAnalysis.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FormAnalysisTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FormAnalysis>(
      where: where?.call(FormAnalysis.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FormAnalysis] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FormAnalysisTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FormAnalysis>(
      where: where(FormAnalysis.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
