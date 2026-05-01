// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phase_transition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PhaseTransition {

 TimerPhase get from; TimerPhase get to; int get round; int get set;
/// Create a copy of PhaseTransition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhaseTransitionCopyWith<PhaseTransition> get copyWith => _$PhaseTransitionCopyWithImpl<PhaseTransition>(this as PhaseTransition, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhaseTransition&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.round, round) || other.round == round)&&(identical(other.set, set) || other.set == set));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,round,set);

@override
String toString() {
  return 'PhaseTransition(from: $from, to: $to, round: $round, set: $set)';
}


}

/// @nodoc
abstract mixin class $PhaseTransitionCopyWith<$Res>  {
  factory $PhaseTransitionCopyWith(PhaseTransition value, $Res Function(PhaseTransition) _then) = _$PhaseTransitionCopyWithImpl;
@useResult
$Res call({
 TimerPhase from, TimerPhase to, int round, int set
});




}
/// @nodoc
class _$PhaseTransitionCopyWithImpl<$Res>
    implements $PhaseTransitionCopyWith<$Res> {
  _$PhaseTransitionCopyWithImpl(this._self, this._then);

  final PhaseTransition _self;
  final $Res Function(PhaseTransition) _then;

/// Create a copy of PhaseTransition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? round = null,Object? set = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as TimerPhase,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as TimerPhase,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,set: null == set ? _self.set : set // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PhaseTransition].
extension PhaseTransitionPatterns on PhaseTransition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhaseTransition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhaseTransition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhaseTransition value)  $default,){
final _that = this;
switch (_that) {
case _PhaseTransition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhaseTransition value)?  $default,){
final _that = this;
switch (_that) {
case _PhaseTransition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TimerPhase from,  TimerPhase to,  int round,  int set)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhaseTransition() when $default != null:
return $default(_that.from,_that.to,_that.round,_that.set);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TimerPhase from,  TimerPhase to,  int round,  int set)  $default,) {final _that = this;
switch (_that) {
case _PhaseTransition():
return $default(_that.from,_that.to,_that.round,_that.set);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TimerPhase from,  TimerPhase to,  int round,  int set)?  $default,) {final _that = this;
switch (_that) {
case _PhaseTransition() when $default != null:
return $default(_that.from,_that.to,_that.round,_that.set);case _:
  return null;

}
}

}

/// @nodoc


class _PhaseTransition implements PhaseTransition {
  const _PhaseTransition({required this.from, required this.to, required this.round, required this.set});
  

@override final  TimerPhase from;
@override final  TimerPhase to;
@override final  int round;
@override final  int set;

/// Create a copy of PhaseTransition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhaseTransitionCopyWith<_PhaseTransition> get copyWith => __$PhaseTransitionCopyWithImpl<_PhaseTransition>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhaseTransition&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.round, round) || other.round == round)&&(identical(other.set, set) || other.set == set));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,round,set);

@override
String toString() {
  return 'PhaseTransition(from: $from, to: $to, round: $round, set: $set)';
}


}

/// @nodoc
abstract mixin class _$PhaseTransitionCopyWith<$Res> implements $PhaseTransitionCopyWith<$Res> {
  factory _$PhaseTransitionCopyWith(_PhaseTransition value, $Res Function(_PhaseTransition) _then) = __$PhaseTransitionCopyWithImpl;
@override @useResult
$Res call({
 TimerPhase from, TimerPhase to, int round, int set
});




}
/// @nodoc
class __$PhaseTransitionCopyWithImpl<$Res>
    implements _$PhaseTransitionCopyWith<$Res> {
  __$PhaseTransitionCopyWithImpl(this._self, this._then);

  final _PhaseTransition _self;
  final $Res Function(_PhaseTransition) _then;

/// Create a copy of PhaseTransition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? round = null,Object? set = null,}) {
  return _then(_PhaseTransition(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as TimerPhase,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as TimerPhase,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,set: null == set ? _self.set : set // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
