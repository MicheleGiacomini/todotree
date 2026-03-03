// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'element_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Operation implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Operation'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Operation);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Operation()';
}


}

/// @nodoc
class $OperationCopyWith<$Res>  {
$OperationCopyWith(Operation _, $Res Function(Operation) __);
}


/// Adds pattern-matching-related methods to [Operation].
extension OperationPatterns on Operation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AddTag value)?  addTag,TResult Function( UpdateDescription value)?  updateDescription,TResult Function( UpdateDetails value)?  updateDetails,TResult Function( RemoveTag value)?  removeTag,TResult Function( RemoveNode value)?  removeNode,TResult Function( CreateNewAt value)?  createNewAt,TResult Function( SortChild value)?  sortChild,TResult Function( Reparent value)?  reparent,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AddTag() when addTag != null:
return addTag(_that);case UpdateDescription() when updateDescription != null:
return updateDescription(_that);case UpdateDetails() when updateDetails != null:
return updateDetails(_that);case RemoveTag() when removeTag != null:
return removeTag(_that);case RemoveNode() when removeNode != null:
return removeNode(_that);case CreateNewAt() when createNewAt != null:
return createNewAt(_that);case SortChild() when sortChild != null:
return sortChild(_that);case Reparent() when reparent != null:
return reparent(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AddTag value)  addTag,required TResult Function( UpdateDescription value)  updateDescription,required TResult Function( UpdateDetails value)  updateDetails,required TResult Function( RemoveTag value)  removeTag,required TResult Function( RemoveNode value)  removeNode,required TResult Function( CreateNewAt value)  createNewAt,required TResult Function( SortChild value)  sortChild,required TResult Function( Reparent value)  reparent,}){
final _that = this;
switch (_that) {
case AddTag():
return addTag(_that);case UpdateDescription():
return updateDescription(_that);case UpdateDetails():
return updateDetails(_that);case RemoveTag():
return removeTag(_that);case RemoveNode():
return removeNode(_that);case CreateNewAt():
return createNewAt(_that);case SortChild():
return sortChild(_that);case Reparent():
return reparent(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AddTag value)?  addTag,TResult? Function( UpdateDescription value)?  updateDescription,TResult? Function( UpdateDetails value)?  updateDetails,TResult? Function( RemoveTag value)?  removeTag,TResult? Function( RemoveNode value)?  removeNode,TResult? Function( CreateNewAt value)?  createNewAt,TResult? Function( SortChild value)?  sortChild,TResult? Function( Reparent value)?  reparent,}){
final _that = this;
switch (_that) {
case AddTag() when addTag != null:
return addTag(_that);case UpdateDescription() when updateDescription != null:
return updateDescription(_that);case UpdateDetails() when updateDetails != null:
return updateDetails(_that);case RemoveTag() when removeTag != null:
return removeTag(_that);case RemoveNode() when removeNode != null:
return removeNode(_that);case CreateNewAt() when createNewAt != null:
return createNewAt(_that);case SortChild() when sortChild != null:
return sortChild(_that);case Reparent() when reparent != null:
return reparent(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( NodeId id,  IList<Tag> currentTags,  Tag tag)?  addTag,TResult Function( NodeId id,  NodeDescription previousDescription,  NodeDescription newDescription)?  updateDescription,TResult Function( NodeId id,  NodeDetails previousDetails,  NodeDetails newDetails)?  updateDetails,TResult Function( NodeId id,  IList<Tag> currentTags,  Tag removedTag)?  removeTag,TResult Function( NodeId id)?  removeNode,TResult Function( NodeId parentId,  IList<NodeId> prevParentChildren,  NodeId newChild)?  createNewAt,TResult Function( NodeId id,  NodeId? oldPrevChild,  NodeId? newPrevChild)?  sortChild,TResult Function( NodeId id,  NodeId prevParent,  List<NodeId> prevParentChildren,  NodeId newParent,  NodeId newId)?  reparent,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AddTag() when addTag != null:
return addTag(_that.id,_that.currentTags,_that.tag);case UpdateDescription() when updateDescription != null:
return updateDescription(_that.id,_that.previousDescription,_that.newDescription);case UpdateDetails() when updateDetails != null:
return updateDetails(_that.id,_that.previousDetails,_that.newDetails);case RemoveTag() when removeTag != null:
return removeTag(_that.id,_that.currentTags,_that.removedTag);case RemoveNode() when removeNode != null:
return removeNode(_that.id);case CreateNewAt() when createNewAt != null:
return createNewAt(_that.parentId,_that.prevParentChildren,_that.newChild);case SortChild() when sortChild != null:
return sortChild(_that.id,_that.oldPrevChild,_that.newPrevChild);case Reparent() when reparent != null:
return reparent(_that.id,_that.prevParent,_that.prevParentChildren,_that.newParent,_that.newId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( NodeId id,  IList<Tag> currentTags,  Tag tag)  addTag,required TResult Function( NodeId id,  NodeDescription previousDescription,  NodeDescription newDescription)  updateDescription,required TResult Function( NodeId id,  NodeDetails previousDetails,  NodeDetails newDetails)  updateDetails,required TResult Function( NodeId id,  IList<Tag> currentTags,  Tag removedTag)  removeTag,required TResult Function( NodeId id)  removeNode,required TResult Function( NodeId parentId,  IList<NodeId> prevParentChildren,  NodeId newChild)  createNewAt,required TResult Function( NodeId id,  NodeId? oldPrevChild,  NodeId? newPrevChild)  sortChild,required TResult Function( NodeId id,  NodeId prevParent,  List<NodeId> prevParentChildren,  NodeId newParent,  NodeId newId)  reparent,}) {final _that = this;
switch (_that) {
case AddTag():
return addTag(_that.id,_that.currentTags,_that.tag);case UpdateDescription():
return updateDescription(_that.id,_that.previousDescription,_that.newDescription);case UpdateDetails():
return updateDetails(_that.id,_that.previousDetails,_that.newDetails);case RemoveTag():
return removeTag(_that.id,_that.currentTags,_that.removedTag);case RemoveNode():
return removeNode(_that.id);case CreateNewAt():
return createNewAt(_that.parentId,_that.prevParentChildren,_that.newChild);case SortChild():
return sortChild(_that.id,_that.oldPrevChild,_that.newPrevChild);case Reparent():
return reparent(_that.id,_that.prevParent,_that.prevParentChildren,_that.newParent,_that.newId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( NodeId id,  IList<Tag> currentTags,  Tag tag)?  addTag,TResult? Function( NodeId id,  NodeDescription previousDescription,  NodeDescription newDescription)?  updateDescription,TResult? Function( NodeId id,  NodeDetails previousDetails,  NodeDetails newDetails)?  updateDetails,TResult? Function( NodeId id,  IList<Tag> currentTags,  Tag removedTag)?  removeTag,TResult? Function( NodeId id)?  removeNode,TResult? Function( NodeId parentId,  IList<NodeId> prevParentChildren,  NodeId newChild)?  createNewAt,TResult? Function( NodeId id,  NodeId? oldPrevChild,  NodeId? newPrevChild)?  sortChild,TResult? Function( NodeId id,  NodeId prevParent,  List<NodeId> prevParentChildren,  NodeId newParent,  NodeId newId)?  reparent,}) {final _that = this;
switch (_that) {
case AddTag() when addTag != null:
return addTag(_that.id,_that.currentTags,_that.tag);case UpdateDescription() when updateDescription != null:
return updateDescription(_that.id,_that.previousDescription,_that.newDescription);case UpdateDetails() when updateDetails != null:
return updateDetails(_that.id,_that.previousDetails,_that.newDetails);case RemoveTag() when removeTag != null:
return removeTag(_that.id,_that.currentTags,_that.removedTag);case RemoveNode() when removeNode != null:
return removeNode(_that.id);case CreateNewAt() when createNewAt != null:
return createNewAt(_that.parentId,_that.prevParentChildren,_that.newChild);case SortChild() when sortChild != null:
return sortChild(_that.id,_that.oldPrevChild,_that.newPrevChild);case Reparent() when reparent != null:
return reparent(_that.id,_that.prevParent,_that.prevParentChildren,_that.newParent,_that.newId);case _:
  return null;

}
}

}

/// @nodoc


class AddTag with DiagnosticableTreeMixin implements Operation {
  const AddTag(this.id, this.currentTags, this.tag);
  

 final  NodeId id;
 final  IList<Tag> currentTags;
 final  Tag tag;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddTagCopyWith<AddTag> get copyWith => _$AddTagCopyWithImpl<AddTag>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Operation.addTag'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('currentTags', currentTags))..add(DiagnosticsProperty('tag', tag));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddTag&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.currentTags, currentTags)&&(identical(other.tag, tag) || other.tag == tag));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(currentTags),tag);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Operation.addTag(id: $id, currentTags: $currentTags, tag: $tag)';
}


}

/// @nodoc
abstract mixin class $AddTagCopyWith<$Res> implements $OperationCopyWith<$Res> {
  factory $AddTagCopyWith(AddTag value, $Res Function(AddTag) _then) = _$AddTagCopyWithImpl;
@useResult
$Res call({
 NodeId id, IList<Tag> currentTags, Tag tag
});


$TagCopyWith<$Res> get tag;

}
/// @nodoc
class _$AddTagCopyWithImpl<$Res>
    implements $AddTagCopyWith<$Res> {
  _$AddTagCopyWithImpl(this._self, this._then);

  final AddTag _self;
  final $Res Function(AddTag) _then;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? currentTags = null,Object? tag = null,}) {
  return _then(AddTag(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as NodeId,null == currentTags ? _self.currentTags : currentTags // ignore: cast_nullable_to_non_nullable
as IList<Tag>,null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as Tag,
  ));
}

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagCopyWith<$Res> get tag {
  
  return $TagCopyWith<$Res>(_self.tag, (value) {
    return _then(_self.copyWith(tag: value));
  });
}
}

