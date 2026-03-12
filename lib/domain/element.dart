import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/v4.dart';

part 'element.freezed.dart';
part 'element.g.dart';

class IListConverter<T> implements JsonConverter<IList<T>, List<dynamic>> {
  const IListConverter();

  @override
  IList<T> fromJson(List<dynamic> json) =>
      IList<T>(json.cast<T>());

  @override
  List<dynamic> toJson(IList<T> object) => object.toList();
}

class ISetConverter<T> implements JsonConverter<ISet<T>, List<dynamic>> {
  const ISetConverter();

  @override
  ISet<T> fromJson(List<dynamic> json) =>
      ISet<T>(json.cast<T>());

  @override
  List<dynamic> toJson(ISet<T> object) => object.toList();
}

@freezed
abstract class Tag with _$Tag {
  const factory Tag({required String name}) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

enum DefaultNodeInteraction { enter, unfold }

extension type NodeId._(String _data) {
  const NodeId.fromString(this._data);

  static NodeId random() {
    return NodeId._(UuidV4().generate());
  }

  factory NodeId.fromJson(Object json) => NodeId.fromString(json as String);
  Object toJson() => _data;
}

@freezed
abstract class NodeDescription with _$NodeDescription {
  const factory NodeDescription({required String content}) = _NodeDescription;

  factory NodeDescription.fromJson(Map<String, dynamic> json) =>
      _$NodeDescriptionFromJson(json);
}

@freezed
abstract class NodeDetails with _$NodeDetails {
  const factory NodeDetails({required String content}) = _NodeDetails;

  factory NodeDetails.fromJson(Map<String, dynamic> json) =>
      _$NodeDetailsFromJson(json);
}

@freezed
abstract class Node with _$Node {
  const factory Node({
    required NodeId id,
    required NodeDescription description,
    required NodeDetails details,
    @Default(false) bool done,
    @IListConverter<Tag>() required IList<Tag> tags,
    @IListConverter<NodeId>() required IList<NodeId> children,
  }) = _Node;

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
}
