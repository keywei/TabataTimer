// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_image_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutImageDto {

 String get id; String get relativePath; bool get enabled;
/// Create a copy of WorkoutImageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutImageDtoCopyWith<WorkoutImageDto> get copyWith => _$WorkoutImageDtoCopyWithImpl<WorkoutImageDto>(this as WorkoutImageDto, _$identity);

  /// Serializes this WorkoutImageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutImageDto&&(identical(other.id, id) || other.id == id)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,relativePath,enabled);

@override
String toString() {
  return 'WorkoutImageDto(id: $id, relativePath: $relativePath, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $WorkoutImageDtoCopyWith<$Res>  {
  factory $WorkoutImageDtoCopyWith(WorkoutImageDto value, $Res Function(WorkoutImageDto) _then) = _$WorkoutImageDtoCopyWithImpl;
@useResult
$Res call({
 String id, String relativePath, bool enabled
});




}
/// @nodoc
class _$WorkoutImageDtoCopyWithImpl<$Res>
    implements $WorkoutImageDtoCopyWith<$Res> {
  _$WorkoutImageDtoCopyWithImpl(this._self, this._then);

  final WorkoutImageDto _self;
  final $Res Function(WorkoutImageDto) _then;

/// Create a copy of WorkoutImageDto
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


/// Adds pattern-matching-related methods to [WorkoutImageDto].
extension WorkoutImageDtoPatterns on WorkoutImageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutImageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutImageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutImageDto value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutImageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutImageDto value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutImageDto() when $default != null:
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
case _WorkoutImageDto() when $default != null:
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
case _WorkoutImageDto():
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
case _WorkoutImageDto() when $default != null:
return $default(_that.id,_that.relativePath,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkoutImageDto implements WorkoutImageDto {
  const _WorkoutImageDto({required this.id, required this.relativePath, this.enabled = true});
  factory _WorkoutImageDto.fromJson(Map<String, dynamic> json) => _$WorkoutImageDtoFromJson(json);

@override final  String id;
@override final  String relativePath;
@override@JsonKey() final  bool enabled;

/// Create a copy of WorkoutImageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutImageDtoCopyWith<_WorkoutImageDto> get copyWith => __$WorkoutImageDtoCopyWithImpl<_WorkoutImageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkoutImageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutImageDto&&(identical(other.id, id) || other.id == id)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,relativePath,enabled);

@override
String toString() {
  return 'WorkoutImageDto(id: $id, relativePath: $relativePath, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$WorkoutImageDtoCopyWith<$Res> implements $WorkoutImageDtoCopyWith<$Res> {
  factory _$WorkoutImageDtoCopyWith(_WorkoutImageDto value, $Res Function(_WorkoutImageDto) _then) = __$WorkoutImageDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String relativePath, bool enabled
});




}
/// @nodoc
class __$WorkoutImageDtoCopyWithImpl<$Res>
    implements _$WorkoutImageDtoCopyWith<$Res> {
  __$WorkoutImageDtoCopyWithImpl(this._self, this._then);

  final _WorkoutImageDto _self;
  final $Res Function(_WorkoutImageDto) _then;

/// Create a copy of WorkoutImageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? relativePath = null,Object? enabled = null,}) {
  return _then(_WorkoutImageDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,relativePath: null == relativePath ? _self.relativePath : relativePath // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
