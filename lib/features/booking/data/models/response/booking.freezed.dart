// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Booking {

 int get id;@JsonKey(name: 'therapist_id') int get therapistId;@JsonKey(name: 'slot_id') int get slotId;@JsonKey(name: 'patient_name') String get patientName;@JsonKey(name: 'patient_email') String get patientEmail;@JsonKey(name: 'patient_phone') String get patientPhone; String get treatment; String get location; String get status;@JsonKey(name: 'slot_date') DateTime get slotDate;@JsonKey(name: 'start_time') String get startTime;@JsonKey(name: 'end_time') String get endTime;@JsonKey(name: 'therapist_notes') String? get therapistNotes;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingCopyWith<Booking> get copyWith => _$BookingCopyWithImpl<Booking>(this as Booking, _$identity);

  /// Serializes this Booking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.therapistId, therapistId) || other.therapistId == therapistId)&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.patientName, patientName) || other.patientName == patientName)&&(identical(other.patientEmail, patientEmail) || other.patientEmail == patientEmail)&&(identical(other.patientPhone, patientPhone) || other.patientPhone == patientPhone)&&(identical(other.treatment, treatment) || other.treatment == treatment)&&(identical(other.location, location) || other.location == location)&&(identical(other.status, status) || other.status == status)&&(identical(other.slotDate, slotDate) || other.slotDate == slotDate)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.therapistNotes, therapistNotes) || other.therapistNotes == therapistNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,therapistId,slotId,patientName,patientEmail,patientPhone,treatment,location,status,slotDate,startTime,endTime,therapistNotes,createdAt,updatedAt);

@override
String toString() {
  return 'Booking(id: $id, therapistId: $therapistId, slotId: $slotId, patientName: $patientName, patientEmail: $patientEmail, patientPhone: $patientPhone, treatment: $treatment, location: $location, status: $status, slotDate: $slotDate, startTime: $startTime, endTime: $endTime, therapistNotes: $therapistNotes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BookingCopyWith<$Res>  {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) _then) = _$BookingCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'therapist_id') int therapistId,@JsonKey(name: 'slot_id') int slotId,@JsonKey(name: 'patient_name') String patientName,@JsonKey(name: 'patient_email') String patientEmail,@JsonKey(name: 'patient_phone') String patientPhone, String treatment, String location, String status,@JsonKey(name: 'slot_date') DateTime slotDate,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'end_time') String endTime,@JsonKey(name: 'therapist_notes') String? therapistNotes,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$BookingCopyWithImpl<$Res>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._self, this._then);

  final Booking _self;
  final $Res Function(Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? therapistId = null,Object? slotId = null,Object? patientName = null,Object? patientEmail = null,Object? patientPhone = null,Object? treatment = null,Object? location = null,Object? status = null,Object? slotDate = null,Object? startTime = null,Object? endTime = null,Object? therapistNotes = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,therapistId: null == therapistId ? _self.therapistId : therapistId // ignore: cast_nullable_to_non_nullable
as int,slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as int,patientName: null == patientName ? _self.patientName : patientName // ignore: cast_nullable_to_non_nullable
as String,patientEmail: null == patientEmail ? _self.patientEmail : patientEmail // ignore: cast_nullable_to_non_nullable
as String,patientPhone: null == patientPhone ? _self.patientPhone : patientPhone // ignore: cast_nullable_to_non_nullable
as String,treatment: null == treatment ? _self.treatment : treatment // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,slotDate: null == slotDate ? _self.slotDate : slotDate // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,therapistNotes: freezed == therapistNotes ? _self.therapistNotes : therapistNotes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Booking].
extension BookingPatterns on Booking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Booking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Booking value)  $default,){
final _that = this;
switch (_that) {
case _Booking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Booking value)?  $default,){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'therapist_id')  int therapistId, @JsonKey(name: 'slot_id')  int slotId, @JsonKey(name: 'patient_name')  String patientName, @JsonKey(name: 'patient_email')  String patientEmail, @JsonKey(name: 'patient_phone')  String patientPhone,  String treatment,  String location,  String status, @JsonKey(name: 'slot_date')  DateTime slotDate, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime, @JsonKey(name: 'therapist_notes')  String? therapistNotes, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.therapistId,_that.slotId,_that.patientName,_that.patientEmail,_that.patientPhone,_that.treatment,_that.location,_that.status,_that.slotDate,_that.startTime,_that.endTime,_that.therapistNotes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'therapist_id')  int therapistId, @JsonKey(name: 'slot_id')  int slotId, @JsonKey(name: 'patient_name')  String patientName, @JsonKey(name: 'patient_email')  String patientEmail, @JsonKey(name: 'patient_phone')  String patientPhone,  String treatment,  String location,  String status, @JsonKey(name: 'slot_date')  DateTime slotDate, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime, @JsonKey(name: 'therapist_notes')  String? therapistNotes, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Booking():
return $default(_that.id,_that.therapistId,_that.slotId,_that.patientName,_that.patientEmail,_that.patientPhone,_that.treatment,_that.location,_that.status,_that.slotDate,_that.startTime,_that.endTime,_that.therapistNotes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'therapist_id')  int therapistId, @JsonKey(name: 'slot_id')  int slotId, @JsonKey(name: 'patient_name')  String patientName, @JsonKey(name: 'patient_email')  String patientEmail, @JsonKey(name: 'patient_phone')  String patientPhone,  String treatment,  String location,  String status, @JsonKey(name: 'slot_date')  DateTime slotDate, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime, @JsonKey(name: 'therapist_notes')  String? therapistNotes, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.therapistId,_that.slotId,_that.patientName,_that.patientEmail,_that.patientPhone,_that.treatment,_that.location,_that.status,_that.slotDate,_that.startTime,_that.endTime,_that.therapistNotes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Booking implements Booking {
  const _Booking({required this.id, @JsonKey(name: 'therapist_id') required this.therapistId, @JsonKey(name: 'slot_id') required this.slotId, @JsonKey(name: 'patient_name') required this.patientName, @JsonKey(name: 'patient_email') required this.patientEmail, @JsonKey(name: 'patient_phone') required this.patientPhone, required this.treatment, required this.location, required this.status, @JsonKey(name: 'slot_date') required this.slotDate, @JsonKey(name: 'start_time') required this.startTime, @JsonKey(name: 'end_time') required this.endTime, @JsonKey(name: 'therapist_notes') this.therapistNotes, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

@override final  int id;
@override@JsonKey(name: 'therapist_id') final  int therapistId;
@override@JsonKey(name: 'slot_id') final  int slotId;
@override@JsonKey(name: 'patient_name') final  String patientName;
@override@JsonKey(name: 'patient_email') final  String patientEmail;
@override@JsonKey(name: 'patient_phone') final  String patientPhone;
@override final  String treatment;
@override final  String location;
@override final  String status;
@override@JsonKey(name: 'slot_date') final  DateTime slotDate;
@override@JsonKey(name: 'start_time') final  String startTime;
@override@JsonKey(name: 'end_time') final  String endTime;
@override@JsonKey(name: 'therapist_notes') final  String? therapistNotes;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingCopyWith<_Booking> get copyWith => __$BookingCopyWithImpl<_Booking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.therapistId, therapistId) || other.therapistId == therapistId)&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.patientName, patientName) || other.patientName == patientName)&&(identical(other.patientEmail, patientEmail) || other.patientEmail == patientEmail)&&(identical(other.patientPhone, patientPhone) || other.patientPhone == patientPhone)&&(identical(other.treatment, treatment) || other.treatment == treatment)&&(identical(other.location, location) || other.location == location)&&(identical(other.status, status) || other.status == status)&&(identical(other.slotDate, slotDate) || other.slotDate == slotDate)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.therapistNotes, therapistNotes) || other.therapistNotes == therapistNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,therapistId,slotId,patientName,patientEmail,patientPhone,treatment,location,status,slotDate,startTime,endTime,therapistNotes,createdAt,updatedAt);

