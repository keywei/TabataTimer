// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkoutImage {

 String get id;/// Path relative to the app's documents directory.
/// e.g., `workout_images/<uuid>.jpg`
 String get relativePath; bool get enabled;
/// Create a copy of WorkoutImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutImageCopyWith<WorkoutImage> get copyWith => _$WorkoutImageCopyWithImpl<WorkoutImage>(this as WorkoutImage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutImage&&(identical(other.id, id) || other.id == id)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,id,relativePath,enabled);

@override
String toString() {
  return 'WorkoutImage(id: $id, relativePath: $relativePath, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $WorkoutImageCopyWith<$Res>  {
  factory $WorkoutImageCopyWith(WorkoutImage value, $Res Function(WorkoutImage) _then) = _$WorkoutImageCopyWithImpl;
@useResult
$Res call({
 String id, String relativePath, bool enabled
});




}
/// @nodoc
class _$WorkoutImageCopyWithImpl<$Res>
    implements $WorkoutImageCopyWith<$Res> {
  _$WorkoutImageCopyWithImpl(this._self, this._then);

  final WorkoutImage _self;
  final $Res Function(WorkoutImage) _then;

/// Create a copy of WorkoutImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? relativePath = null,Object? enabled = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,relativePath: null == relativePath ? _self.relativePath : relativePath // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutImage].
extension WorkoutImagePatterns on WorkoutImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutImage value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutImage value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String relativePath,  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutImage() when $default != null:
return $default(_that.id,_that.relativePath,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String relativePath,  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _WorkoutImage():
return $default(_that.id,_that.relativePath,_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String relativePath,  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutImage() when $default != null:
return $default(_that.id,_that.relativePath,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc


class _WorkoutImage implements WorkoutImage {
  const _WorkoutImage({required this.id, required this.relativePath, this.enabled = true});
  

@override final  String id;
/// Path relative to the app's documents directory.
/// e.g., `workout_images/<uuid>.jpg`
@override final  String relativePath;
@override@JsonKey() final  bool enabled;

/// Create a copy of WorkoutImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutImageCopyWith<_WorkoutImage> get copyWith => __$WorkoutImageCopyWithImpl<_WorkoutImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutImage&&(identical(other.id, id) || other.id == id)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,id,relativePath,enabled);

@override
String toString() {
  return 'WorkoutImage(id: $id, relativePath: $relativePath, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$WorkoutImageCopyWith<$Res> implements $WorkoutImageCopyWith<$Res> {
  factory _$WorkoutImageCopyWith(_WorkoutImage value, $Res Function(_WorkoutImage) _then) = __$WorkoutImageCopyWithImpl;
@override @useResult
$Res call({
 String id, String relativePath, bool enabled
});




}
/// @nodoc
class __$WorkoutImageCopyWithImpl<$Res>
    implements _$WorkoutImageCopyWith<$Res> {
  __$WorkoutImageCopyWithImpl(this._self, this._then);

  final _WorkoutImage _self;
  final $Res Function(_WorkoutImage) _then;

/// Create a copy of WorkoutImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? relativePath = null,Object? enabled = null,}) {
  return _then(_WorkoutImage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,relativePath: null == relativePath ? _self.relativePath : relativePath // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
