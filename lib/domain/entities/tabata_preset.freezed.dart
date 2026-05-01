// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tabata_preset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TabataPreset {

 String get id; String get name; int get prepareSeconds; int get workSeconds; int get restSeconds; int get rounds; int get sets; int get restBetweenSetsSeconds;
/// Create a copy of TabataPreset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabataPresetCopyWith<TabataPreset> get copyWith => _$TabataPresetCopyWithImpl<TabataPreset>(this as TabataPreset, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabataPreset&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.prepareSeconds, prepareSeconds) || other.prepareSeconds == prepareSeconds)&&(identical(other.workSeconds, workSeconds) || other.workSeconds == workSeconds)&&(identical(other.restSeconds, restSeconds) || other.restSeconds == restSeconds)&&(identical(other.rounds, rounds) || other.rounds == rounds)&&(identical(other.sets, sets) || other.sets == sets)&&(identical(other.restBetweenSetsSeconds, restBetweenSetsSeconds) || other.restBetweenSetsSeconds == restBetweenSetsSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,prepareSeconds,workSeconds,restSeconds,rounds,sets,restBetweenSetsSeconds);

@override
String toString() {
  return 'TabataPreset(id: $id, name: $name, prepareSeconds: $prepareSeconds, workSeconds: $workSeconds, restSeconds: $restSeconds, rounds: $rounds, sets: $sets, restBetweenSetsSeconds: $restBetweenSetsSeconds)';
}


}

/// @nodoc
abstract mixin class $TabataPresetCopyWith<$Res>  {
  factory $TabataPresetCopyWith(TabataPreset value, $Res Function(TabataPreset) _then) = _$TabataPresetCopyWithImpl;
@useResult
$Res call({
 String id, String name, int prepareSeconds, int workSeconds, int restSeconds, int rounds, int sets, int restBetweenSetsSeconds
});




}
/// @nodoc
class _$TabataPresetCopyWithImpl<$Res>
    implements $TabataPresetCopyWith<$Res> {
  _$TabataPresetCopyWithImpl(this._self, this._then);

  final TabataPreset _self;
  final $Res Function(TabataPreset) _then;

/// Create a copy of TabataPreset
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


/// Adds pattern-matching-related methods to [TabataPreset].
extension TabataPresetPatterns on TabataPreset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TabataPreset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TabataPreset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TabataPreset value)  $default,){
final _that = this;
switch (_that) {
case _TabataPreset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TabataPreset value)?  $default,){
final _that = this;
switch (_that) {
case _TabataPreset() when $default != null:
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
case _TabataPreset() when $default != null:
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
case _TabataPreset():
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
case _TabataPreset() when $default != null:
return $default(_that.id,_that.name,_that.prepareSeconds,_that.workSeconds,_that.restSeconds,_that.rounds,_that.sets,_that.restBetweenSetsSeconds);case _:
  return null;

}
}

}

/// @nodoc


class _TabataPreset extends TabataPreset {
  const _TabataPreset({required this.id, required this.name, this.prepareSeconds = 10, this.workSeconds = 20, this.restSeconds = 10, this.rounds = 8, this.sets = 1, this.restBetweenSetsSeconds = 60}): super._();
  

@override final  String id;
@override final  String name;
@override@JsonKey() final  int prepareSeconds;
@override@JsonKey() final  int workSeconds;
@override@JsonKey() final  int restSeconds;
@override@JsonKey() final  int rounds;
@override@JsonKey() final  int sets;
@override@JsonKey() final  int restBetweenSetsSeconds;

/// Create a copy of TabataPreset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TabataPresetCopyWith<_TabataPreset> get copyWith => __$TabataPresetCopyWithImpl<_TabataPreset>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TabataPreset&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.prepareSeconds, prepareSeconds) || other.prepareSeconds == prepareSeconds)&&(identical(other.workSeconds, workSeconds) || other.workSeconds == workSeconds)&&(identical(other.restSeconds, restSeconds) || other.restSeconds == restSeconds)&&(identical(other.rounds, rounds) || other.rounds == rounds)&&(identical(other.sets, sets) || other.sets == sets)&&(identical(other.restBetweenSetsSeconds, restBetweenSetsSeconds) || other.restBetweenSetsSeconds == restBetweenSetsSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,prepareSeconds,workSeconds,restSeconds,rounds,sets,restBetweenSetsSeconds);

@override
String toString() {
  return 'TabataPreset(id: $id, name: $name, prepareSeconds: $prepareSeconds, workSeconds: $workSeconds, restSeconds: $restSeconds, rounds: $rounds, sets: $sets, restBetweenSetsSeconds: $restBetweenSetsSeconds)';
}


}

/// @nodoc
abstract mixin class _$TabataPresetCopyWith<$Res> implements $TabataPresetCopyWith<$Res> {
  factory _$TabataPresetCopyWith(_TabataPreset value, $Res Function(_TabataPreset) _then) = __$TabataPresetCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int prepareSeconds, int workSeconds, int restSeconds, int rounds, int sets, int restBetweenSetsSeconds
});




}
/// @nodoc
class __$TabataPresetCopyWithImpl<$Res>
    implements _$TabataPresetCopyWith<$Res> {
  __$TabataPresetCopyWithImpl(this._self, this._then);

  final _TabataPreset _self;
  final $Res Function(_TabataPreset) _then;

/// Create a copy of TabataPreset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? prepareSeconds = null,Object? workSeconds = null,Object? restSeconds = null,Object? rounds = null,Object? sets = null,Object? restBetweenSetsSeconds = null,}) {
  return _then(_TabataPreset(
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
