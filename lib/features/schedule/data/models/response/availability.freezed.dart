// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'availability.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScheduleAvailability {

@JsonKey(name: 'is_available') bool get isAvailable;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of ScheduleAvailability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleAvailabilityCopyWith<ScheduleAvailability> get copyWith => _$ScheduleAvailabilityCopyWithImpl<ScheduleAvailability>(this as ScheduleAvailability, _$identity);

  /// Serializes this ScheduleAvailability to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleAvailability&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAvailable,updatedAt);

@override
String toString() {
  return 'ScheduleAvailability(isAvailable: $isAvailable, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ScheduleAvailabilityCopyWith<$Res>  {
  factory $ScheduleAvailabilityCopyWith(ScheduleAvailability value, $Res Function(ScheduleAvailability) _then) = _$ScheduleAvailabilityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'is_available') bool isAvailable,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$ScheduleAvailabilityCopyWithImpl<$Res>
    implements $ScheduleAvailabilityCopyWith<$Res> {
  _$ScheduleAvailabilityCopyWithImpl(this._self, this._then);

  final ScheduleAvailability _self;
  final $Res Function(ScheduleAvailability) _then;

/// Create a copy of ScheduleAvailability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAvailable = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleAvailability].
extension ScheduleAvailabilityPatterns on ScheduleAvailability {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleAvailability value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleAvailability() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleAvailability value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleAvailability():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleAvailability value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleAvailability() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_available')  bool isAvailable, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleAvailability() when $default != null:
return $default(_that.isAvailable,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_available')  bool isAvailable, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ScheduleAvailability():
return $default(_that.isAvailable,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'is_available')  bool isAvailable, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleAvailability() when $default != null:
return $default(_that.isAvailable,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduleAvailability implements ScheduleAvailability {
  const _ScheduleAvailability({@JsonKey(name: 'is_available') required this.isAvailable, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _ScheduleAvailability.fromJson(Map<String, dynamic> json) => _$ScheduleAvailabilityFromJson(json);

@override@JsonKey(name: 'is_available') final  bool isAvailable;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of ScheduleAvailability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleAvailabilityCopyWith<_ScheduleAvailability> get copyWith => __$ScheduleAvailabilityCopyWithImpl<_ScheduleAvailability>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduleAvailabilityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleAvailability&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAvailable,updatedAt);

@override
String toString() {
  return 'ScheduleAvailability(isAvailable: $isAvailable, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ScheduleAvailabilityCopyWith<$Res> implements $ScheduleAvailabilityCopyWith<$Res> {
  factory _$ScheduleAvailabilityCopyWith(_ScheduleAvailability value, $Res Function(_ScheduleAvailability) _then) = __$ScheduleAvailabilityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'is_available') bool isAvailable,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$ScheduleAvailabilityCopyWithImpl<$Res>
    implements _$ScheduleAvailabilityCopyWith<$Res> {
  __$ScheduleAvailabilityCopyWithImpl(this._self, this._then);

  final _ScheduleAvailability _self;
  final $Res Function(_ScheduleAvailability) _then;

/// Create a copy of ScheduleAvailability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAvailable = null,Object? updatedAt = null,}) {
  return _then(_ScheduleAvailability(
isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
