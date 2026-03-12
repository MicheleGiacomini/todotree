// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Tag _$TagFromJson(Map<String, dynamic> json) =>
    _Tag(name: json['name'] as String);

Map<String, dynamic> _$TagToJson(_Tag instance) => <String, dynamic>{
  'name': instance.name,
};

_NodeDescription _$NodeDescriptionFromJson(Map<String, dynamic> json) =>
    _NodeDescription(content: json['content'] as String);

Map<String, dynamic> _$NodeDescriptionToJson(_NodeDescription instance) =>
    <String, dynamic>{'content': instance.content};

_NodeDetails _$NodeDetailsFromJson(Map<String, dynamic> json) =>
    _NodeDetails(content: json['content'] as String);

Map<String, dynamic> _$NodeDetailsToJson(_NodeDetails instance) =>
    <String, dynamic>{'content': instance.content};

_Node _$NodeFromJson(Map<String, dynamic> json) => _Node(
  id: NodeId.fromJson(json['id'] as Object),
  description: NodeDescription.fromJson(
    json['description'] as Map<String, dynamic>,
  ),
  details: NodeDetails.fromJson(json['details'] as Map<String, dynamic>),
  done: json['done'] as bool? ?? false,
  tags: IList<Tag>.fromJson(
    json['tags'],
    (value) => Tag.fromJson(value as Map<String, dynamic>),
  ),
  children: IList<NodeId>.fromJson(
    json['children'],
    (value) => NodeId.fromJson(value as Object),
  ),
);

Map<String, dynamic> _$NodeToJson(_Node instance) => <String, dynamic>{
  'id': instance.id,
  'description': instance.description,
  'details': instance.details,
  'done': instance.done,
  'tags': instance.tags.toJson((value) => value),
  'children': instance.children.toJson((value) => value),
};
