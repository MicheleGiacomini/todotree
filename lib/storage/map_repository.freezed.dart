// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StorageNode {

 NodeId get id; NodeId? get parentId; int get nodeIndex; NodeDescription get description; NodeDetails get details;@ISetConverter<Tag>() ISet<Tag> get tags;@IListConverter<NodeId>() IList<NodeId> get children;
/// Create a copy of StorageNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageNodeCopyWith<StorageNode> get copyWith => _$StorageNodeCopyWithImpl<StorageNode>(this as StorageNode, _$identity);

  /// Serializes this StorageNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageNode&&(identical(other.id, id) || other.id == id)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.nodeIndex, nodeIndex) || other.nodeIndex == nodeIndex)&&(identical(other.description, description) || other.description == description)&&(identical(other.details, details) || other.details == details)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,parentId,nodeIndex,description,details,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'StorageNode(id: $id, parentId: $parentId, nodeIndex: $nodeIndex, description: $description, details: $details, tags: $tags, children: $children)';
}


}

/// @nodoc
abstract mixin class $StorageNodeCopyWith<$Res>  {
  factory $StorageNodeCopyWith(StorageNode value, $Res Function(StorageNode) _then) = _$StorageNodeCopyWithImpl;
@useResult
$Res call({
 NodeId id, NodeId? parentId, int nodeIndex, NodeDescription description, NodeDetails details,@ISetConverter<Tag>() ISet<Tag> tags,@IListConverter<NodeId>() IList<NodeId> children
});


$NodeDescriptionCopyWith<$Res> get description;$NodeDetailsCopyWith<$Res> get details;

}
/// @nodoc
class _$StorageNodeCopyWithImpl<$Res>
    implements $StorageNodeCopyWith<$Res> {
  _$StorageNodeCopyWithImpl(this._self, this._then);

  final StorageNode _self;
  final $Res Function(StorageNode) _then;

/// Create a copy of StorageNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? parentId = freezed,Object? nodeIndex = null,Object? description = null,Object? details = null,Object? tags = null,Object? children = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as NodeId,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as NodeId?,nodeIndex: null == nodeIndex ? _self.nodeIndex : nodeIndex // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as NodeDescription,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as NodeDetails,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as ISet<Tag>,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as IList<NodeId>,
  ));
}
/// Create a copy of StorageNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodeDescriptionCopyWith<$Res> get description {
  
  return $NodeDescriptionCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of StorageNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodeDetailsCopyWith<$Res> get details {
  
  return $NodeDetailsCopyWith<$Res>(_self.details, (value) {
    return _then(_self.copyWith(details: value));
  });
}
}


/// Adds pattern-matching-related methods to [StorageNode].
extension StorageNodePatterns on StorageNode {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorageNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorageNode() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorageNode value)  $default,){
final _that = this;
switch (_that) {
case _StorageNode():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorageNode value)?  $default,){
final _that = this;
switch (_that) {
case _StorageNode() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NodeId id,  NodeId? parentId,  int nodeIndex,  NodeDescription description,  NodeDetails details, @ISetConverter<Tag>()  ISet<Tag> tags, @IListConverter<NodeId>()  IList<NodeId> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorageNode() when $default != null:
return $default(_that.id,_that.parentId,_that.nodeIndex,_that.description,_that.details,_that.tags,_that.children);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NodeId id,  NodeId? parentId,  int nodeIndex,  NodeDescription description,  NodeDetails details, @ISetConverter<Tag>()  ISet<Tag> tags, @IListConverter<NodeId>()  IList<NodeId> children)  $default,) {final _that = this;
switch (_that) {
case _StorageNode():
return $default(_that.id,_that.parentId,_that.nodeIndex,_that.description,_that.details,_that.tags,_that.children);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NodeId id,  NodeId? parentId,  int nodeIndex,  NodeDescription description,  NodeDetails details, @ISetConverter<Tag>()  ISet<Tag> tags, @IListConverter<NodeId>()  IList<NodeId> children)?  $default,) {final _that = this;
switch (_that) {
case _StorageNode() when $default != null:
return $default(_that.id,_that.parentId,_that.nodeIndex,_that.description,_that.details,_that.tags,_that.children);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorageNode extends StorageNode {
  const _StorageNode({required this.id, required this.parentId, required this.nodeIndex, required this.description, required this.details, @ISetConverter<Tag>() required this.tags, @IListConverter<NodeId>() required this.children}): super._();
  factory _StorageNode.fromJson(Map<String, dynamic> json) => _$StorageNodeFromJson(json);

@override final  NodeId id;
@override final  NodeId? parentId;
@override final  int nodeIndex;
@override final  NodeDescription description;
@override final  NodeDetails details;
@override@ISetConverter<Tag>() final  ISet<Tag> tags;
@override@IListConverter<NodeId>() final  IList<NodeId> children;

/// Create a copy of StorageNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorageNodeCopyWith<_StorageNode> get copyWith => __$StorageNodeCopyWithImpl<_StorageNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorageNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorageNode&&(identical(other.id, id) || other.id == id)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.nodeIndex, nodeIndex) || other.nodeIndex == nodeIndex)&&(identical(other.description, description) || other.description == description)&&(identical(other.details, details) || other.details == details)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,parentId,nodeIndex,description,details,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'StorageNode(id: $id, parentId: $parentId, nodeIndex: $nodeIndex, description: $description, details: $details, tags: $tags, children: $children)';
}


}

/// @nodoc
abstract mixin class _$StorageNodeCopyWith<$Res> implements $StorageNodeCopyWith<$Res> {
  factory _$StorageNodeCopyWith(_StorageNode value, $Res Function(_StorageNode) _then) = __$StorageNodeCopyWithImpl;
@override @useResult
$Res call({
 NodeId id, NodeId? parentId, int nodeIndex, NodeDescription description, NodeDetails details,@ISetConverter<Tag>() ISet<Tag> tags,@IListConverter<NodeId>() IList<NodeId> children
});


@override $NodeDescriptionCopyWith<$Res> get description;@override $NodeDetailsCopyWith<$Res> get details;

}
/// @nodoc
class __$StorageNodeCopyWithImpl<$Res>
    implements _$StorageNodeCopyWith<$Res> {
  __$StorageNodeCopyWithImpl(this._self, this._then);

  final _StorageNode _self;
  final $Res Function(_StorageNode) _then;

/// Create a copy of StorageNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? parentId = freezed,Object? nodeIndex = null,Object? description = null,Object? details = null,Object? tags = null,Object? children = null,}) {
  return _then(_StorageNode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as NodeId,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as NodeId?,nodeIndex: null == nodeIndex ? _self.nodeIndex : nodeIndex // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as NodeDescription,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as NodeDetails,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as ISet<Tag>,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as IList<NodeId>,
  ));
}

/// Create a copy of StorageNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodeDescriptionCopyWith<$Res> get description {
  
  return $NodeDescriptionCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of StorageNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodeDetailsCopyWith<$Res> get details {
  
  return $NodeDetailsCopyWith<$Res>(_self.details, (value) {
    return _then(_self.copyWith(details: value));
  });
}
}

// dart format on
