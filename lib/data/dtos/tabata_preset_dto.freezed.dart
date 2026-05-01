// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tabata_preset_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TabataPresetDto {

 String get id; String get name; int get prepareSeconds; int get workSeconds; int get restSeconds; int get rounds; int get sets; int get restBetweenSetsSeconds;
/// Create a copy of TabataPresetDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabataPresetDtoCopyWith<TabataPresetDto> get copyWith => _$TabataPresetDtoCopyWithImpl<TabataPresetDto>(this as TabataPresetDto, _$identity);

  /// Serializes this TabataPresetDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabataPresetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.prepareSeconds, prepareSeconds) || other.prepareSeconds == prepareSeconds)&&(identical(other.workSeconds, workSeconds) || other.workSeconds == workSeconds)&&(identical(other.restSeconds, restSeconds) || other.restSeconds == restSeconds)&&(identical(other.rounds, rounds) || other.rounds == rounds)&&(identical(other.sets, sets) || other.sets == sets)&&(identical(other.restBetweenSetsSeconds, restBetweenSetsSeconds) || other.restBetweenSetsSeconds == restBetweenSetsSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,prepareSeconds,workSeconds,restSeconds,rounds,sets,restBetweenSetsSeconds);

@override
String toString() {
  return 'TabataPresetDto(id: $id, name: $name, prepareSeconds: $prepareSeconds, workSeconds: $workSeconds, restSeconds: $restSeconds, rounds: $rounds, sets: $sets, restBetweenSetsSeconds: $restBetweenSetsSeconds)';
}


}