/// @nodoc


class UpdateDescription with DiagnosticableTreeMixin implements Operation {
  const UpdateDescription(this.id, this.previousDescription, this.newDescription);
  

 final  NodeId id;
 final  NodeDescription previousDescription;
 final  NodeDescription newDescription;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateDescriptionCopyWith<UpdateDescription> get copyWith => _$UpdateDescriptionCopyWithImpl<UpdateDescription>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Operation.updateDescription'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('previousDescription', previousDescription))..add(DiagnosticsProperty('newDescription', newDescription));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateDescription&&(identical(other.id, id) || other.id == id)&&(identical(other.previousDescription, previousDescription) || other.previousDescription == previousDescription)&&(identical(other.newDescription, newDescription) || other.newDescription == newDescription));
}


@override
int get hashCode => Object.hash(runtimeType,id,previousDescription,newDescription);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Operation.updateDescription(id: $id, previousDescription: $previousDescription, newDescription: $newDescription)';
}


}

/// @nodoc
abstract mixin class $UpdateDescriptionCopyWith<$Res> implements $OperationCopyWith<$Res> {
  factory $UpdateDescriptionCopyWith(UpdateDescription value, $Res Function(UpdateDescription) _then) = _$UpdateDescriptionCopyWithImpl;
@useResult
$Res call({
 NodeId id, NodeDescription previousDescription, NodeDescription newDescription
});


$NodeDescriptionCopyWith<$Res> get previousDescription;$NodeDescriptionCopyWith<$Res> get newDescription;

}
/// @nodoc
class _$UpdateDescriptionCopyWithImpl<$Res>
    implements $UpdateDescriptionCopyWith<$Res> {
  _$UpdateDescriptionCopyWithImpl(this._self, this._then);

  final UpdateDescription _self;
  final $Res Function(UpdateDescription) _then;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? previousDescription = null,Object? newDescription = null,}) {
  return _then(UpdateDescription(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as NodeId,null == previousDescription ? _self.previousDescription : previousDescription // ignore: cast_nullable_to_non_nullable
as NodeDescription,null == newDescription ? _self.newDescription : newDescription // ignore: cast_nullable_to_non_nullable
as NodeDescription,
  ));
}

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodeDescriptionCopyWith<$Res> get previousDescription {
  
  return $NodeDescriptionCopyWith<$Res>(_self.previousDescription, (value) {
    return _then(_self.copyWith(previousDescription: value));
  });
}/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodeDescriptionCopyWith<$Res> get newDescription {
  
  return $NodeDescriptionCopyWith<$Res>(_self.newDescription, (value) {
    return _then(_self.copyWith(newDescription: value));
  });
}
}

