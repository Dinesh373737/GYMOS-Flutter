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

abstract class ExternalEventCache
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ExternalEventCache._({
    this.id,
    required this.provider,
    required this.providerEventId,
    required this.queryKey,
    required this.title,
    required this.category,
    required this.startsAt,
    this.endsAt,
    this.latitude,
    this.longitude,
    required this.venueLabel,
    this.organizerName,
    this.imageUrl,
    required this.sourceUrl,
    required this.rawHash,
    required this.fetchedAt,
    required this.expiresAt,
  });

  factory ExternalEventCache({
    int? id,
    required String provider,
    required String providerEventId,
    required String queryKey,
    required String title,
    required String category,
    required DateTime startsAt,
    DateTime? endsAt,
    double? latitude,
    double? longitude,
    required String venueLabel,
    String? organizerName,
    String? imageUrl,
    required String sourceUrl,
    required String rawHash,
    required DateTime fetchedAt,
    required DateTime expiresAt,
  }) = _ExternalEventCacheImpl;

  factory ExternalEventCache.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExternalEventCache(
      id: jsonSerialization['id'] as int?,
      provider: jsonSerialization['provider'] as String,
      providerEventId: jsonSerialization['providerEventId'] as String,
      queryKey: jsonSerialization['queryKey'] as String,
      title: jsonSerialization['title'] as String,
      category: jsonSerialization['category'] as String,
      startsAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: jsonSerialization['endsAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      latitude: (jsonSerialization['latitude'] as num?)?.toDouble(),
      longitude: (jsonSerialization['longitude'] as num?)?.toDouble(),
      venueLabel: jsonSerialization['venueLabel'] as String,
      organizerName: jsonSerialization['organizerName'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      sourceUrl: jsonSerialization['sourceUrl'] as String,
      rawHash: jsonSerialization['rawHash'] as String,
      fetchedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  static final t = ExternalEventCacheTable();

  static const db = ExternalEventCacheRepository._();

  @override
  int? id;

  String provider;

  String providerEventId;

  String queryKey;

  String title;

  String category;

  DateTime startsAt;

  DateTime? endsAt;

  double? latitude;

  double? longitude;

  String venueLabel;

  String? organizerName;

  String? imageUrl;

  String sourceUrl;

  String rawHash;

  DateTime fetchedAt;

  DateTime expiresAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ExternalEventCache]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ExternalEventCache copyWith({
    int? id,
    String? provider,
    String? providerEventId,
    String? queryKey,
    String? title,
    String? category,
    DateTime? startsAt,
    DateTime? endsAt,
    double? latitude,
    double? longitude,
    String? venueLabel,
    String? organizerName,
    String? imageUrl,
    String? sourceUrl,
    String? rawHash,
    DateTime? fetchedAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExternalEventCache',
      if (id != null) 'id': id,
      'provider': provider,
      'providerEventId': providerEventId,
      'queryKey': queryKey,
      'title': title,
      'category': category,
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      'venueLabel': venueLabel,
      if (organizerName != null) 'organizerName': organizerName,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'sourceUrl': sourceUrl,
      'rawHash': rawHash,
      'fetchedAt': fetchedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExternalEventCache',
      if (id != null) 'id': id,
      'provider': provider,
      'providerEventId': providerEventId,
      'queryKey': queryKey,
      'title': title,
      'category': category,
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      'venueLabel': venueLabel,
      if (organizerName != null) 'organizerName': organizerName,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'sourceUrl': sourceUrl,
      'rawHash': rawHash,
      'fetchedAt': fetchedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
    };
  }

  static ExternalEventCacheInclude include() {
    return ExternalEventCacheInclude._();
  }

  static ExternalEventCacheIncludeList includeList({
    _is.WhereExpressionBuilder<ExternalEventCacheTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExternalEventCacheTable>? orderBy,
    _is.OrderByListBuilder<ExternalEventCacheTable>? orderByList,
    ExternalEventCacheInclude? include,
  }) {
    return ExternalEventCacheIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExternalEventCache.t),
      orderByList: orderByList?.call(ExternalEventCache.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExternalEventCacheImpl extends ExternalEventCache {
  _ExternalEventCacheImpl({
    int? id,
    required String provider,
    required String providerEventId,
    required String queryKey,
    required String title,
    required String category,
    required DateTime startsAt,
    DateTime? endsAt,
    double? latitude,
    double? longitude,
    required String venueLabel,
    String? organizerName,
    String? imageUrl,
    required String sourceUrl,
    required String rawHash,
    required DateTime fetchedAt,
    required DateTime expiresAt,
  }) : super._(
         id: id,
         provider: provider,
         providerEventId: providerEventId,
         queryKey: queryKey,
         title: title,
         category: category,
         startsAt: startsAt,
         endsAt: endsAt,
         latitude: latitude,
         longitude: longitude,
         venueLabel: venueLabel,
         organizerName: organizerName,
         imageUrl: imageUrl,
         sourceUrl: sourceUrl,
         rawHash: rawHash,
         fetchedAt: fetchedAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [ExternalEventCache]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ExternalEventCache copyWith({
    Object? id = _Undefined,
    String? provider,
    String? providerEventId,
    String? queryKey,
    String? title,
    String? category,
    DateTime? startsAt,
    Object? endsAt = _Undefined,
    Object? latitude = _Undefined,
    Object? longitude = _Undefined,
    String? venueLabel,
    Object? organizerName = _Undefined,
    Object? imageUrl = _Undefined,
    String? sourceUrl,
    String? rawHash,
    DateTime? fetchedAt,
    DateTime? expiresAt,
  }) {
    return ExternalEventCache(
      id: id is int? ? id : this.id,
      provider: provider ?? this.provider,
      providerEventId: providerEventId ?? this.providerEventId,
      queryKey: queryKey ?? this.queryKey,
      title: title ?? this.title,
      category: category ?? this.category,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt is DateTime? ? endsAt : this.endsAt,
      latitude: latitude is double? ? latitude : this.latitude,
      longitude: longitude is double? ? longitude : this.longitude,
      venueLabel: venueLabel ?? this.venueLabel,
      organizerName: organizerName is String?
          ? organizerName
          : this.organizerName,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      rawHash: rawHash ?? this.rawHash,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

class ExternalEventCacheUpdateTable
    extends _is.UpdateTable<ExternalEventCacheTable> {
  ExternalEventCacheUpdateTable(super.table);

  _is.ColumnValue<String, String> provider(String value) => _is.ColumnValue(
    table.provider,
    value,
  );

  _is.ColumnValue<String, String> providerEventId(String value) =>
      _is.ColumnValue(
        table.providerEventId,
        value,
      );

  _is.ColumnValue<String, String> queryKey(String value) => _is.ColumnValue(
    table.queryKey,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
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

  _is.ColumnValue<DateTime, DateTime> endsAt(DateTime? value) =>
      _is.ColumnValue(
        table.endsAt,
        value,
      );

  _is.ColumnValue<double, double> latitude(double? value) => _is.ColumnValue(
    table.latitude,
    value,
  );

  _is.ColumnValue<double, double> longitude(double? value) => _is.ColumnValue(
    table.longitude,
    value,
  );

  _is.ColumnValue<String, String> venueLabel(String value) => _is.ColumnValue(
    table.venueLabel,
    value,
  );

  _is.ColumnValue<String, String> organizerName(String? value) =>
      _is.ColumnValue(
        table.organizerName,
        value,
      );

  _is.ColumnValue<String, String> imageUrl(String? value) => _is.ColumnValue(
    table.imageUrl,
    value,
  );

  _is.ColumnValue<String, String> sourceUrl(String value) => _is.ColumnValue(
    table.sourceUrl,
    value,
  );

  _is.ColumnValue<String, String> rawHash(String value) => _is.ColumnValue(
    table.rawHash,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> fetchedAt(DateTime value) =>
      _is.ColumnValue(
        table.fetchedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );
}

class ExternalEventCacheTable extends _is.Table<int?> {
  ExternalEventCacheTable({super.tableRelation})
    : super(tableName: 'external_event_cache') {
    updateTable = ExternalEventCacheUpdateTable(this);
    provider = _is.ColumnString(
      'provider',
      this,
    );
    providerEventId = _is.ColumnString(
      'providerEventId',
      this,
    );
    queryKey = _is.ColumnString(
      'queryKey',
      this,
    );
    title = _is.ColumnString(
      'title',
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
    organizerName = _is.ColumnString(
      'organizerName',
      this,
    );
    imageUrl = _is.ColumnString(
      'imageUrl',
      this,
    );
    sourceUrl = _is.ColumnString(
      'sourceUrl',
      this,
    );
    rawHash = _is.ColumnString(
      'rawHash',
      this,
    );
    fetchedAt = _is.ColumnDateTime(
      'fetchedAt',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final ExternalEventCacheUpdateTable updateTable;

  late final _is.ColumnString provider;

  late final _is.ColumnString providerEventId;

  late final _is.ColumnString queryKey;

  late final _is.ColumnString title;

  late final _is.ColumnString category;

  late final _is.ColumnDateTime startsAt;

  late final _is.ColumnDateTime endsAt;

  late final _is.ColumnDouble latitude;

  late final _is.ColumnDouble longitude;

  late final _is.ColumnString venueLabel;

  late final _is.ColumnString organizerName;

  late final _is.ColumnString imageUrl;

  late final _is.ColumnString sourceUrl;

  late final _is.ColumnString rawHash;

  late final _is.ColumnDateTime fetchedAt;

  late final _is.ColumnDateTime expiresAt;

  @override
  List<_is.Column> get columns => [
    id,
    provider,
    providerEventId,
    queryKey,
    title,
    category,
    startsAt,
    endsAt,
    latitude,
    longitude,
    venueLabel,
    organizerName,
    imageUrl,
    sourceUrl,
    rawHash,
    fetchedAt,
    expiresAt,
  ];
}

class ExternalEventCacheInclude extends _is.IncludeObject {
  ExternalEventCacheInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ExternalEventCache.t;
}

class ExternalEventCacheIncludeList extends _is.IncludeList {
  ExternalEventCacheIncludeList._({
    _is.WhereExpressionBuilder<ExternalEventCacheTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ExternalEventCache.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ExternalEventCache.t;
}

class ExternalEventCacheRepository {
  const ExternalEventCacheRepository._();

  /// Returns a list of [ExternalEventCache]s matching the given query parameters.
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
  Future<List<ExternalEventCache>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExternalEventCacheTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExternalEventCacheTable>? orderBy,
    _is.OrderByListBuilder<ExternalEventCacheTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ExternalEventCache>(
      where: where?.call(ExternalEventCache.t),
      orderBy: orderBy?.call(ExternalEventCache.t),
      orderByList: orderByList?.call(ExternalEventCache.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ExternalEventCache] matching the given query parameters.
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
  Future<ExternalEventCache?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExternalEventCacheTable>? where,
    int? offset,
    _is.OrderByBuilder<ExternalEventCacheTable>? orderBy,
    _is.OrderByListBuilder<ExternalEventCacheTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ExternalEventCache>(
      where: where?.call(ExternalEventCache.t),
      orderBy: orderBy?.call(ExternalEventCache.t),
      orderByList: orderByList?.call(ExternalEventCache.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ExternalEventCache] by its [id] or null if no such row exists.
  Future<ExternalEventCache?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ExternalEventCache>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ExternalEventCache]s in the list and returns the inserted rows.
  ///
  /// The returned [ExternalEventCache]s will have their `id` fields set.
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
  Future<List<ExternalEventCache>> insert(
    _is.DatabaseSession session,
    List<ExternalEventCache> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ExternalEventCache>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ExternalEventCache] and returns the inserted row.
  ///
  /// The returned [ExternalEventCache] will have its `id` field set.
  Future<ExternalEventCache> insertRow(
    _is.DatabaseSession session,
    ExternalEventCache row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ExternalEventCache>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ExternalEventCache]s in the list and returns the resulting rows.
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
  /// The returned [ExternalEventCache]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ExternalEventCache>> upsert(
    _is.DatabaseSession session,
    List<ExternalEventCache> rows, {
    required _is.ColumnSelections<ExternalEventCacheTable> conflictColumns,
    _is.ColumnSelections<ExternalEventCacheTable>? updateColumns,
    _is.WhereExpressionBuilder<ExternalEventCacheTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ExternalEventCache>(
      rows,
      conflictColumns: conflictColumns(ExternalEventCache.t),
      updateColumns: updateColumns?.call(ExternalEventCache.t),
      updateWhere: updateWhere?.call(ExternalEventCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ExternalEventCache] and returns the resulting row.
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
  /// The returned [ExternalEventCache] will have its `id` field set.
  Future<ExternalEventCache?> upsertRow(
    _is.DatabaseSession session,
    ExternalEventCache row, {
    required _is.ColumnSelections<ExternalEventCacheTable> conflictColumns,
    _is.ColumnSelections<ExternalEventCacheTable>? updateColumns,
    _is.WhereExpressionBuilder<ExternalEventCacheTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ExternalEventCache>(
      row,
      conflictColumns: conflictColumns(ExternalEventCache.t),
      updateColumns: updateColumns?.call(ExternalEventCache.t),
      updateWhere: updateWhere?.call(ExternalEventCache.t),
      transaction: transaction,
    );
  }

  /// Updates all [ExternalEventCache]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ExternalEventCache>> update(
    _is.DatabaseSession session,
    List<ExternalEventCache> rows, {
    _is.ColumnSelections<ExternalEventCacheTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ExternalEventCache>(
      rows,
      columns: columns?.call(ExternalEventCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ExternalEventCache]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ExternalEventCache> updateRow(
    _is.DatabaseSession session,
    ExternalEventCache row, {
    _is.ColumnSelections<ExternalEventCacheTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ExternalEventCache>(
      row,
      columns: columns?.call(ExternalEventCache.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExternalEventCache] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ExternalEventCache?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ExternalEventCacheUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ExternalEventCache>(
      id,
      columnValues: columnValues(ExternalEventCache.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ExternalEventCache]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ExternalEventCache>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ExternalEventCacheUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ExternalEventCacheTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExternalEventCacheTable>? orderBy,
    _is.OrderByListBuilder<ExternalEventCacheTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ExternalEventCache>(
      columnValues: columnValues(ExternalEventCache.t.updateTable),
      where: where(ExternalEventCache.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExternalEventCache.t),
      orderByList: orderByList?.call(ExternalEventCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ExternalEventCache]s in the list and returns the deleted rows.
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
  Future<List<ExternalEventCache>> delete(
    _is.DatabaseSession session,
    List<ExternalEventCache> rows, {
    _is.OrderByBuilder<ExternalEventCacheTable>? orderBy,
    _is.OrderByListBuilder<ExternalEventCacheTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ExternalEventCache>(
      rows,
      orderBy: orderBy?.call(ExternalEventCache.t),
      orderByList: orderByList?.call(ExternalEventCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ExternalEventCache].
  Future<ExternalEventCache> deleteRow(
    _is.DatabaseSession session,
    ExternalEventCache row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ExternalEventCache>(
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
  Future<List<ExternalEventCache>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ExternalEventCacheTable> where,
    _is.OrderByBuilder<ExternalEventCacheTable>? orderBy,
    _is.OrderByListBuilder<ExternalEventCacheTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ExternalEventCache>(
      where: where(ExternalEventCache.t),
      orderBy: orderBy?.call(ExternalEventCache.t),
      orderByList: orderByList?.call(ExternalEventCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExternalEventCacheTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ExternalEventCache>(
      where: where?.call(ExternalEventCache.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ExternalEventCache] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ExternalEventCacheTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ExternalEventCache>(
      where: where(ExternalEventCache.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
