// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'available_therapist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AvailableTherapist {

 int get id; String get name; String get username;@JsonKey(name: 'profile_image_url') String? get profileImageUrl;@JsonKey(name: 'experience_years') int? get experienceYears; String? get specialization; String? get address; List<AvailableSlot> get slots;
/// Create a copy of AvailableTherapist
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailableTherapistCopyWith<AvailableTherapist> get copyWith => _$AvailableTherapistCopyWithImpl<AvailableTherapist>(this as AvailableTherapist, _$identity);

  /// Serializes this AvailableTherapist to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailableTherapist&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.specialization, specialization) || other.specialization == specialization)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other.slots, slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,username,profileImageUrl,experienceYears,specialization,address,const DeepCollectionEquality().hash(slots));

@override
String toString() {
  return 'AvailableTherapist(id: $id, name: $name, username: $username, profileImageUrl: $profileImageUrl, experienceYears: $experienceYears, specialization: $specialization, address: $address, slots: $slots)';
}


}

/// @nodoc
abstract mixin class $AvailableTherapistCopyWith<$Res>  {
  factory $AvailableTherapistCopyWith(AvailableTherapist value, $Res Function(AvailableTherapist) _then) = _$AvailableTherapistCopyWithImpl;
@useResult
$Res call({
 int id, String name, String username,@JsonKey(name: 'profile_image_url') String? profileImageUrl,@JsonKey(name: 'experience_years') int? experienceYears, String? specialization, String? address, List<AvailableSlot> slots
});




}
/// @nodoc
class _$AvailableTherapistCopyWithImpl<$Res>
    implements $AvailableTherapistCopyWith<$Res> {
  _$AvailableTherapistCopyWithImpl(this._self, this._then);

  final AvailableTherapist _self;
  final $Res Function(AvailableTherapist) _then;

/// Create a copy of AvailableTherapist
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? username = null,Object? profileImageUrl = freezed,Object? experienceYears = freezed,Object? specialization = freezed,Object? address = freezed,Object? slots = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,experienceYears: freezed == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int?,specialization: freezed == specialization ? _self.specialization : specialization // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<AvailableSlot>,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailableTherapist].
extension AvailableTherapistPatterns on AvailableTherapist {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailableTherapist value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailableTherapist() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailableTherapist value)  $default,){
final _that = this;
switch (_that) {
case _AvailableTherapist():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailableTherapist value)?  $default,){
final _that = this;
switch (_that) {
case _AvailableTherapist() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String username, @JsonKey(name: 'profile_image_url')  String? profileImageUrl, @JsonKey(name: 'experience_years')  int? experienceYears,  String? specialization,  String? address,  List<AvailableSlot> slots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailableTherapist() when $default != null:
return $default(_that.id,_that.name,_that.username,_that.profileImageUrl,_that.experienceYears,_that.specialization,_that.address,_that.slots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String username, @JsonKey(name: 'profile_image_url')  String? profileImageUrl, @JsonKey(name: 'experience_years')  int? experienceYears,  String? specialization,  String? address,  List<AvailableSlot> slots)  $default,) {final _that = this;
switch (_that) {
case _AvailableTherapist():
return $default(_that.id,_that.name,_that.username,_that.profileImageUrl,_that.experienceYears,_that.specialization,_that.address,_that.slots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String username, @JsonKey(name: 'profile_image_url')  String? profileImageUrl, @JsonKey(name: 'experience_years')  int? experienceYears,  String? specialization,  String? address,  List<AvailableSlot> slots)?  $default,) {final _that = this;
switch (_that) {
case _AvailableTherapist() when $default != null:
return $default(_that.id,_that.name,_that.username,_that.profileImageUrl,_that.experienceYears,_that.specialization,_that.address,_that.slots);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailableTherapist implements AvailableTherapist {
  const _AvailableTherapist({required this.id, required this.name, required this.username, @JsonKey(name: 'profile_image_url') this.profileImageUrl, @JsonKey(name: 'experience_years') this.experienceYears, this.specialization, this.address, final  List<AvailableSlot> slots = const []}): _slots = slots;
  factory _AvailableTherapist.fromJson(Map<String, dynamic> json) => _$AvailableTherapistFromJson(json);

@override final  int id;
@override final  String name;
@override final  String username;
@override@JsonKey(name: 'profile_image_url') final  String? profileImageUrl;
@override@JsonKey(name: 'experience_years') final  int? experienceYears;
@override final  String? specialization;
@override final  String? address;
 final  List<AvailableSlot> _slots;
@override@JsonKey() List<AvailableSlot> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}


/// Create a copy of AvailableTherapist
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailableTherapistCopyWith<_AvailableTherapist> get copyWith => __$AvailableTherapistCopyWithImpl<_AvailableTherapist>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailableTherapistToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailableTherapist&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.specialization, specialization) || other.specialization == specialization)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other._slots, _slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,username,profileImageUrl,experienceYears,specialization,address,const DeepCollectionEquality().hash(_slots));

@override
String toString() {
  return 'AvailableTherapist(id: $id, name: $name, username: $username, profileImageUrl: $profileImageUrl, experienceYears: $experienceYears, specialization: $specialization, address: $address, slots: $slots)';
}


}