/// @nodoc


class UpdateDetails with DiagnosticableTreeMixin implements Operation {
  const UpdateDetails(this.id, this.previousDetails, this.newDetails);
  

 final  NodeId id;
 final  NodeDetails previousDetails;
 final  NodeDetails newDetails;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateDetailsCopyWith<UpdateDetails> get copyWith => _$UpdateDetailsCopyWithImpl<UpdateDetails>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Operation.updateDetails'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('previousDetails', previousDetails))..add(DiagnosticsProperty('newDetails', newDetails));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.previousDetails, previousDetails) || other.previousDetails == previousDetails)&&(identical(other.newDetails, newDetails) || other.newDetails == newDetails));
}


@override
int get hashCode => Object.hash(runtimeType,id,previousDetails,newDetails);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Operation.updateDetails(id: $id, previousDetails: $previousDetails, newDetails: $newDetails)';
}


}

/// @nodoc
abstract mixin class $UpdateDetailsCopyWith<$Res> implements $OperationCopyWith<$Res> {
  factory $UpdateDetailsCopyWith(UpdateDetails value, $Res Function(UpdateDetails) _then) = _$UpdateDetailsCopyWithImpl;
@useResult
$Res call({
 NodeId id, NodeDetails previousDetails, NodeDetails newDetails
});


$NodeDetailsCopyWith<$Res> get previousDetails;$NodeDetailsCopyWith<$Res> get newDetails;

}
/// @nodoc
class _$UpdateDetailsCopyWithImpl<$Res>
    implements $UpdateDetailsCopyWith<$Res> {
  _$UpdateDetailsCopyWithImpl(this._self, this._then);

  final UpdateDetails _self;
  final $Res Function(UpdateDetails) _then;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? previousDetails = null,Object? newDetails = null,}) {
  return _then(UpdateDetails(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as NodeId,null == previousDetails ? _self.previousDetails : previousDetails // ignore: cast_nullable_to_non_nullable
as NodeDetails,null == newDetails ? _self.newDetails : newDetails // ignore: cast_nullable_to_non_nullable
as NodeDetails,
  ));
}

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodeDetailsCopyWith<$Res> get previousDetails {
  
  return $NodeDetailsCopyWith<$Res>(_self.previousDetails, (value) {
    return _then(_self.copyWith(previousDetails: value));
  });
}/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodeDetailsCopyWith<$Res> get newDetails {
  
  return $NodeDetailsCopyWith<$Res>(_self.newDetails, (value) {
    return _then(_self.copyWith(newDetails: value));
  });
}
}

