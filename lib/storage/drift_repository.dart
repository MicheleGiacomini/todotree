import 'dart:io';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:todotree/domain/element.dart';
import 'package:todotree/storage/element_repository.dart';

part 'drift_repository.g.dart';

@DataClassName('DbNode')
class Nodes extends Table {
  TextColumn get id => text()();
  TextColumn get parentId => text().nullable()();
  IntColumn get nodeIndex => integer()();
  TextColumn get description => text()();
  TextColumn get details => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class NodeTags extends Table {
  TextColumn get nodeId => text().references(Nodes, #id)();
  TextColumn get tagName => text()();

  @override
  Set<Column> get primaryKey => {nodeId, tagName};
}

class NodeChildren extends Table {
  TextColumn get parentId => text().references(Nodes, #id)();
  TextColumn get childId => text().references(Nodes, #id)();

  @override
  Set<Column> get primaryKey => {parentId, childId};
}

@DriftDatabase(tables: [Nodes, NodeTags, NodeChildren])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    });
  }
}

class DriftRepository implements ElementRepository {
  final AppDatabase db;

  static const NodeId _rootId = NodeId.fromString("-1");

  DriftRepository(this.db);

  static Future<DriftRepository> init() async {
    final db = AppDatabase();
    final repo = DriftRepository(db);

    // Initialize root if not exists
    final root =
        await (db.select(db.nodes)
              ..where((t) => t.id.equals(_rootId.toJson().toString())))
            .getSingleOrNull();
    if (root == null) {
      await db
          .into(db.nodes)
          .insert(
            NodesCompanion.insert(
              id: _rootId.toJson().toString(),
              nodeIndex: 0,
              description: "Root",
              details: "",
            ),
          );
    }

    return repo;
  }

  Future<Node> _buildNode(DbNode dbNode) async {
    final tags = await (db.select(
      db.nodeTags,
    )..where((t) => t.nodeId.equals(dbNode.id))).get();
    final children = await (db.select(
      db.nodes,
    )..where((t) => t.parentId.equals(dbNode.id))).get();

    return Node(
      id: NodeId.fromString(dbNode.id),
      description: NodeDescription(content: dbNode.description),
      details: NodeDetails(content: dbNode.details),
      tags: tags.map((t) => Tag(name: t.tagName)).toIList(),
      children: children
          .sortedBy((e) => e.nodeIndex)
          .map((e) => NodeId.fromString(e.id))
          .toIList(),
    );
  }

  @override
  Future<Node> addTag(NodeId id, Tag tag) async {
    await db
        .into(db.nodeTags)
        .insert(
          NodeTagsCompanion.insert(
            nodeId: id.toJson().toString(),
            tagName: tag.name,
          ),
          mode: InsertMode.insertOrIgnore,
        );
    final dbNode = await (db.select(
      db.nodes,
    )..where((t) => t.id.equals(id.toJson().toString()))).getSingle();
    return _buildNode(dbNode);
  }

  @override
  Future<({Node newChild, Node updatedParent})> createNewAt(NodeId id) async {
    final newId = NodeId.random();
    final parentIdStr = id.toJson().toString();

    final parentNode = await (db.select(
      db.nodes,
    )..where((t) => t.id.equals(parentIdStr))).getSingle();
    final currentChildren = await (db.select(
      db.nodes,
    )..where((t) => t.parentId.equals(parentIdStr))).get();

    final newNode = DbNode(
      id: newId.toJson().toString(),
      parentId: parentIdStr,
      nodeIndex: currentChildren.length,
      description: "",
      details: "",
    );

    await db.transaction(() async {
      await db.into(db.nodes).insert(newNode);
    });

    return (
      newChild: await _buildNode(newNode),
      updatedParent: await _buildNode(parentNode),
    );
  }

  @override
  Future<Map<NodeId, Node>> getElements() async {
    final allDbNodes = await db.select(db.nodes).get();
    final Map<NodeId, Node> result = {};
    for (final dbNode in allDbNodes) {
      final node = await _buildNode(dbNode);
      result[node.id] = node;
    }
    return result;
  }

  @override
  Future<NodeId> getRootId() async => _rootId;

  @override
  Future<ISet<Tag>> getTags() async {
    final allTags = await db.select(db.nodeTags).get();
    return allTags.map((t) => Tag(name: t.tagName)).toISet();
  }

  @override
  Future<Map<NodeId, Node>> pruneNode(NodeId id) async {
    final idStr = id.toJson().toString();
    final node = await (db.select(
      db.nodes,
    )..where((t) => t.id.equals(idStr))).getSingleOrNull();
    if (node == null) return getElements();

    Future<void> deleteRecursive(String nodeId) async {
      final children = await (db.select(
        db.nodes,
      )..where((t) => t.parentId.equals(nodeId))).get();
      for (final child in children) {
        await deleteRecursive(child.id);
      }
      await (db.delete(
        db.nodeTags,
      )..where((t) => t.nodeId.equals(nodeId))).go();
      await (db.delete(db.nodes)..where((t) => t.id.equals(nodeId))).go();
    }

    await db.transaction(() async {
      if (node.parentId != null) {
        // Re-index siblings
        final siblings =
            await (db.select(db.nodes)
                  ..where((t) => t.parentId.equals(node.parentId!))
                  ..where(
                    (t) => t.nodeIndex.isBiggerThan(Constant(node.nodeIndex)),
                  ))
                .get();

        for (final sibling in siblings) {
          await (db.update(db.nodes)..where((t) => t.id.equals(sibling.id)))
              .write(NodesCompanion(nodeIndex: Value(sibling.nodeIndex - 1)));
        }
      }
      await deleteRecursive(idStr);
    });

    return getElements();
  }