/// @nodoc
abstract mixin class _$AvailableTherapistCopyWith<$Res> implements $AvailableTherapistCopyWith<$Res> {
  factory _$AvailableTherapistCopyWith(_AvailableTherapist value, $Res Function(_AvailableTherapist) _then) = __$AvailableTherapistCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String username,@JsonKey(name: 'profile_image_url') String? profileImageUrl,@JsonKey(name: 'experience_years') int? experienceYears, String? specialization, String? address, List<AvailableSlot> slots
});




}
/// @nodoc
class __$AvailableTherapistCopyWithImpl<$Res>
    implements _$AvailableTherapistCopyWith<$Res> {
  __$AvailableTherapistCopyWithImpl(this._self, this._then);

  final _AvailableTherapist _self;
  final $Res Function(_AvailableTherapist) _then;

/// Create a copy of AvailableTherapist
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? username = null,Object? profileImageUrl = freezed,Object? experienceYears = freezed,Object? specialization = freezed,Object? address = freezed,Object? slots = null,}) {
  return _then(_AvailableTherapist(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,experienceYears: freezed == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int?,specialization: freezed == specialization ? _self.specialization : specialization // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<AvailableSlot>,
  ));
}


}


/// @nodoc
mixin _$AvailableSlot {

 int get id;@JsonKey(name: 'slot_date') DateTime get slotDate;@JsonKey(name: 'start_time') String get startTime;@JsonKey(name: 'end_time') String get endTime;
/// Create a copy of AvailableSlot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailableSlotCopyWith<AvailableSlot> get copyWith => _$AvailableSlotCopyWithImpl<AvailableSlot>(this as AvailableSlot, _$identity);

  /// Serializes this AvailableSlot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailableSlot&&(identical(other.id, id) || other.id == id)&&(identical(other.slotDate, slotDate) || other.slotDate == slotDate)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slotDate,startTime,endTime);

@override
String toString() {
  return 'AvailableSlot(id: $id, slotDate: $slotDate, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $AvailableSlotCopyWith<$Res>  {
  factory $AvailableSlotCopyWith(AvailableSlot value, $Res Function(AvailableSlot) _then) = _$AvailableSlotCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'slot_date') DateTime slotDate,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'end_time') String endTime
});




}
/// @nodoc
class _$AvailableSlotCopyWithImpl<$Res>
    implements $AvailableSlotCopyWith<$Res> {
  _$AvailableSlotCopyWithImpl(this._self, this._then);

  final AvailableSlot _self;
  final $Res Function(AvailableSlot) _then;

/// Create a copy of AvailableSlot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slotDate = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slotDate: null == slotDate ? _self.slotDate : slotDate // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailableSlot].
extension AvailableSlotPatterns on AvailableSlot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailableSlot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailableSlot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailableSlot value)  $default,){
final _that = this;
switch (_that) {
case _AvailableSlot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailableSlot value)?  $default,){
final _that = this;
switch (_that) {
case _AvailableSlot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'slot_date')  DateTime slotDate, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailableSlot() when $default != null:
return $default(_that.id,_that.slotDate,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'slot_date')  DateTime slotDate, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime)  $default,) {final _that = this;
switch (_that) {
case _AvailableSlot():
return $default(_that.id,_that.slotDate,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'slot_date')  DateTime slotDate, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime)?  $default,) {final _that = this;
switch (_that) {
case _AvailableSlot() when $default != null:
return $default(_that.id,_that.slotDate,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailableSlot implements AvailableSlot {
  const _AvailableSlot({required this.id, @JsonKey(name: 'slot_date') required this.slotDate, @JsonKey(name: 'start_time') required this.startTime, @JsonKey(name: 'end_time') required this.endTime});
  factory _AvailableSlot.fromJson(Map<String, dynamic> json) => _$AvailableSlotFromJson(json);

@override final  int id;
@override@JsonKey(name: 'slot_date') final  DateTime slotDate;
@override@JsonKey(name: 'start_time') final  String startTime;
@override@JsonKey(name: 'end_time') final  String endTime;

/// Create a copy of AvailableSlot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailableSlotCopyWith<_AvailableSlot> get copyWith => __$AvailableSlotCopyWithImpl<_AvailableSlot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailableSlotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailableSlot&&(identical(other.id, id) || other.id == id)&&(identical(other.slotDate, slotDate) || other.slotDate == slotDate)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slotDate,startTime,endTime);

@override
String toString() {
  return 'AvailableSlot(id: $id, slotDate: $slotDate, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$AvailableSlotCopyWith<$Res> implements $AvailableSlotCopyWith<$Res> {
  factory _$AvailableSlotCopyWith(_AvailableSlot value, $Res Function(_AvailableSlot) _then) = __$AvailableSlotCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'slot_date') DateTime slotDate,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'end_time') String endTime
});




}
/// @nodoc
class __$AvailableSlotCopyWithImpl<$Res>
    implements _$AvailableSlotCopyWith<$Res> {
  __$AvailableSlotCopyWithImpl(this._self, this._then);

  final _AvailableSlot _self;
  final $Res Function(_AvailableSlot) _then;

/// Create a copy of AvailableSlot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slotDate = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_AvailableSlot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slotDate: null == slotDate ? _self.slotDate : slotDate // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
