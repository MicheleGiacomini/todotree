// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StorageNode _$StorageNodeFromJson(Map<String, dynamic> json) => _StorageNode(
  id: NodeId.fromJson(json['id'] as Object),
  parentId: json['parentId'] == null
      ? null
      : NodeId.fromJson(json['parentId'] as Object),
  nodeIndex: (json['nodeIndex'] as num).toInt(),
  description: NodeDescription.fromJson(
    json['description'] as Map<String, dynamic>,
  ),
  details: NodeDetails.fromJson(json['details'] as Map<String, dynamic>),
  tags: ISet<Tag>.fromJson(
    json['tags'],
    (value) => Tag.fromJson(value as Map<String, dynamic>),
  ),
  children: IList<NodeId>.fromJson(
    json['children'],
    (value) => NodeId.fromJson(value as Object),
  ),
);

Map<String, dynamic> _$StorageNodeToJson(_StorageNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'nodeIndex': instance.nodeIndex,
      'description': instance.description,
      'details': instance.details,
      'tags': instance.tags.toJson((value) => value),
      'children': instance.children.toJson((value) => value),
    };
