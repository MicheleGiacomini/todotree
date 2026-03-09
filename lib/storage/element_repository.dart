import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/element.dart';

part 'element_repository.freezed.dart';

@freezed
sealed class Operation with _$Operation {
  const factory Operation.addTag(NodeId id, IList<Tag> currentTags, Tag tag) =
      AddTag;
  const factory Operation.updateDescription(
    NodeId id,
    NodeDescription previousDescription,
    NodeDescription newDescription,
  ) = UpdateDescription;
  const factory Operation.updateDetails(
    NodeId id,
    NodeDetails previousDetails,
    NodeDetails newDetails,
  ) = UpdateDetails;
  const factory Operation.removeTag(
    NodeId id,
    IList<Tag> currentTags,
    Tag removedTag,
  ) = RemoveTag;
  const factory Operation.removeNode(NodeId id) = RemoveNode;
  const factory Operation.createNewAt(
    NodeId parentId,
    IList<NodeId> prevParentChildren,
    NodeId newChild,
  ) = CreateNewAt;
  const factory Operation.sortChild(
    NodeId id,
    NodeId? oldPrevChild,
    NodeId? newPrevChild,
  ) = SortChild;
  const factory Operation.reparent(
    NodeId id,
    NodeId prevParent,
    List<NodeId> prevParentChildren,
    NodeId newParent,
    NodeId newId,
  ) = Reparent;
}

abstract interface class ElementRepository {
  Future<Map<NodeId, Node>> getElements();
  Future<ISet<Tag>> getTags();
  Future<Map<String, int>> getTagColors();
  Future<NodeId> getRootId();
  Future<Node> updateDesription(NodeId id, NodeDescription newDescription);
  Future<Node> updateDetails(NodeId id, NodeDetails newDetails);
  Future<Node> addTag(NodeId id, Tag tag);
  Future<Node> removeTag(NodeId id, Tag tag);
  Future<void> setTagColor(String tagName, int color);
  Future<Map<NodeId, Node>> pruneNode(NodeId id);
  Future<({Node updatedParent, Node newChild})> createNewAt(NodeId id);

  /// Returns the updated parent node with children in the new ordering
  Future<Node> sortChild(
    NodeId childId,
    NodeId? oldPrevChild,
    NodeId? newPrevChild,
  );
  Future<({Node updatedOldParent, Node updatedNewParent})> reparent(
    NodeId child,
    NodeId newParent,
  );
}