/// @nodoc
abstract mixin class $TabataPresetDtoCopyWith<$Res>  {
  factory $TabataPresetDtoCopyWith(TabataPresetDto value, $Res Function(TabataPresetDto) _then) = _$TabataPresetDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, int prepareSeconds, int workSeconds, int restSeconds, int rounds, int sets, int restBetweenSetsSeconds
});




}
/// @nodoc
class _$TabataPresetDtoCopyWithImpl<$Res>
    implements $TabataPresetDtoCopyWith<$Res> {
  _$TabataPresetDtoCopyWithImpl(this._self, this._then);

  final TabataPresetDto _self;
  final $Res Function(TabataPresetDto) _then;

/// Create a copy of TabataPresetDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? prepareSeconds = null,Object? workSeconds = null,Object? restSeconds = null,Object? rounds = null,Object? sets = null,Object? restBetweenSetsSeconds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,prepareSeconds: null == prepareSeconds ? _self.prepareSeconds : prepareSeconds // ignore: cast_nullable_to_non_nullable
as int,workSeconds: null == workSeconds ? _self.workSeconds : workSeconds // ignore: cast_nullable_to_non_nullable
as int,restSeconds: null == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int,rounds: null == rounds ? _self.rounds : rounds // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as int,restBetweenSetsSeconds: null == restBetweenSetsSeconds ? _self.restBetweenSetsSeconds : restBetweenSetsSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TabataPresetDto].
extension TabataPresetDtoPatterns on TabataPresetDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TabataPresetDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TabataPresetDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TabataPresetDto value)  $default,){
final _that = this;
switch (_that) {
case _TabataPresetDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TabataPresetDto value)?  $default,){
final _that = this;
switch (_that) {
case _TabataPresetDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int prepareSeconds,  int workSeconds,  int restSeconds,  int rounds,  int sets,  int restBetweenSetsSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TabataPresetDto() when $default != null:
return $default(_that.id,_that.name,_that.prepareSeconds,_that.workSeconds,_that.restSeconds,_that.rounds,_that.sets,_that.restBetweenSetsSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int prepareSeconds,  int workSeconds,  int restSeconds,  int rounds,  int sets,  int restBetweenSetsSeconds)  $default,) {final _that = this;
switch (_that) {
case _TabataPresetDto():
return $default(_that.id,_that.name,_that.prepareSeconds,_that.workSeconds,_that.restSeconds,_that.rounds,_that.sets,_that.restBetweenSetsSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int prepareSeconds,  int workSeconds,  int restSeconds,  int rounds,  int sets,  int restBetweenSetsSeconds)?  $default,) {final _that = this;
switch (_that) {
case _TabataPresetDto() when $default != null:
return $default(_that.id,_that.name,_that.prepareSeconds,_that.workSeconds,_that.restSeconds,_that.rounds,_that.sets,_that.restBetweenSetsSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TabataPresetDto implements TabataPresetDto {
  const _TabataPresetDto({required this.id, required this.name, this.prepareSeconds = 10, this.workSeconds = 20, this.restSeconds = 10, this.rounds = 8, this.sets = 1, this.restBetweenSetsSeconds = 60});
  factory _TabataPresetDto.fromJson(Map<String, dynamic> json) => _$TabataPresetDtoFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  int prepareSeconds;
@override@JsonKey() final  int workSeconds;
@override@JsonKey() final  int restSeconds;
@override@JsonKey() final  int rounds;
@override@JsonKey() final  int sets;
@override@JsonKey() final  int restBetweenSetsSeconds;

/// Create a copy of TabataPresetDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TabataPresetDtoCopyWith<_TabataPresetDto> get copyWith => __$TabataPresetDtoCopyWithImpl<_TabataPresetDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TabataPresetDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TabataPresetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.prepareSeconds, prepareSeconds) || other.prepareSeconds == prepareSeconds)&&(identical(other.workSeconds, workSeconds) || other.workSeconds == workSeconds)&&(identical(other.restSeconds, restSeconds) || other.restSeconds == restSeconds)&&(identical(other.rounds, rounds) || other.rounds == rounds)&&(identical(other.sets, sets) || other.sets == sets)&&(identical(other.restBetweenSetsSeconds, restBetweenSetsSeconds) || other.restBetweenSetsSeconds == restBetweenSetsSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,prepareSeconds,workSeconds,restSeconds,rounds,sets,restBetweenSetsSeconds);

@override
String toString() {
  return 'TabataPresetDto(id: $id, name: $name, prepareSeconds: $prepareSeconds, workSeconds: $workSeconds, restSeconds: $restSeconds, rounds: $rounds, sets: $sets, restBetweenSetsSeconds: $restBetweenSetsSeconds)';
}


}

/// @nodoc
abstract mixin class _$TabataPresetDtoCopyWith<$Res> implements $TabataPresetDtoCopyWith<$Res> {
  factory _$TabataPresetDtoCopyWith(_TabataPresetDto value, $Res Function(_TabataPresetDto) _then) = __$TabataPresetDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int prepareSeconds, int workSeconds, int restSeconds, int rounds, int sets, int restBetweenSetsSeconds
});




}
/// @nodoc
class __$TabataPresetDtoCopyWithImpl<$Res>
    implements _$TabataPresetDtoCopyWith<$Res> {
  __$TabataPresetDtoCopyWithImpl(this._self, this._then);

  final _TabataPresetDto _self;
  final $Res Function(_TabataPresetDto) _then;

/// Create a copy of TabataPresetDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? prepareSeconds = null,Object? workSeconds = null,Object? restSeconds = null,Object? rounds = null,Object? sets = null,Object? restBetweenSetsSeconds = null,}) {
  return _then(_TabataPresetDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,prepareSeconds: null == prepareSeconds ? _self.prepareSeconds : prepareSeconds // ignore: cast_nullable_to_non_nullable
as int,workSeconds: null == workSeconds ? _self.workSeconds : workSeconds // ignore: cast_nullable_to_non_nullable
as int,restSeconds: null == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int,rounds: null == rounds ? _self.rounds : rounds // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as int,restBetweenSetsSeconds: null == restBetweenSetsSeconds ? _self.restBetweenSetsSeconds : restBetweenSetsSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
