import 'dart:convert';
import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todotree/domain/element.dart';
import 'package:todotree/storage/map_repository.dart';

class JsonRepository extends BaseMapRepository {
  final File _file;

  JsonRepository._(super.nodes, super.tagColors, this._file);

  static Future<JsonRepository> init({String fileName = 'todotree.json'}) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');

    if (await file.exists()) {
      try {
        final content = await file.readAsString();
        final Map<String, dynamic> json = jsonDecode(content);
        
        final nodesJson = json['nodes'] as Map<String, dynamic>;
        final tagColorsJson = json['tagColors'] as Map<String, dynamic>;

        final nodes = nodesJson.map((key, value) {
          final id = NodeId.fromString(key);
          return MapEntry(id, StorageNode.fromJson(value as Map<String, dynamic>));
        });

        final tagColors = tagColorsJson.map((key, value) => MapEntry(key, value as int));

        return JsonRepository._(nodes, tagColors, file);
      } catch (e) {
        // Fallback if file is corrupted or old format
      }
    }

    final initialNodes = {
      BaseMapRepository.rootId: StorageNode(
        id: BaseMapRepository.rootId,
        parentId: null,
        nodeIndex: 0,
        description: const NodeDescription(content: "Root"),
        details: const NodeDetails(content: ""),
        tags: const ISet.empty(),
        children: const IList.empty(),
      ),
    };
    final repo = JsonRepository._(initialNodes, {}, file);
    await repo._save();
    return repo;
  }

  Future<void> _save() async {
    final nodesMap = nodes.map((key, value) => MapEntry(key.toJson().toString(), value.toJson()));
    final jsonMap = {
      'nodes': nodesMap,
      'tagColors': tagColors,
    };
    await _file.writeAsString(jsonEncode(jsonMap));
  }

  @override
  Future<void> setTagColor(String tagName, int color) async {
    await super.setTagColor(tagName, color);
    await _save();
  }

  @override
  Future<Node> addTag(NodeId id, Tag tag) async {
    final result = await super.addTag(id, tag);
    await _save();
    return result;
  }

  @override
  Future<({Node newChild, Node updatedParent})> createNewAt(NodeId id) async {
    final result = await super.createNewAt(id);
    await _save();
    return result;
  }

  @override
  Future<Map<NodeId, Node>> pruneNode(NodeId id) async {
    final result = await super.pruneNode(id);
    await _save();
    return result;
  }

  @override
  Future<Node> removeTag(NodeId id, Tag tag) async {
    final result = await super.removeTag(id, tag);
    await _save();
    return result;
  }

  @override
  Future<({Node updatedNewParent, Node updatedOldParent})> reparent(
    NodeId child,
    NodeId newParent,
  ) async {
    final result = await super.reparent(child, newParent);
    await _save();
    return result;
  }

  @override
  Future<Node> sortChild(
    NodeId childId,
    NodeId? oldPrev,
    NodeId? newPrev,
  ) async {
    final result = await super.sortChild(childId, oldPrev, newPrev);
    await _save();
    return result;
  }

  @override
  Future<Node> updateDesription(
    NodeId id,
    NodeDescription newDescription,
  ) async {
    final result = await super.updateDesription(id, newDescription);
    await _save();
    return result;
  }

  @override
  Future<Node> updateDetails(NodeId id, NodeDetails newDetails) async {
    final result = await super.updateDetails(id, newDetails);
    await _save();
    return result;
  }
}