/// @nodoc


class RemoveTag with DiagnosticableTreeMixin implements Operation {
  const RemoveTag(this.id, this.currentTags, this.removedTag);
  

 final  NodeId id;
 final  IList<Tag> currentTags;
 final  Tag removedTag;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveTagCopyWith<RemoveTag> get copyWith => _$RemoveTagCopyWithImpl<RemoveTag>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Operation.removeTag'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('currentTags', currentTags))..add(DiagnosticsProperty('removedTag', removedTag));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveTag&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.currentTags, currentTags)&&(identical(other.removedTag, removedTag) || other.removedTag == removedTag));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(currentTags),removedTag);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Operation.removeTag(id: $id, currentTags: $currentTags, removedTag: $removedTag)';
}


}

/// @nodoc
abstract mixin class $RemoveTagCopyWith<$Res> implements $OperationCopyWith<$Res> {
  factory $RemoveTagCopyWith(RemoveTag value, $Res Function(RemoveTag) _then) = _$RemoveTagCopyWithImpl;
@useResult
$Res call({
 NodeId id, IList<Tag> currentTags, Tag removedTag
});


$TagCopyWith<$Res> get removedTag;

}
/// @nodoc
class _$RemoveTagCopyWithImpl<$Res>
    implements $RemoveTagCopyWith<$Res> {
  _$RemoveTagCopyWithImpl(this._self, this._then);

  final RemoveTag _self;
  final $Res Function(RemoveTag) _then;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? currentTags = null,Object? removedTag = null,}) {
  return _then(RemoveTag(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as NodeId,null == currentTags ? _self.currentTags : currentTags // ignore: cast_nullable_to_non_nullable
as IList<Tag>,null == removedTag ? _self.removedTag : removedTag // ignore: cast_nullable_to_non_nullable
as Tag,
  ));
}

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagCopyWith<$Res> get removedTag {
  
  return $TagCopyWith<$Res>(_self.removedTag, (value) {
    return _then(_self.copyWith(removedTag: value));
  });
}
}

