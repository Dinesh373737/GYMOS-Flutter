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

abstract class ExerciseAlternative
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ExerciseAlternative._({
    this.id,
    required this.sourceExerciseId,
    required this.alternativeExerciseId,
    required this.similarityScore,
    required this.notes,
  });

  factory ExerciseAlternative({
    int? id,
    required int sourceExerciseId,
    required int alternativeExerciseId,
    required double similarityScore,
    required String notes,
  }) = _ExerciseAlternativeImpl;

  factory ExerciseAlternative.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseAlternative(
      id: jsonSerialization['id'] as int?,
      sourceExerciseId: jsonSerialization['sourceExerciseId'] as int,
      alternativeExerciseId: jsonSerialization['alternativeExerciseId'] as int,
      similarityScore: (jsonSerialization['similarityScore'] as num).toDouble(),
      notes: jsonSerialization['notes'] as String,
    );
  }

  static final t = ExerciseAlternativeTable();

  static const db = ExerciseAlternativeRepository._();

  @override
  int? id;

  int sourceExerciseId;

  int alternativeExerciseId;

  double similarityScore;

  String notes;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ExerciseAlternative]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ExerciseAlternative copyWith({
    int? id,
    int? sourceExerciseId,
    int? alternativeExerciseId,
    double? similarityScore,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseAlternative',
      if (id != null) 'id': id,
      'sourceExerciseId': sourceExerciseId,
      'alternativeExerciseId': alternativeExerciseId,
      'similarityScore': similarityScore,
      'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExerciseAlternative',
      if (id != null) 'id': id,
      'sourceExerciseId': sourceExerciseId,
      'alternativeExerciseId': alternativeExerciseId,
      'similarityScore': similarityScore,
      'notes': notes,
    };
  }

  static ExerciseAlternativeInclude include() {
    return ExerciseAlternativeInclude._();
  }

  static ExerciseAlternativeIncludeList includeList({
    _is.WhereExpressionBuilder<ExerciseAlternativeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExerciseAlternativeTable>? orderBy,
    _is.OrderByListBuilder<ExerciseAlternativeTable>? orderByList,
    ExerciseAlternativeInclude? include,
  }) {
    return ExerciseAlternativeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseAlternative.t),
      orderByList: orderByList?.call(ExerciseAlternative.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseAlternativeImpl extends ExerciseAlternative {
  _ExerciseAlternativeImpl({
    int? id,
    required int sourceExerciseId,
    required int alternativeExerciseId,
    required double similarityScore,
    required String notes,
  }) : super._(
         id: id,
         sourceExerciseId: sourceExerciseId,
         alternativeExerciseId: alternativeExerciseId,
         similarityScore: similarityScore,
         notes: notes,
       );

  /// Returns a shallow copy of this [ExerciseAlternative]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ExerciseAlternative copyWith({
    Object? id = _Undefined,
    int? sourceExerciseId,
    int? alternativeExerciseId,
    double? similarityScore,
    String? notes,
  }) {
    return ExerciseAlternative(
      id: id is int? ? id : this.id,
      sourceExerciseId: sourceExerciseId ?? this.sourceExerciseId,
      alternativeExerciseId:
          alternativeExerciseId ?? this.alternativeExerciseId,
      similarityScore: similarityScore ?? this.similarityScore,
      notes: notes ?? this.notes,
    );
  }
}

class ExerciseAlternativeUpdateTable
    extends _is.UpdateTable<ExerciseAlternativeTable> {
  ExerciseAlternativeUpdateTable(super.table);

  _is.ColumnValue<int, int> sourceExerciseId(int value) => _is.ColumnValue(
    table.sourceExerciseId,
    value,
  );

  _is.ColumnValue<int, int> alternativeExerciseId(int value) => _is.ColumnValue(
    table.alternativeExerciseId,
    value,
  );

  _is.ColumnValue<double, double> similarityScore(double value) =>
      _is.ColumnValue(
        table.similarityScore,
        value,
      );

  _is.ColumnValue<String, String> notes(String value) => _is.ColumnValue(
    table.notes,
    value,
  );
}

