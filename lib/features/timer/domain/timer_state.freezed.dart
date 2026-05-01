// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimerSnapshot {

 TabataPreset? get preset; TimerPhase get phase; int get currentRound; int get currentSet; int get phaseRemainingMs; int get phaseDurationMs; int get totalElapsedMs; bool get isRunning; bool get isPaused;
/// Create a copy of TimerSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimerSnapshotCopyWith<TimerSnapshot> get copyWith => _$TimerSnapshotCopyWithImpl<TimerSnapshot>(this as TimerSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerSnapshot&&(identical(other.preset, preset) || other.preset == preset)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.currentRound, currentRound) || other.currentRound == currentRound)&&(identical(other.currentSet, currentSet) || other.currentSet == currentSet)&&(identical(other.phaseRemainingMs, phaseRemainingMs) || other.phaseRemainingMs == phaseRemainingMs)&&(identical(other.phaseDurationMs, phaseDurationMs) || other.phaseDurationMs == phaseDurationMs)&&(identical(other.totalElapsedMs, totalElapsedMs) || other.totalElapsedMs == totalElapsedMs)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused));
}


@override
int get hashCode => Object.hash(runtimeType,preset,phase,currentRound,currentSet,phaseRemainingMs,phaseDurationMs,totalElapsedMs,isRunning,isPaused);

@override
String toString() {
  return 'TimerSnapshot(preset: $preset, phase: $phase, currentRound: $currentRound, currentSet: $currentSet, phaseRemainingMs: $phaseRemainingMs, phaseDurationMs: $phaseDurationMs, totalElapsedMs: $totalElapsedMs, isRunning: $isRunning, isPaused: $isPaused)';
}


}

/// @nodoc
abstract mixin class $TimerSnapshotCopyWith<$Res>  {
  factory $TimerSnapshotCopyWith(TimerSnapshot value, $Res Function(TimerSnapshot) _then) = _$TimerSnapshotCopyWithImpl;
@useResult
$Res call({
 TabataPreset? preset, TimerPhase phase, int currentRound, int currentSet, int phaseRemainingMs, int phaseDurationMs, int totalElapsedMs, bool isRunning, bool isPaused
});


$TabataPresetCopyWith<$Res>? get preset;

}
/// @nodoc
class _$TimerSnapshotCopyWithImpl<$Res>
    implements $TimerSnapshotCopyWith<$Res> {
  _$TimerSnapshotCopyWithImpl(this._self, this._then);

  final TimerSnapshot _self;
  final $Res Function(TimerSnapshot) _then;

/// Create a copy of TimerSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? preset = freezed,Object? phase = null,Object? currentRound = null,Object? currentSet = null,Object? phaseRemainingMs = null,Object? phaseDurationMs = null,Object? totalElapsedMs = null,Object? isRunning = null,Object? isPaused = null,}) {
  return _then(_self.copyWith(
preset: freezed == preset ? _self.preset : preset // ignore: cast_nullable_to_non_nullable
as TabataPreset?,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as TimerPhase,currentRound: null == currentRound ? _self.currentRound : currentRound // ignore: cast_nullable_to_non_nullable
as int,currentSet: null == currentSet ? _self.currentSet : currentSet // ignore: cast_nullable_to_non_nullable
as int,phaseRemainingMs: null == phaseRemainingMs ? _self.phaseRemainingMs : phaseRemainingMs // ignore: cast_nullable_to_non_nullable
as int,phaseDurationMs: null == phaseDurationMs ? _self.phaseDurationMs : phaseDurationMs // ignore: cast_nullable_to_non_nullable
as int,totalElapsedMs: null == totalElapsedMs ? _self.totalElapsedMs : totalElapsedMs // ignore: cast_nullable_to_non_nullable
as int,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of TimerSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TabataPresetCopyWith<$Res>? get preset {
    if (_self.preset == null) {
    return null;
  }

  return $TabataPresetCopyWith<$Res>(_self.preset!, (value) {
    return _then(_self.copyWith(preset: value));
  });
}
}


/// Adds pattern-matching-related methods to [TimerSnapshot].
extension TimerSnapshotPatterns on TimerSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimerSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimerSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimerSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _TimerSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimerSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _TimerSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TabataPreset? preset,  TimerPhase phase,  int currentRound,  int currentSet,  int phaseRemainingMs,  int phaseDurationMs,  int totalElapsedMs,  bool isRunning,  bool isPaused)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimerSnapshot() when $default != null:
return $default(_that.preset,_that.phase,_that.currentRound,_that.currentSet,_that.phaseRemainingMs,_that.phaseDurationMs,_that.totalElapsedMs,_that.isRunning,_that.isPaused);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TabataPreset? preset,  TimerPhase phase,  int currentRound,  int currentSet,  int phaseRemainingMs,  int phaseDurationMs,  int totalElapsedMs,  bool isRunning,  bool isPaused)  $default,) {final _that = this;
switch (_that) {
case _TimerSnapshot():
return $default(_that.preset,_that.phase,_that.currentRound,_that.currentSet,_that.phaseRemainingMs,_that.phaseDurationMs,_that.totalElapsedMs,_that.isRunning,_that.isPaused);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TabataPreset? preset,  TimerPhase phase,  int currentRound,  int currentSet,  int phaseRemainingMs,  int phaseDurationMs,  int totalElapsedMs,  bool isRunning,  bool isPaused)?  $default,) {final _that = this;
switch (_that) {
case _TimerSnapshot() when $default != null:
return $default(_that.preset,_that.phase,_that.currentRound,_that.currentSet,_that.phaseRemainingMs,_that.phaseDurationMs,_that.totalElapsedMs,_that.isRunning,_that.isPaused);case _:
  return null;

}
}

}