/// @nodoc


class RemoveNode with DiagnosticableTreeMixin implements Operation {
  const RemoveNode(this.id);
  

 final  NodeId id;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveNodeCopyWith<RemoveNode> get copyWith => _$RemoveNodeCopyWithImpl<RemoveNode>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Operation.removeNode'))
    ..add(DiagnosticsProperty('id', id));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveNode&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Operation.removeNode(id: $id)';
}


}

/// @nodoc
abstract mixin class $RemoveNodeCopyWith<$Res> implements $OperationCopyWith<$Res> {
  factory $RemoveNodeCopyWith(RemoveNode value, $Res Function(RemoveNode) _then) = _$RemoveNodeCopyWithImpl;
@useResult
$Res call({
 NodeId id
});




}
/// @nodoc
class _$RemoveNodeCopyWithImpl<$Res>
    implements $RemoveNodeCopyWith<$Res> {
  _$RemoveNodeCopyWithImpl(this._self, this._then);

  final RemoveNode _self;
  final $Res Function(RemoveNode) _then;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(RemoveNode(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as NodeId,
  ));
}


}

/// @nodoc


class CreateNewAt with DiagnosticableTreeMixin implements Operation {
  const CreateNewAt(this.parentId, this.prevParentChildren, this.newChild);
  

 final  NodeId parentId;
 final  IList<NodeId> prevParentChildren;
 final  NodeId newChild;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateNewAtCopyWith<CreateNewAt> get copyWith => _$CreateNewAtCopyWithImpl<CreateNewAt>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Operation.createNewAt'))
    ..add(DiagnosticsProperty('parentId', parentId))..add(DiagnosticsProperty('prevParentChildren', prevParentChildren))..add(DiagnosticsProperty('newChild', newChild));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateNewAt&&(identical(other.parentId, parentId) || other.parentId == parentId)&&const DeepCollectionEquality().equals(other.prevParentChildren, prevParentChildren)&&(identical(other.newChild, newChild) || other.newChild == newChild));
}


@override
int get hashCode => Object.hash(runtimeType,parentId,const DeepCollectionEquality().hash(prevParentChildren),newChild);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Operation.createNewAt(parentId: $parentId, prevParentChildren: $prevParentChildren, newChild: $newChild)';
}


}

/// @nodoc
abstract mixin class $CreateNewAtCopyWith<$Res> implements $OperationCopyWith<$Res> {
  factory $CreateNewAtCopyWith(CreateNewAt value, $Res Function(CreateNewAt) _then) = _$CreateNewAtCopyWithImpl;
@useResult
$Res call({
 NodeId parentId, IList<NodeId> prevParentChildren, NodeId newChild
});




}
/// @nodoc
class _$CreateNewAtCopyWithImpl<$Res>
    implements $CreateNewAtCopyWith<$Res> {
  _$CreateNewAtCopyWithImpl(this._self, this._then);

  final CreateNewAt _self;
  final $Res Function(CreateNewAt) _then;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? parentId = null,Object? prevParentChildren = null,Object? newChild = null,}) {
  return _then(CreateNewAt(
null == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as NodeId,null == prevParentChildren ? _self.prevParentChildren : prevParentChildren // ignore: cast_nullable_to_non_nullable
as IList<NodeId>,null == newChild ? _self.newChild : newChild // ignore: cast_nullable_to_non_nullable
as NodeId,
  ));
}


}

/// @nodoc


class SortChild with DiagnosticableTreeMixin implements Operation {
  const SortChild(this.id, this.oldPrevChild, this.newPrevChild);
  

 final  NodeId id;
 final  NodeId? oldPrevChild;
 final  NodeId? newPrevChild;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SortChildCopyWith<SortChild> get copyWith => _$SortChildCopyWithImpl<SortChild>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Operation.sortChild'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('oldPrevChild', oldPrevChild))..add(DiagnosticsProperty('newPrevChild', newPrevChild));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SortChild&&(identical(other.id, id) || other.id == id)&&(identical(other.oldPrevChild, oldPrevChild) || other.oldPrevChild == oldPrevChild)&&(identical(other.newPrevChild, newPrevChild) || other.newPrevChild == newPrevChild));
}


