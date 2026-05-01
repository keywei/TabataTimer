// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkoutHistoryEntry {

 String get id; String get presetName; DateTime get startedAt; DateTime get completedAt; int get durationSeconds; int get totalRounds; int get totalSets; bool get completed;
/// Create a copy of WorkoutHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutHistoryEntryCopyWith<WorkoutHistoryEntry> get copyWith => _$WorkoutHistoryEntryCopyWithImpl<WorkoutHistoryEntry>(this as WorkoutHistoryEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutHistoryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.presetName, presetName) || other.presetName == presetName)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.totalRounds, totalRounds) || other.totalRounds == totalRounds)&&(identical(other.totalSets, totalSets) || other.totalSets == totalSets)&&(identical(other.completed, completed) || other.completed == completed));
}


@override
int get hashCode => Object.hash(runtimeType,id,presetName,startedAt,completedAt,durationSeconds,totalRounds,totalSets,completed);

@override
String toString() {
  return 'WorkoutHistoryEntry(id: $id, presetName: $presetName, startedAt: $startedAt, completedAt: $completedAt, durationSeconds: $durationSeconds, totalRounds: $totalRounds, totalSets: $totalSets, completed: $completed)';
}


}

/// @nodoc
abstract mixin class $WorkoutHistoryEntryCopyWith<$Res>  {
  factory $WorkoutHistoryEntryCopyWith(WorkoutHistoryEntry value, $Res Function(WorkoutHistoryEntry) _then) = _$WorkoutHistoryEntryCopyWithImpl;
@useResult
$Res call({
 String id, String presetName, DateTime startedAt, DateTime completedAt, int durationSeconds, int totalRounds, int totalSets, bool completed
});




}
/// @nodoc
class _$WorkoutHistoryEntryCopyWithImpl<$Res>
    implements $WorkoutHistoryEntryCopyWith<$Res> {
  _$WorkoutHistoryEntryCopyWithImpl(this._self, this._then);

  final WorkoutHistoryEntry _self;
  final $Res Function(WorkoutHistoryEntry) _then;

/// Create a copy of WorkoutHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? presetName = null,Object? startedAt = null,Object? completedAt = null,Object? durationSeconds = null,Object? totalRounds = null,Object? totalSets = null,Object? completed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,presetName: null == presetName ? _self.presetName : presetName // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,totalRounds: null == totalRounds ? _self.totalRounds : totalRounds // ignore: cast_nullable_to_non_nullable
as int,totalSets: null == totalSets ? _self.totalSets : totalSets // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutHistoryEntry].
extension WorkoutHistoryEntryPatterns on WorkoutHistoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutHistoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutHistoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutHistoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutHistoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String presetName,  DateTime startedAt,  DateTime completedAt,  int durationSeconds,  int totalRounds,  int totalSets,  bool completed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutHistoryEntry() when $default != null:
return $default(_that.id,_that.presetName,_that.startedAt,_that.completedAt,_that.durationSeconds,_that.totalRounds,_that.totalSets,_that.completed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String presetName,  DateTime startedAt,  DateTime completedAt,  int durationSeconds,  int totalRounds,  int totalSets,  bool completed)  $default,) {final _that = this;
switch (_that) {
case _WorkoutHistoryEntry():
return $default(_that.id,_that.presetName,_that.startedAt,_that.completedAt,_that.durationSeconds,_that.totalRounds,_that.totalSets,_that.completed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String presetName,  DateTime startedAt,  DateTime completedAt,  int durationSeconds,  int totalRounds,  int totalSets,  bool completed)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutHistoryEntry() when $default != null:
return $default(_that.id,_that.presetName,_that.startedAt,_that.completedAt,_that.durationSeconds,_that.totalRounds,_that.totalSets,_that.completed);case _:
  return null;

}
}

}

/// @nodoc


class _WorkoutHistoryEntry implements WorkoutHistoryEntry {
  const _WorkoutHistoryEntry({required this.id, required this.presetName, required this.startedAt, required this.completedAt, required this.durationSeconds, required this.totalRounds, required this.totalSets, this.completed = true});
  

@override final  String id;
@override final  String presetName;
@override final  DateTime startedAt;
@override final  DateTime completedAt;
@override final  int durationSeconds;
@override final  int totalRounds;
@override final  int totalSets;
@override@JsonKey() final  bool completed;

/// Create a copy of WorkoutHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutHistoryEntryCopyWith<_WorkoutHistoryEntry> get copyWith => __$WorkoutHistoryEntryCopyWithImpl<_WorkoutHistoryEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutHistoryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.presetName, presetName) || other.presetName == presetName)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.totalRounds, totalRounds) || other.totalRounds == totalRounds)&&(identical(other.totalSets, totalSets) || other.totalSets == totalSets)&&(identical(other.completed, completed) || other.completed == completed));
}


@override
int get hashCode => Object.hash(runtimeType,id,presetName,startedAt,completedAt,durationSeconds,totalRounds,totalSets,completed);

@override
String toString() {
  return 'WorkoutHistoryEntry(id: $id, presetName: $presetName, startedAt: $startedAt, completedAt: $completedAt, durationSeconds: $durationSeconds, totalRounds: $totalRounds, totalSets: $totalSets, completed: $completed)';
}


}

/// @nodoc
abstract mixin class _$WorkoutHistoryEntryCopyWith<$Res> implements $WorkoutHistoryEntryCopyWith<$Res> {
  factory _$WorkoutHistoryEntryCopyWith(_WorkoutHistoryEntry value, $Res Function(_WorkoutHistoryEntry) _then) = __$WorkoutHistoryEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String presetName, DateTime startedAt, DateTime completedAt, int durationSeconds, int totalRounds, int totalSets, bool completed
});




}
/// @nodoc
class __$WorkoutHistoryEntryCopyWithImpl<$Res>
    implements _$WorkoutHistoryEntryCopyWith<$Res> {
  __$WorkoutHistoryEntryCopyWithImpl(this._self, this._then);

  final _WorkoutHistoryEntry _self;
  final $Res Function(_WorkoutHistoryEntry) _then;

/// Create a copy of WorkoutHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? presetName = null,Object? startedAt = null,Object? completedAt = null,Object? durationSeconds = null,Object? totalRounds = null,Object? totalSets = null,Object? completed = null,}) {
  return _then(_WorkoutHistoryEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,presetName: null == presetName ? _self.presetName : presetName // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,totalRounds: null == totalRounds ? _self.totalRounds : totalRounds // ignore: cast_nullable_to_non_nullable
as int,totalSets: null == totalSets ? _self.totalSets : totalSets // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