/// @nodoc


class _TimerSnapshot extends TimerSnapshot {
  const _TimerSnapshot({this.preset, this.phase = TimerPhase.idle, this.currentRound = 1, this.currentSet = 1, this.phaseRemainingMs = 0, this.phaseDurationMs = 0, this.totalElapsedMs = 0, this.isRunning = false, this.isPaused = false}): super._();
  

@override final  TabataPreset? preset;
@override@JsonKey() final  TimerPhase phase;
@override@JsonKey() final  int currentRound;
@override@JsonKey() final  int currentSet;
@override@JsonKey() final  int phaseRemainingMs;
@override@JsonKey() final  int phaseDurationMs;
@override@JsonKey() final  int totalElapsedMs;
@override@JsonKey() final  bool isRunning;
@override@JsonKey() final  bool isPaused;

/// Create a copy of TimerSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimerSnapshotCopyWith<_TimerSnapshot> get copyWith => __$TimerSnapshotCopyWithImpl<_TimerSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimerSnapshot&&(identical(other.preset, preset) || other.preset == preset)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.currentRound, currentRound) || other.currentRound == currentRound)&&(identical(other.currentSet, currentSet) || other.currentSet == currentSet)&&(identical(other.phaseRemainingMs, phaseRemainingMs) || other.phaseRemainingMs == phaseRemainingMs)&&(identical(other.phaseDurationMs, phaseDurationMs) || other.phaseDurationMs == phaseDurationMs)&&(identical(other.totalElapsedMs, totalElapsedMs) || other.totalElapsedMs == totalElapsedMs)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused));
}


@override
int get hashCode => Object.hash(runtimeType,preset,phase,currentRound,currentSet,phaseRemainingMs,phaseDurationMs,totalElapsedMs,isRunning,isPaused);

@override
String toString() {
  return 'TimerSnapshot(preset: $preset, phase: $phase, currentRound: $currentRound, currentSet: $currentSet, phaseRemainingMs: $phaseRemainingMs, phaseDurationMs: $phaseDurationMs, totalElapsedMs: $totalElapsedMs, isRunning: $isRunning, isPaused: $isPaused)';
}


}

/// @nodoc
abstract mixin class _$TimerSnapshotCopyWith<$Res> implements $TimerSnapshotCopyWith<$Res> {
  factory _$TimerSnapshotCopyWith(_TimerSnapshot value, $Res Function(_TimerSnapshot) _then) = __$TimerSnapshotCopyWithImpl;
@override @useResult
$Res call({
 TabataPreset? preset, TimerPhase phase, int currentRound, int currentSet, int phaseRemainingMs, int phaseDurationMs, int totalElapsedMs, bool isRunning, bool isPaused
});


@override $TabataPresetCopyWith<$Res>? get preset;

}
/// @nodoc
class __$TimerSnapshotCopyWithImpl<$Res>
    implements _$TimerSnapshotCopyWith<$Res> {
  __$TimerSnapshotCopyWithImpl(this._self, this._then);

  final _TimerSnapshot _self;
  final $Res Function(_TimerSnapshot) _then;

/// Create a copy of TimerSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? preset = freezed,Object? phase = null,Object? currentRound = null,Object? currentSet = null,Object? phaseRemainingMs = null,Object? phaseDurationMs = null,Object? totalElapsedMs = null,Object? isRunning = null,Object? isPaused = null,}) {
  return _then(_TimerSnapshot(
preset: freezed == preset ? _self.preset : preset // ignore: cast_nullable_to_non_nullable
as TabataPreset?,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as TimerPhase,currentRound: null == currentRound ? _self.currentRound : currentRound // ignore: cast_nullable_to_non_nullable
as int,currentSet: null == currentSet ? _self.currentSet : currentSet // ignore: cast_nullable_to_non_nullable
as int,phaseRemainingMs: null == phaseRemainingMs ? _self.phaseRemainingMs : phaseRemainingMs // ignore: cast_nullable_to_non_nullable
as int,phaseDurationMs: null == phaseDurationMs ? _self.phaseDurationMs : phaseDurationMs // ignore: cast_nullable_to_non_nullable
as int,totalElapsedMs: null == totalElapsedMs ? _self.totalElapsedMs : totalElapsedMs // ignore: cast_nullable_to_non_nullable
as int,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of TimerSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TabataPresetCopyWith<$Res>? get preset {
    if (_self.preset == null) {
    return null;
  }

  return $TabataPresetCopyWith<$Res>(_self.preset!, (value) {
    return _then(_self.copyWith(preset: value));
  });
}
}

// dart format on