class ExerciseAlternativeTable extends _is.Table<int?> {
  ExerciseAlternativeTable({super.tableRelation})
    : super(tableName: 'exercise_alternative') {
    updateTable = ExerciseAlternativeUpdateTable(this);
    sourceExerciseId = _is.ColumnInt(
      'sourceExerciseId',
      this,
    );
    alternativeExerciseId = _is.ColumnInt(
      'alternativeExerciseId',
      this,
    );
    similarityScore = _is.ColumnDouble(
      'similarityScore',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
  }

  late final ExerciseAlternativeUpdateTable updateTable;

  late final _is.ColumnInt sourceExerciseId;

  late final _is.ColumnInt alternativeExerciseId;

  late final _is.ColumnDouble similarityScore;

  late final _is.ColumnString notes;

  @override
  List<_is.Column> get columns => [
    id,
    sourceExerciseId,
    alternativeExerciseId,
    similarityScore,
    notes,
  ];
}

class ExerciseAlternativeInclude extends _is.IncludeObject {
  ExerciseAlternativeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ExerciseAlternative.t;
}

class ExerciseAlternativeIncludeList extends _is.IncludeList {
  ExerciseAlternativeIncludeList._({
    _is.WhereExpressionBuilder<ExerciseAlternativeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ExerciseAlternative.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ExerciseAlternative.t;
}

class ExerciseAlternativeRepository {
  const ExerciseAlternativeRepository._();

  /// Returns a list of [ExerciseAlternative]s matching the given query parameters.
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
  Future<List<ExerciseAlternative>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExerciseAlternativeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExerciseAlternativeTable>? orderBy,
    _is.OrderByListBuilder<ExerciseAlternativeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ExerciseAlternative>(
      where: where?.call(ExerciseAlternative.t),
      orderBy: orderBy?.call(ExerciseAlternative.t),
      orderByList: orderByList?.call(ExerciseAlternative.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ExerciseAlternative] matching the given query parameters.
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
  Future<ExerciseAlternative?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExerciseAlternativeTable>? where,
    int? offset,
    _is.OrderByBuilder<ExerciseAlternativeTable>? orderBy,
    _is.OrderByListBuilder<ExerciseAlternativeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ExerciseAlternative>(
      where: where?.call(ExerciseAlternative.t),
      orderBy: orderBy?.call(ExerciseAlternative.t),
      orderByList: orderByList?.call(ExerciseAlternative.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ExerciseAlternative] by its [id] or null if no such row exists.
  Future<ExerciseAlternative?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ExerciseAlternative>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ExerciseAlternative]s in the list and returns the inserted rows.
  ///
  /// The returned [ExerciseAlternative]s will have their `id` fields set.
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
  Future<List<ExerciseAlternative>> insert(
    _is.DatabaseSession session,
    List<ExerciseAlternative> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ExerciseAlternative>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ExerciseAlternative] and returns the inserted row.
  ///
  /// The returned [ExerciseAlternative] will have its `id` field set.
  Future<ExerciseAlternative> insertRow(
    _is.DatabaseSession session,
    ExerciseAlternative row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ExerciseAlternative>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ExerciseAlternative]s in the list and returns the resulting rows.
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
  /// The returned [ExerciseAlternative]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ExerciseAlternative>> upsert(
    _is.DatabaseSession session,
    List<ExerciseAlternative> rows, {
    required _is.ColumnSelections<ExerciseAlternativeTable> conflictColumns,
    _is.ColumnSelections<ExerciseAlternativeTable>? updateColumns,
    _is.WhereExpressionBuilder<ExerciseAlternativeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ExerciseAlternative>(
      rows,
      conflictColumns: conflictColumns(ExerciseAlternative.t),
      updateColumns: updateColumns?.call(ExerciseAlternative.t),
      updateWhere: updateWhere?.call(ExerciseAlternative.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ExerciseAlternative] and returns the resulting row.
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
  /// The returned [ExerciseAlternative] will have its `id` field set.
  Future<ExerciseAlternative?> upsertRow(
    _is.DatabaseSession session,
    ExerciseAlternative row, {
    required _is.ColumnSelections<ExerciseAlternativeTable> conflictColumns,
    _is.ColumnSelections<ExerciseAlternativeTable>? updateColumns,
    _is.WhereExpressionBuilder<ExerciseAlternativeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ExerciseAlternative>(
      row,
      conflictColumns: conflictColumns(ExerciseAlternative.t),
      updateColumns: updateColumns?.call(ExerciseAlternative.t),
      updateWhere: updateWhere?.call(ExerciseAlternative.t),
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseAlternative]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ExerciseAlternative>> update(
    _is.DatabaseSession session,
    List<ExerciseAlternative> rows, {
    _is.ColumnSelections<ExerciseAlternativeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ExerciseAlternative>(
      rows,
      columns: columns?.call(ExerciseAlternative.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ExerciseAlternative]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ExerciseAlternative> updateRow(
    _is.DatabaseSession session,
    ExerciseAlternative row, {
    _is.ColumnSelections<ExerciseAlternativeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ExerciseAlternative>(
      row,
      columns: columns?.call(ExerciseAlternative.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExerciseAlternative] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ExerciseAlternative?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ExerciseAlternativeUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ExerciseAlternative>(
      id,
      columnValues: columnValues(ExerciseAlternative.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseAlternative]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ExerciseAlternative>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ExerciseAlternativeUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ExerciseAlternativeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExerciseAlternativeTable>? orderBy,
    _is.OrderByListBuilder<ExerciseAlternativeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ExerciseAlternative>(
      columnValues: columnValues(ExerciseAlternative.t.updateTable),
      where: where(ExerciseAlternative.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseAlternative.t),
      orderByList: orderByList?.call(ExerciseAlternative.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ExerciseAlternative]s in the list and returns the deleted rows.
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
  Future<List<ExerciseAlternative>> delete(
    _is.DatabaseSession session,
    List<ExerciseAlternative> rows, {
    _is.OrderByBuilder<ExerciseAlternativeTable>? orderBy,
    _is.OrderByListBuilder<ExerciseAlternativeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ExerciseAlternative>(
      rows,
      orderBy: orderBy?.call(ExerciseAlternative.t),
      orderByList: orderByList?.call(ExerciseAlternative.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ExerciseAlternative].
  Future<ExerciseAlternative> deleteRow(
    _is.DatabaseSession session,
    ExerciseAlternative row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ExerciseAlternative>(
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
  Future<List<ExerciseAlternative>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ExerciseAlternativeTable> where,
    _is.OrderByBuilder<ExerciseAlternativeTable>? orderBy,
    _is.OrderByListBuilder<ExerciseAlternativeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ExerciseAlternative>(
      where: where(ExerciseAlternative.t),
      orderBy: orderBy?.call(ExerciseAlternative.t),
      orderByList: orderByList?.call(ExerciseAlternative.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExerciseAlternativeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ExerciseAlternative>(
      where: where?.call(ExerciseAlternative.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ExerciseAlternative] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ExerciseAlternativeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ExerciseAlternative>(
      where: where(ExerciseAlternative.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