@override
String toString() {
  return 'Booking(id: $id, therapistId: $therapistId, slotId: $slotId, patientName: $patientName, patientEmail: $patientEmail, patientPhone: $patientPhone, treatment: $treatment, location: $location, status: $status, slotDate: $slotDate, startTime: $startTime, endTime: $endTime, therapistNotes: $therapistNotes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BookingCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$BookingCopyWith(_Booking value, $Res Function(_Booking) _then) = __$BookingCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'therapist_id') int therapistId,@JsonKey(name: 'slot_id') int slotId,@JsonKey(name: 'patient_name') String patientName,@JsonKey(name: 'patient_email') String patientEmail,@JsonKey(name: 'patient_phone') String patientPhone, String treatment, String location, String status,@JsonKey(name: 'slot_date') DateTime slotDate,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'end_time') String endTime,@JsonKey(name: 'therapist_notes') String? therapistNotes,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$BookingCopyWithImpl<$Res>
    implements _$BookingCopyWith<$Res> {
  __$BookingCopyWithImpl(this._self, this._then);

  final _Booking _self;
  final $Res Function(_Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? therapistId = null,Object? slotId = null,Object? patientName = null,Object? patientEmail = null,Object? patientPhone = null,Object? treatment = null,Object? location = null,Object? status = null,Object? slotDate = null,Object? startTime = null,Object? endTime = null,Object? therapistNotes = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Booking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,therapistId: null == therapistId ? _self.therapistId : therapistId // ignore: cast_nullable_to_non_nullable
as int,slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as int,patientName: null == patientName ? _self.patientName : patientName // ignore: cast_nullable_to_non_nullable
as String,patientEmail: null == patientEmail ? _self.patientEmail : patientEmail // ignore: cast_nullable_to_non_nullable
as String,patientPhone: null == patientPhone ? _self.patientPhone : patientPhone // ignore: cast_nullable_to_non_nullable
as String,treatment: null == treatment ? _self.treatment : treatment // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,slotDate: null == slotDate ? _self.slotDate : slotDate // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,therapistNotes: freezed == therapistNotes ? _self.therapistNotes : therapistNotes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
