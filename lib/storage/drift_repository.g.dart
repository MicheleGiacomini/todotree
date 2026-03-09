// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_repository.dart';

// ignore_for_file: type=lint
class $NodesTable extends Nodes with TableInfo<$NodesTable, DbNode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nodeIndexMeta = const VerificationMeta(
    'nodeIndex',
  );
  @override
  late final GeneratedColumn<int> nodeIndex = GeneratedColumn<int>(
    'node_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    parentId,
    nodeIndex,
    description,
    details,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nodes';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbNode> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('node_index')) {
      context.handle(
        _nodeIndexMeta,
        nodeIndex.isAcceptableOrUnknown(data['node_index']!, _nodeIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_nodeIndexMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    } else if (isInserting) {
      context.missing(_detailsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbNode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbNode(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      nodeIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}node_index'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      )!,
    );
  }

  @override
  $NodesTable createAlias(String alias) {
    return $NodesTable(attachedDatabase, alias);
  }
}

class DbNode extends DataClass implements Insertable<DbNode> {
  final String id;
  final String? parentId;
  final int nodeIndex;
  final String description;
  final String details;
  const DbNode({
    required this.id,
    this.parentId,
    required this.nodeIndex,
    required this.description,
    required this.details,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['node_index'] = Variable<int>(nodeIndex);
    map['description'] = Variable<String>(description);
    map['details'] = Variable<String>(details);
    return map;
  }

  NodesCompanion toCompanion(bool nullToAbsent) {
    return NodesCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      nodeIndex: Value(nodeIndex),
      description: Value(description),
      details: Value(details),
    );
  }

  factory DbNode.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbNode(
      id: serializer.fromJson<String>(json['id']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      nodeIndex: serializer.fromJson<int>(json['nodeIndex']),
      description: serializer.fromJson<String>(json['description']),
      details: serializer.fromJson<String>(json['details']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'parentId': serializer.toJson<String?>(parentId),
      'nodeIndex': serializer.toJson<int>(nodeIndex),
      'description': serializer.toJson<String>(description),
      'details': serializer.toJson<String>(details),
    };
  }

  DbNode copyWith({
    String? id,
    Value<String?> parentId = const Value.absent(),
    int? nodeIndex,
    String? description,
    String? details,
  }) => DbNode(
    id: id ?? this.id,
    parentId: parentId.present ? parentId.value : this.parentId,
    nodeIndex: nodeIndex ?? this.nodeIndex,
    description: description ?? this.description,
    details: details ?? this.details,
  );
  DbNode copyWithCompanion(NodesCompanion data) {
    return DbNode(
      id: data.id.present ? data.id.value : this.id,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      nodeIndex: data.nodeIndex.present ? data.nodeIndex.value : this.nodeIndex,
      description: data.description.present
          ? data.description.value
          : this.description,
      details: data.details.present ? data.details.value : this.details,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbNode(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('nodeIndex: $nodeIndex, ')
          ..write('description: $description, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, parentId, nodeIndex, description, details);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbNode &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.nodeIndex == this.nodeIndex &&
          other.description == this.description &&
          other.details == this.details);
}

class NodesCompanion extends UpdateCompanion<DbNode> {
  final Value<String> id;
  final Value<String?> parentId;
  final Value<int> nodeIndex;
  final Value<String> description;
  final Value<String> details;
  final Value<int> rowid;
  const NodesCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.nodeIndex = const Value.absent(),
    this.description = const Value.absent(),
    this.details = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NodesCompanion.insert({
    required String id,
    this.parentId = const Value.absent(),
    required int nodeIndex,
    required String description,
    required String details,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nodeIndex = Value(nodeIndex),
       description = Value(description),
       details = Value(details);
  static Insertable<DbNode> custom({
    Expression<String>? id,
    Expression<String>? parentId,
    Expression<int>? nodeIndex,
    Expression<String>? description,
    Expression<String>? details,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (nodeIndex != null) 'node_index': nodeIndex,
      if (description != null) 'description': description,
      if (details != null) 'details': details,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NodesCompanion copyWith({
    Value<String>? id,
    Value<String?>? parentId,
    Value<int>? nodeIndex,
    Value<String>? description,
    Value<String>? details,
    Value<int>? rowid,
  }) {
    return NodesCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      nodeIndex: nodeIndex ?? this.nodeIndex,
      description: description ?? this.description,
      details: details ?? this.details,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (nodeIndex.present) {
      map['node_index'] = Variable<int>(nodeIndex.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NodesCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('nodeIndex: $nodeIndex, ')
          ..write('description: $description, ')
          ..write('details: $details, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NodeTagsTable extends NodeTags with TableInfo<$NodeTagsTable, NodeTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NodeTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  @override
  late final GeneratedColumn<String> nodeId = GeneratedColumn<String>(
    'node_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nodes (id)',
    ),
  );
  static const VerificationMeta _tagNameMeta = const VerificationMeta(
    'tagName',
  );
  @override
  late final GeneratedColumn<String> tagName = GeneratedColumn<String>(
    'tag_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [nodeId, tagName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'node_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<NodeTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('node_id')) {
      context.handle(
        _nodeIdMeta,
        nodeId.isAcceptableOrUnknown(data['node_id']!, _nodeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_nodeIdMeta);
    }
    if (data.containsKey('tag_name')) {
      context.handle(
        _tagNameMeta,
        tagName.isAcceptableOrUnknown(data['tag_name']!, _tagNameMeta),
      );
    } else if (isInserting) {
      context.missing(_tagNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {nodeId, tagName};
  @override
  NodeTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NodeTag(
      nodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}node_id'],
      )!,
      tagName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_name'],
      )!,
    );
  }

  @override
  $NodeTagsTable createAlias(String alias) {
    return $NodeTagsTable(attachedDatabase, alias);
  }
}

class NodeTag extends DataClass implements Insertable<NodeTag> {
  final String nodeId;
  final String tagName;
  const NodeTag({required this.nodeId, required this.tagName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['node_id'] = Variable<String>(nodeId);
    map['tag_name'] = Variable<String>(tagName);
    return map;
  }

  NodeTagsCompanion toCompanion(bool nullToAbsent) {
    return NodeTagsCompanion(nodeId: Value(nodeId), tagName: Value(tagName));
  }

  factory NodeTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NodeTag(
      nodeId: serializer.fromJson<String>(json['nodeId']),
      tagName: serializer.fromJson<String>(json['tagName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'nodeId': serializer.toJson<String>(nodeId),
      'tagName': serializer.toJson<String>(tagName),
    };
  }

  NodeTag copyWith({String? nodeId, String? tagName}) =>
      NodeTag(nodeId: nodeId ?? this.nodeId, tagName: tagName ?? this.tagName);
  NodeTag copyWithCompanion(NodeTagsCompanion data) {
    return NodeTag(
      nodeId: data.nodeId.present ? data.nodeId.value : this.nodeId,
      tagName: data.tagName.present ? data.tagName.value : this.tagName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NodeTag(')
          ..write('nodeId: $nodeId, ')
          ..write('tagName: $tagName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(nodeId, tagName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NodeTag &&
          other.nodeId == this.nodeId &&
          other.tagName == this.tagName);
}

class NodeTagsCompanion extends UpdateCompanion<NodeTag> {
  final Value<String> nodeId;
  final Value<String> tagName;
  final Value<int> rowid;
  const NodeTagsCompanion({
    this.nodeId = const Value.absent(),
    this.tagName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NodeTagsCompanion.insert({
    required String nodeId,
    required String tagName,
    this.rowid = const Value.absent(),
  }) : nodeId = Value(nodeId),
       tagName = Value(tagName);
  static Insertable<NodeTag> custom({
    Expression<String>? nodeId,
    Expression<String>? tagName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (nodeId != null) 'node_id': nodeId,
      if (tagName != null) 'tag_name': tagName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NodeTagsCompanion copyWith({
    Value<String>? nodeId,
    Value<String>? tagName,
    Value<int>? rowid,
  }) {
    return NodeTagsCompanion(
      nodeId: nodeId ?? this.nodeId,
      tagName: tagName ?? this.tagName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (nodeId.present) {
      map['node_id'] = Variable<String>(nodeId.value);
    }
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NodeTagsCompanion(')
          ..write('nodeId: $nodeId, ')
          ..write('tagName: $tagName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NodeChildrenTable extends NodeChildren
    with TableInfo<$NodeChildrenTable, NodeChildrenData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NodeChildrenTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nodes (id)',
    ),
  );
  static const VerificationMeta _childIdMeta = const VerificationMeta(
    'childId',
  );
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
    'child_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nodes (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [parentId, childId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'node_children';
  @override
  VerificationContext validateIntegrity(
    Insertable<NodeChildrenData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_parentIdMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(
        _childIdMeta,
        childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta),
      );
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {parentId, childId};
  @override
  NodeChildrenData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NodeChildrenData(
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      )!,
      childId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}child_id'],
      )!,
    );
  }

  @override
  $NodeChildrenTable createAlias(String alias) {
    return $NodeChildrenTable(attachedDatabase, alias);
  }
}

class NodeChildrenData extends DataClass
    implements Insertable<NodeChildrenData> {
  final String parentId;
  final String childId;
  const NodeChildrenData({required this.parentId, required this.childId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['parent_id'] = Variable<String>(parentId);
    map['child_id'] = Variable<String>(childId);
    return map;
  }

  NodeChildrenCompanion toCompanion(bool nullToAbsent) {
    return NodeChildrenCompanion(
      parentId: Value(parentId),
      childId: Value(childId),
    );
  }

  factory NodeChildrenData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NodeChildrenData(
      parentId: serializer.fromJson<String>(json['parentId']),
      childId: serializer.fromJson<String>(json['childId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'parentId': serializer.toJson<String>(parentId),
      'childId': serializer.toJson<String>(childId),
    };
  }

  NodeChildrenData copyWith({String? parentId, String? childId}) =>
      NodeChildrenData(
        parentId: parentId ?? this.parentId,
        childId: childId ?? this.childId,
      );
  NodeChildrenData copyWithCompanion(NodeChildrenCompanion data) {
    return NodeChildrenData(
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      childId: data.childId.present ? data.childId.value : this.childId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NodeChildrenData(')
          ..write('parentId: $parentId, ')
          ..write('childId: $childId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(parentId, childId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NodeChildrenData &&
          other.parentId == this.parentId &&
          other.childId == this.childId);
}

class NodeChildrenCompanion extends UpdateCompanion<NodeChildrenData> {
  final Value<String> parentId;
  final Value<String> childId;
  final Value<int> rowid;
  const NodeChildrenCompanion({
    this.parentId = const Value.absent(),
    this.childId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NodeChildrenCompanion.insert({
    required String parentId,
    required String childId,
    this.rowid = const Value.absent(),
  }) : parentId = Value(parentId),
       childId = Value(childId);
  static Insertable<NodeChildrenData> custom({
    Expression<String>? parentId,
    Expression<String>? childId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (parentId != null) 'parent_id': parentId,
      if (childId != null) 'child_id': childId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NodeChildrenCompanion copyWith({
    Value<String>? parentId,
    Value<String>? childId,
    Value<int>? rowid,
  }) {
    return NodeChildrenCompanion(
      parentId: parentId ?? this.parentId,
      childId: childId ?? this.childId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NodeChildrenCompanion(')
          ..write('parentId: $parentId, ')
          ..write('childId: $childId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NodesTable nodes = $NodesTable(this);
  late final $NodeTagsTable nodeTags = $NodeTagsTable(this);
  late final $NodeChildrenTable nodeChildren = $NodeChildrenTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    nodes,
    nodeTags,
    nodeChildren,
  ];
}

typedef $$NodesTableCreateCompanionBuilder =
    NodesCompanion Function({
      required String id,
      Value<String?> parentId,
      required int nodeIndex,
      required String description,
      required String details,
      Value<int> rowid,
    });
typedef $$NodesTableUpdateCompanionBuilder =
    NodesCompanion Function({
      Value<String> id,
      Value<String?> parentId,
      Value<int> nodeIndex,
      Value<String> description,
      Value<String> details,
      Value<int> rowid,
    });

final class $$NodesTableReferences
    extends BaseReferences<_$AppDatabase, $NodesTable, DbNode> {
  $$NodesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$NodeTagsTable, List<NodeTag>> _nodeTagsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.nodeTags,
    aliasName: $_aliasNameGenerator(db.nodes.id, db.nodeTags.nodeId),
  );

  $$NodeTagsTableProcessedTableManager get nodeTagsRefs {
    final manager = $$NodeTagsTableTableManager(
      $_db,
      $_db.nodeTags,
    ).filter((f) => f.nodeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_nodeTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NodesTableFilterComposer extends Composer<_$AppDatabase, $NodesTable> {
  $$NodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nodeIndex => $composableBuilder(
    column: $table.nodeIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> nodeTagsRefs(
    Expression<bool> Function($$NodeTagsTableFilterComposer f) f,
  ) {
    final $$NodeTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.nodeTags,
      getReferencedColumn: (t) => t.nodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodeTagsTableFilterComposer(
            $db: $db,
            $table: $db.nodeTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NodesTableOrderingComposer
    extends Composer<_$AppDatabase, $NodesTable> {
  $$NodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nodeIndex => $composableBuilder(
    column: $table.nodeIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NodesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NodesTable> {
  $$NodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<int> get nodeIndex =>
      $composableBuilder(column: $table.nodeIndex, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  Expression<T> nodeTagsRefs<T extends Object>(
    Expression<T> Function($$NodeTagsTableAnnotationComposer a) f,
  ) {
    final $$NodeTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.nodeTags,
      getReferencedColumn: (t) => t.nodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodeTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.nodeTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NodesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NodesTable,
          DbNode,
          $$NodesTableFilterComposer,
          $$NodesTableOrderingComposer,
          $$NodesTableAnnotationComposer,
          $$NodesTableCreateCompanionBuilder,
          $$NodesTableUpdateCompanionBuilder,
          (DbNode, $$NodesTableReferences),
          DbNode,
          PrefetchHooks Function({bool nodeTagsRefs})
        > {
  $$NodesTableTableManager(_$AppDatabase db, $NodesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<int> nodeIndex = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> details = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NodesCompanion(
                id: id,
                parentId: parentId,
                nodeIndex: nodeIndex,
                description: description,
                details: details,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> parentId = const Value.absent(),
                required int nodeIndex,
                required String description,
                required String details,
                Value<int> rowid = const Value.absent(),
              }) => NodesCompanion.insert(
                id: id,
                parentId: parentId,
                nodeIndex: nodeIndex,
                description: description,
                details: details,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$NodesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({nodeTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (nodeTagsRefs) db.nodeTags],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (nodeTagsRefs)
                    await $_getPrefetchedData<DbNode, $NodesTable, NodeTag>(
                      currentTable: table,
                      referencedTable: $$NodesTableReferences
                          ._nodeTagsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$NodesTableReferences(db, table, p0).nodeTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.nodeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$NodesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NodesTable,
      DbNode,
      $$NodesTableFilterComposer,
      $$NodesTableOrderingComposer,
      $$NodesTableAnnotationComposer,
      $$NodesTableCreateCompanionBuilder,
      $$NodesTableUpdateCompanionBuilder,
      (DbNode, $$NodesTableReferences),
      DbNode,
      PrefetchHooks Function({bool nodeTagsRefs})
    >;
typedef $$NodeTagsTableCreateCompanionBuilder =
    NodeTagsCompanion Function({
      required String nodeId,
      required String tagName,
      Value<int> rowid,
    });
typedef $$NodeTagsTableUpdateCompanionBuilder =
    NodeTagsCompanion Function({
      Value<String> nodeId,
      Value<String> tagName,
      Value<int> rowid,
    });

final class $$NodeTagsTableReferences
    extends BaseReferences<_$AppDatabase, $NodeTagsTable, NodeTag> {
  $$NodeTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $NodesTable _nodeIdTable(_$AppDatabase db) => db.nodes.createAlias(
    $_aliasNameGenerator(db.nodeTags.nodeId, db.nodes.id),
  );

  $$NodesTableProcessedTableManager get nodeId {
    final $_column = $_itemColumn<String>('node_id')!;

    final manager = $$NodesTableTableManager(
      $_db,
      $_db.nodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_nodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NodeTagsTableFilterComposer
    extends Composer<_$AppDatabase, $NodeTagsTable> {
  $$NodeTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnFilters(column),
  );

  $$NodesTableFilterComposer get nodeId {
    final $$NodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.nodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodesTableFilterComposer(
            $db: $db,
            $table: $db.nodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NodeTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $NodeTagsTable> {
  $$NodeTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnOrderings(column),
  );

  $$NodesTableOrderingComposer get nodeId {
    final $$NodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.nodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodesTableOrderingComposer(
            $db: $db,
            $table: $db.nodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NodeTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NodeTagsTable> {
  $$NodeTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tagName =>
      $composableBuilder(column: $table.tagName, builder: (column) => column);

  $$NodesTableAnnotationComposer get nodeId {
    final $$NodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.nodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodesTableAnnotationComposer(
            $db: $db,
            $table: $db.nodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NodeTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NodeTagsTable,
          NodeTag,
          $$NodeTagsTableFilterComposer,
          $$NodeTagsTableOrderingComposer,
          $$NodeTagsTableAnnotationComposer,
          $$NodeTagsTableCreateCompanionBuilder,
          $$NodeTagsTableUpdateCompanionBuilder,
          (NodeTag, $$NodeTagsTableReferences),
          NodeTag,
          PrefetchHooks Function({bool nodeId})
        > {
  $$NodeTagsTableTableManager(_$AppDatabase db, $NodeTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NodeTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NodeTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NodeTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> nodeId = const Value.absent(),
                Value<String> tagName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NodeTagsCompanion(
                nodeId: nodeId,
                tagName: tagName,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String nodeId,
                required String tagName,
                Value<int> rowid = const Value.absent(),
              }) => NodeTagsCompanion.insert(
                nodeId: nodeId,
                tagName: tagName,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NodeTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({nodeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (nodeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.nodeId,
                                referencedTable: $$NodeTagsTableReferences
                                    ._nodeIdTable(db),
                                referencedColumn: $$NodeTagsTableReferences
                                    ._nodeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NodeTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NodeTagsTable,
      NodeTag,
      $$NodeTagsTableFilterComposer,
      $$NodeTagsTableOrderingComposer,
      $$NodeTagsTableAnnotationComposer,
      $$NodeTagsTableCreateCompanionBuilder,
      $$NodeTagsTableUpdateCompanionBuilder,
      (NodeTag, $$NodeTagsTableReferences),
      NodeTag,
      PrefetchHooks Function({bool nodeId})
    >;
typedef $$NodeChildrenTableCreateCompanionBuilder =
    NodeChildrenCompanion Function({
      required String parentId,
      required String childId,
      Value<int> rowid,
    });
typedef $$NodeChildrenTableUpdateCompanionBuilder =
    NodeChildrenCompanion Function({
      Value<String> parentId,
      Value<String> childId,
      Value<int> rowid,
    });

final class $$NodeChildrenTableReferences
    extends
        BaseReferences<_$AppDatabase, $NodeChildrenTable, NodeChildrenData> {
  $$NodeChildrenTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $NodesTable _parentIdTable(_$AppDatabase db) => db.nodes.createAlias(
    $_aliasNameGenerator(db.nodeChildren.parentId, db.nodes.id),
  );

  $$NodesTableProcessedTableManager get parentId {
    final $_column = $_itemColumn<String>('parent_id')!;

    final manager = $$NodesTableTableManager(
      $_db,
      $_db.nodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $NodesTable _childIdTable(_$AppDatabase db) => db.nodes.createAlias(
    $_aliasNameGenerator(db.nodeChildren.childId, db.nodes.id),
  );

  $$NodesTableProcessedTableManager get childId {
    final $_column = $_itemColumn<String>('child_id')!;

    final manager = $$NodesTableTableManager(
      $_db,
      $_db.nodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_childIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NodeChildrenTableFilterComposer
    extends Composer<_$AppDatabase, $NodeChildrenTable> {
  $$NodeChildrenTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$NodesTableFilterComposer get parentId {
    final $$NodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.nodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodesTableFilterComposer(
            $db: $db,
            $table: $db.nodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NodesTableFilterComposer get childId {
    final $$NodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.childId,
      referencedTable: $db.nodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodesTableFilterComposer(
            $db: $db,
            $table: $db.nodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NodeChildrenTableOrderingComposer
    extends Composer<_$AppDatabase, $NodeChildrenTable> {
  $$NodeChildrenTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$NodesTableOrderingComposer get parentId {
    final $$NodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.nodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodesTableOrderingComposer(
            $db: $db,
            $table: $db.nodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NodesTableOrderingComposer get childId {
    final $$NodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.childId,
      referencedTable: $db.nodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodesTableOrderingComposer(
            $db: $db,
            $table: $db.nodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NodeChildrenTableAnnotationComposer
    extends Composer<_$AppDatabase, $NodeChildrenTable> {
  $$NodeChildrenTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$NodesTableAnnotationComposer get parentId {
    final $$NodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.nodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodesTableAnnotationComposer(
            $db: $db,
            $table: $db.nodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NodesTableAnnotationComposer get childId {
    final $$NodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.childId,
      referencedTable: $db.nodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodesTableAnnotationComposer(
            $db: $db,
            $table: $db.nodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NodeChildrenTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NodeChildrenTable,
          NodeChildrenData,
          $$NodeChildrenTableFilterComposer,
          $$NodeChildrenTableOrderingComposer,
          $$NodeChildrenTableAnnotationComposer,
          $$NodeChildrenTableCreateCompanionBuilder,
          $$NodeChildrenTableUpdateCompanionBuilder,
          (NodeChildrenData, $$NodeChildrenTableReferences),
          NodeChildrenData,
          PrefetchHooks Function({bool parentId, bool childId})
        > {
  $$NodeChildrenTableTableManager(_$AppDatabase db, $NodeChildrenTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NodeChildrenTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NodeChildrenTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NodeChildrenTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> parentId = const Value.absent(),
                Value<String> childId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NodeChildrenCompanion(
                parentId: parentId,
                childId: childId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String parentId,
                required String childId,
                Value<int> rowid = const Value.absent(),
              }) => NodeChildrenCompanion.insert(
                parentId: parentId,
                childId: childId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NodeChildrenTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({parentId = false, childId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (parentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.parentId,
                                referencedTable: $$NodeChildrenTableReferences
                                    ._parentIdTable(db),
                                referencedColumn: $$NodeChildrenTableReferences
                                    ._parentIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (childId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.childId,
                                referencedTable: $$NodeChildrenTableReferences
                                    ._childIdTable(db),
                                referencedColumn: $$NodeChildrenTableReferences
                                    ._childIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NodeChildrenTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NodeChildrenTable,
      NodeChildrenData,
      $$NodeChildrenTableFilterComposer,
      $$NodeChildrenTableOrderingComposer,
      $$NodeChildrenTableAnnotationComposer,
      $$NodeChildrenTableCreateCompanionBuilder,
      $$NodeChildrenTableUpdateCompanionBuilder,
      (NodeChildrenData, $$NodeChildrenTableReferences),
      NodeChildrenData,
      PrefetchHooks Function({bool parentId, bool childId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NodesTableTableManager get nodes =>
      $$NodesTableTableManager(_db, _db.nodes);
  $$NodeTagsTableTableManager get nodeTags =>
      $$NodeTagsTableTableManager(_db, _db.nodeTags);
  $$NodeChildrenTableTableManager get nodeChildren =>
      $$NodeChildrenTableTableManager(_db, _db.nodeChildren);
}