@override
int get hashCode => Object.hash(runtimeType,id,oldPrevChild,newPrevChild);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Operation.sortChild(id: $id, oldPrevChild: $oldPrevChild, newPrevChild: $newPrevChild)';
}


}

/// @nodoc
abstract mixin class $SortChildCopyWith<$Res> implements $OperationCopyWith<$Res> {
  factory $SortChildCopyWith(SortChild value, $Res Function(SortChild) _then) = _$SortChildCopyWithImpl;
@useResult
$Res call({
 NodeId id, NodeId? oldPrevChild, NodeId? newPrevChild
});




}
/// @nodoc
class _$SortChildCopyWithImpl<$Res>
    implements $SortChildCopyWith<$Res> {
  _$SortChildCopyWithImpl(this._self, this._then);

  final SortChild _self;
  final $Res Function(SortChild) _then;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? oldPrevChild = freezed,Object? newPrevChild = freezed,}) {
  return _then(SortChild(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as NodeId,freezed == oldPrevChild ? _self.oldPrevChild : oldPrevChild // ignore: cast_nullable_to_non_nullable
as NodeId?,freezed == newPrevChild ? _self.newPrevChild : newPrevChild // ignore: cast_nullable_to_non_nullable
as NodeId?,
  ));
}


}

/// @nodoc


class Reparent with DiagnosticableTreeMixin implements Operation {
  const Reparent(this.id, this.prevParent, final  List<NodeId> prevParentChildren, this.newParent, this.newId): _prevParentChildren = prevParentChildren;
  

 final  NodeId id;
 final  NodeId prevParent;
 final  List<NodeId> _prevParentChildren;
 List<NodeId> get prevParentChildren {
  if (_prevParentChildren is EqualUnmodifiableListView) return _prevParentChildren;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prevParentChildren);
}

 final  NodeId newParent;
 final  NodeId newId;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReparentCopyWith<Reparent> get copyWith => _$ReparentCopyWithImpl<Reparent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Operation.reparent'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('prevParent', prevParent))..add(DiagnosticsProperty('prevParentChildren', prevParentChildren))..add(DiagnosticsProperty('newParent', newParent))..add(DiagnosticsProperty('newId', newId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reparent&&(identical(other.id, id) || other.id == id)&&(identical(other.prevParent, prevParent) || other.prevParent == prevParent)&&const DeepCollectionEquality().equals(other._prevParentChildren, _prevParentChildren)&&(identical(other.newParent, newParent) || other.newParent == newParent)&&(identical(other.newId, newId) || other.newId == newId));
}


@override
int get hashCode => Object.hash(runtimeType,id,prevParent,const DeepCollectionEquality().hash(_prevParentChildren),newParent,newId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Operation.reparent(id: $id, prevParent: $prevParent, prevParentChildren: $prevParentChildren, newParent: $newParent, newId: $newId)';
}


}

/// @nodoc
abstract mixin class $ReparentCopyWith<$Res> implements $OperationCopyWith<$Res> {
  factory $ReparentCopyWith(Reparent value, $Res Function(Reparent) _then) = _$ReparentCopyWithImpl;
@useResult
$Res call({
 NodeId id, NodeId prevParent, List<NodeId> prevParentChildren, NodeId newParent, NodeId newId
});




}
/// @nodoc
class _$ReparentCopyWithImpl<$Res>
    implements $ReparentCopyWith<$Res> {
  _$ReparentCopyWithImpl(this._self, this._then);

  final Reparent _self;
  final $Res Function(Reparent) _then;

/// Create a copy of Operation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? prevParent = null,Object? prevParentChildren = null,Object? newParent = null,Object? newId = null,}) {
  return _then(Reparent(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as NodeId,null == prevParent ? _self.prevParent : prevParent // ignore: cast_nullable_to_non_nullable
as NodeId,null == prevParentChildren ? _self._prevParentChildren : prevParentChildren // ignore: cast_nullable_to_non_nullable
as List<NodeId>,null == newParent ? _self.newParent : newParent // ignore: cast_nullable_to_non_nullable
as NodeId,null == newId ? _self.newId : newId // ignore: cast_nullable_to_non_nullable
as NodeId,
  ));
}


}

// dart format on
