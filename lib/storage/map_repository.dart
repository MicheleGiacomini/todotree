import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todotree/domain/element.dart';
import 'package:todotree/storage/element_repository.dart';

part 'map_repository.freezed.dart';
part 'map_repository.g.dart';

@freezed
abstract class StorageNode with _$StorageNode {
  const StorageNode._();

  const factory StorageNode({
    required NodeId id,
    required NodeId? parentId,
    required int nodeIndex,
    required NodeDescription description,
    required NodeDetails details,
    @ISetConverter<Tag>() required ISet<Tag> tags,
    @IListConverter<NodeId>() required IList<NodeId> children,
  }) = _StorageNode;

  factory StorageNode.fromJson(Map<String, dynamic> json) =>
      _$StorageNodeFromJson(json);
}

abstract class BaseMapRepository implements ElementRepository {
  final Map<NodeId, StorageNode> nodes;
  final Map<String, int> tagColors;

  static const NodeId rootId = NodeId.fromString("-1");

  BaseMapRepository(this.nodes, this.tagColors);

  Node _buildNode(StorageNode node) {
    final children = node.children
        .map((e) => nodes[e]!)
        .sortedBy((e) => e.nodeIndex)
        .map((e) => e.id);
    return Node(
      id: node.id,
      description: node.description,
      details: node.details,
      tags: node.tags.toIList(),
      children: children.toIList(),
    );
  }

  @override
  Future<Node> addTag(NodeId id, Tag tag) async {
    final current = nodes[id]!;
    final updated = current.copyWith(tags: current.tags.add(tag));
    nodes[id] = updated;
    return _buildNode(updated);
  }

  @override
  Future<({Node newChild, Node updatedParent})> createNewAt(NodeId id) async {
    final newId = NodeId.random();
    final currentParent = nodes[id]!;
    final newNode = StorageNode(
      id: newId,
      parentId: id,
      nodeIndex: currentParent.children.length,
      description: NodeDescription(content: ""),
      details: NodeDetails(content: ""),
      tags: const ISet.empty(),
      children: const IList.empty(),
    );
    final updatedParent = currentParent.copyWith(
      children: currentParent.children.add(newId),
    );
    nodes.addAll({id: updatedParent, newId: newNode});
    final updatedParentNode = _buildNode(updatedParent);
    return (newChild: _buildNode(newNode), updatedParent: updatedParentNode);
  }

  @override
  Future<Map<NodeId, Node>> getElements() async {
    return nodes.map((k, v) => MapEntry(k, _buildNode(v)));
  }

  @override
  Future<ISet<Tag>> getTags() async {
    final tags = <Tag>{};
    for (final node in nodes.values) {
      tags.addAll(node.tags);
    }
    return tags.toISet();
  }

  @override
  Future<Map<String, int>> getTagColors() async {
    return tagColors;
  }

  @override
  Future<void> setTagColor(String tagName, int color) async {
    tagColors[tagName] = color;
  }

  @override
  Future<NodeId> getRootId() async => rootId;

  @override
  Future<Map<NodeId, Node>> pruneNode(NodeId id) async {
    final current = nodes[id]!;

    void internal(NodeId id) {
      final current = nodes.remove(id)!;
      for (final child in current.children) {
        internal(child);
      }
    }

    if (current.parentId != null) {
      final parent = nodes[current.parentId]!;
      nodes[parent.id] = parent.copyWith(children: parent.children.remove(id));
    }

    internal(id);
    return getElements();
  }

  @override
  Future<Node> removeTag(NodeId id, Tag tag) async {
    final current = nodes[id]!;
    final updated = current.copyWith(tags: current.tags.remove(tag));
    nodes[id] = updated;
    return _buildNode(updated);
  }

  @override
  Future<({Node updatedNewParent, Node updatedOldParent})> reparent(
    NodeId child,
    NodeId newParent,
  ) async {
    final currentNode = nodes[child]!;
    final currentOldParent = nodes[currentNode.parentId]!;
    final currentNewParent = nodes[newParent]!;
    final oldChildIndex = currentNode.nodeIndex;
    final updatedNode = currentNode.copyWith(
      parentId: newParent,
      nodeIndex: currentNewParent.children.length,
    );
    final updatedOldParent = currentOldParent.copyWith(
      children: currentOldParent.children.remove(child),
    );
    final updatedNewParent = currentNewParent.copyWith(
      children: currentNewParent.children.add(child),
    );
    final updates = {
      child: updatedNode,
      currentOldParent.id: updatedOldParent,
      newParent: updatedNewParent,
    };
    for (final childId in updatedOldParent.children) {
      final currentChild = nodes[childId]!;
      if (currentChild.nodeIndex > oldChildIndex) {
        updates[childId] = currentChild.copyWith(
          nodeIndex: currentChild.nodeIndex - 1,
        );
      }
    }
    nodes.addAll(updates);
    return (
      updatedNewParent: _buildNode(updatedNewParent),
      updatedOldParent: _buildNode(updatedOldParent),
    );
  }

  @override
  Future<Node> sortChild(
    NodeId childId,
    NodeId? oldPrev,
    NodeId? newPrev,
  ) async {
    final currentChild = nodes[childId]!;
    final parentId = currentChild.parentId!;
    final parent = nodes[parentId]!;
    var newIndex = 0;
    if (newPrev != null) {
      final newPrevNode = nodes[newPrev]!;
      newIndex = newPrevNode.nodeIndex + 1;
    }
    final updatedChild = currentChild.copyWith(nodeIndex: newIndex);
    final updates = {childId: updatedChild};
    for (final childIdInParent in parent.children) {
      final currentChildInParent = nodes[childIdInParent]!;
      if (currentChildInParent.nodeIndex >= newIndex && childIdInParent != childId) {
        updates[childIdInParent] = currentChildInParent.copyWith(
          nodeIndex: currentChildInParent.nodeIndex + 1,
        );
      }
    }
    nodes.addAll(updates);
    return _buildNode(nodes[parentId]!);
  }

  @override
  Future<Node> updateDesription(
    NodeId id,
    NodeDescription newDescription,
  ) async {
    final currentNode = nodes[id]!;
    final updatedNode = currentNode.copyWith(description: newDescription);
    nodes[id] = updatedNode;
    return _buildNode(updatedNode);
  }

  @override
  Future<Node> updateDetails(NodeId id, NodeDetails newDetails) async {
    final currentNode = nodes[id]!;
    final updatedNode = currentNode.copyWith(details: newDetails);
    nodes[id] = updatedNode;
    return _buildNode(updatedNode);
  }
}
