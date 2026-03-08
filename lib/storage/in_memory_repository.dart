import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:todotree/domain/element.dart';
import 'package:todotree/storage/map_repository.dart';

class InMemoryRepository extends BaseMapRepository {
  InMemoryRepository()
    : super({
        BaseMapRepository.rootId: StorageNode(
          id: BaseMapRepository.rootId,
          parentId: null,
          nodeIndex: 0,
          description: const NodeDescription(content: "Root"),
          details: const NodeDetails(content: ""),
          tags: const ISet.empty(),
          children: const IList.empty(),
        ),
      });
}