  @override
  Future<Node> removeTag(NodeId id, Tag tag) async {
    await (db.delete(db.nodeTags)
          ..where((t) => t.nodeId.equals(id.toJson().toString()))
          ..where((t) => t.tagName.equals(tag.name)))
        .go();
    final dbNode = await (db.select(
      db.nodes,
    )..where((t) => t.id.equals(id.toJson().toString()))).getSingle();
    return _buildNode(dbNode);
  }

  @override
  Future<({Node updatedNewParent, Node updatedOldParent})> reparent(
    NodeId child,
    NodeId newParent,
  ) async {
    final childIdStr = child.toJson().toString();
    final newParentIdStr = newParent.toJson().toString();

    final childNode = await (db.select(
      db.nodes,
    )..where((t) => t.id.equals(childIdStr))).getSingle();
    final oldParentIdStr = childNode.parentId!;

    final newParentChildren = await (db.select(
      db.nodes,
    )..where((t) => t.parentId.equals(newParentIdStr))).get();

    await db.transaction(() async {
      // Update child
      await (db.update(db.nodes)..where((t) => t.id.equals(childIdStr))).write(
        NodesCompanion(
          parentId: Value(newParentIdStr),
          nodeIndex: Value(newParentChildren.length),
        ),
      );

      // Re-index old siblings
      final oldSiblings =
          await (db.select(db.nodes)
                ..where((t) => t.parentId.equals(oldParentIdStr))
                ..where(
                  (t) =>
                      t.nodeIndex.isBiggerThan(Constant(childNode.nodeIndex)),
                ))
              .get();

      for (final sibling in oldSiblings) {
        await (db.update(db.nodes)..where((t) => t.id.equals(sibling.id)))
            .write(NodesCompanion(nodeIndex: Value(sibling.nodeIndex - 1)));
      }
    });

    final updatedOldParent = await (db.select(
      db.nodes,
    )..where((t) => t.id.equals(oldParentIdStr))).getSingle();
    final updatedNewParent = await (db.select(
      db.nodes,
    )..where((t) => t.id.equals(newParentIdStr))).getSingle();

    return (
      updatedOldParent: await _buildNode(updatedOldParent),
      updatedNewParent: await _buildNode(updatedNewParent),
    );
  }

  @override
  Future<Node> sortChild(
    NodeId childId,
    NodeId? oldPrevChild,
    NodeId? newPrevChild,
  ) async {
    final idStr = childId.toJson().toString();
    final childNode = await (db.select(
      db.nodes,
    )..where((t) => t.id.equals(idStr))).getSingle();
    final parentIdStr = childNode.parentId!;

    var newIndex = 0;
    if (newPrevChild != null) {
      final prevNode =
          await (db.select(db.nodes)
                ..where((t) => t.id.equals(newPrevChild.toJson().toString())))
              .getSingle();
      newIndex = prevNode.nodeIndex + 1;
    }

    await db.transaction(() async {
      final allSiblings = await (db.select(
        db.nodes,
      )..where((t) => t.parentId.equals(parentIdStr))).get();
      for (final s in allSiblings) {
        if (s.id == idStr) continue;
        if (s.nodeIndex >= newIndex) {
          await (db.update(db.nodes)..where((t) => t.id.equals(s.id))).write(
            NodesCompanion(nodeIndex: Value(s.nodeIndex + 1)),
          );
        }
      }
      await (db.update(db.nodes)..where((t) => t.id.equals(idStr))).write(
        NodesCompanion(nodeIndex: Value(newIndex)),
      );
    });

    final parentNode = await (db.select(
      db.nodes,
    )..where((t) => t.id.equals(parentIdStr))).getSingle();
    return _buildNode(parentNode);
  }

  @override
  Future<Node> updateDesription(
    NodeId id,
    NodeDescription newDescription,
  ) async {
    final idStr = id.toJson().toString();
    await (db.update(db.nodes)..where((t) => t.id.equals(idStr))).write(
      NodesCompanion(description: Value(newDescription.content)),
    );
    final dbNode = await (db.select(
      db.nodes,
    )..where((t) => t.id.equals(idStr))).getSingle();
    return _buildNode(dbNode);
  }

  @override
  Future<Node> updateDetails(NodeId id, NodeDetails newDetails) async {
    final idStr = id.toJson().toString();
    await (db.update(db.nodes)..where((t) => t.id.equals(idStr))).write(
      NodesCompanion(details: Value(newDetails.content)),
    );
    final dbNode = await (db.select(
      db.nodes,
    )..where((t) => t.id.equals(idStr))).getSingle();
    return _buildNode(dbNode);
  }
}
