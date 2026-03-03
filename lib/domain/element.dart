import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/v4.dart';

part 'element.freezed.dart';

@freezed
abstract class Tag with _$Tag {
  const factory Tag({required String name}) = _Tag;
}

enum DefaultNodeInteraction { enter, unfold }

extension type NodeId._(String _data) {
  const NodeId.fromString(this._data);

  static NodeId random() {
    return NodeId._(UuidV4().generate());
  }
}

@freezed
abstract class NodeDescription with _$NodeDescription {
  const factory NodeDescription({required String content}) = _NodeDescription;
}

@freezed
abstract class NodeDetails with _$NodeDetails {
  const factory NodeDetails({required String content}) = _NodeDetails;
}

@freezed
abstract class Node with _$Node {
  const factory Node({
    required NodeId id,
    required NodeDescription description,
    required NodeDetails details,
    required IList<Tag> tags,
    required IList<NodeId> children,
  }) = _Node;
}
