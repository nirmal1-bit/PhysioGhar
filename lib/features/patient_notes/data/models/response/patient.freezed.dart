// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Patient {

 int get id;@JsonKey(name: 'therapist_id') int get therapistId; String get name; int? get age; String? get gender; String? get email; String? get phone; String get condition;@JsonKey(name: 'last_session_date') DateTime? get lastSessionDate; List<PatientSession> get sessions; List<PatientNote> get notes;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of Patient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientCopyWith<Patient> get copyWith => _$PatientCopyWithImpl<Patient>(this as Patient, _$identity);

  /// Serializes this Patient to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Patient&&(identical(other.id, id) || other.id == id)&&(identical(other.therapistId, therapistId) || other.therapistId == therapistId)&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.lastSessionDate, lastSessionDate) || other.lastSessionDate == lastSessionDate)&&const DeepCollectionEquality().equals(other.sessions, sessions)&&const DeepCollectionEquality().equals(other.notes, notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,therapistId,name,age,gender,email,phone,condition,lastSessionDate,const DeepCollectionEquality().hash(sessions),const DeepCollectionEquality().hash(notes),createdAt,updatedAt);

@override
String toString() {
  return 'Patient(id: $id, therapistId: $therapistId, name: $name, age: $age, gender: $gender, email: $email, phone: $phone, condition: $condition, lastSessionDate: $lastSessionDate, sessions: $sessions, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PatientCopyWith<$Res>  {
  factory $PatientCopyWith(Patient value, $Res Function(Patient) _then) = _$PatientCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'therapist_id') int therapistId, String name, int? age, String? gender, String? email, String? phone, String condition,@JsonKey(name: 'last_session_date') DateTime? lastSessionDate, List<PatientSession> sessions, List<PatientNote> notes,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$PatientCopyWithImpl<$Res>
    implements $PatientCopyWith<$Res> {
  _$PatientCopyWithImpl(this._self, this._then);

  final Patient _self;
  final $Res Function(Patient) _then;

/// Create a copy of Patient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? therapistId = null,Object? name = null,Object? age = freezed,Object? gender = freezed,Object? email = freezed,Object? phone = freezed,Object? condition = null,Object? lastSessionDate = freezed,Object? sessions = null,Object? notes = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,therapistId: null == therapistId ? _self.therapistId : therapistId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,lastSessionDate: freezed == lastSessionDate ? _self.lastSessionDate : lastSessionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<PatientSession>,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<PatientNote>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Patient].
extension PatientPatterns on Patient {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Patient value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Patient() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Patient value)  $default,){
final _that = this;
switch (_that) {
case _Patient():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Patient value)?  $default,){
final _that = this;
switch (_that) {
case _Patient() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'therapist_id')  int therapistId,  String name,  int? age,  String? gender,  String? email,  String? phone,  String condition, @JsonKey(name: 'last_session_date')  DateTime? lastSessionDate,  List<PatientSession> sessions,  List<PatientNote> notes, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Patient() when $default != null:
return $default(_that.id,_that.therapistId,_that.name,_that.age,_that.gender,_that.email,_that.phone,_that.condition,_that.lastSessionDate,_that.sessions,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'therapist_id')  int therapistId,  String name,  int? age,  String? gender,  String? email,  String? phone,  String condition, @JsonKey(name: 'last_session_date')  DateTime? lastSessionDate,  List<PatientSession> sessions,  List<PatientNote> notes, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Patient():
return $default(_that.id,_that.therapistId,_that.name,_that.age,_that.gender,_that.email,_that.phone,_that.condition,_that.lastSessionDate,_that.sessions,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'therapist_id')  int therapistId,  String name,  int? age,  String? gender,  String? email,  String? phone,  String condition, @JsonKey(name: 'last_session_date')  DateTime? lastSessionDate,  List<PatientSession> sessions,  List<PatientNote> notes, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Patient() when $default != null:
return $default(_that.id,_that.therapistId,_that.name,_that.age,_that.gender,_that.email,_that.phone,_that.condition,_that.lastSessionDate,_that.sessions,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Patient implements Patient {
  const _Patient({required this.id, @JsonKey(name: 'therapist_id') required this.therapistId, required this.name, this.age, this.gender, this.email, this.phone, required this.condition, @JsonKey(name: 'last_session_date') this.lastSessionDate, final  List<PatientSession> sessions = const [], final  List<PatientNote> notes = const [], @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): _sessions = sessions,_notes = notes;
  factory _Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);

@override final  int id;
@override@JsonKey(name: 'therapist_id') final  int therapistId;
@override final  String name;
@override final  int? age;
@override final  String? gender;
@override final  String? email;
@override final  String? phone;
@override final  String condition;
@override@JsonKey(name: 'last_session_date') final  DateTime? lastSessionDate;
 final  List<PatientSession> _sessions;
@override@JsonKey() List<PatientSession> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}

 final  List<PatientNote> _notes;
@override@JsonKey() List<PatientNote> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}

@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of Patient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientCopyWith<_Patient> get copyWith => __$PatientCopyWithImpl<_Patient>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Patient&&(identical(other.id, id) || other.id == id)&&(identical(other.therapistId, therapistId) || other.therapistId == therapistId)&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.lastSessionDate, lastSessionDate) || other.lastSessionDate == lastSessionDate)&&const DeepCollectionEquality().equals(other._sessions, _sessions)&&const DeepCollectionEquality().equals(other._notes, _notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,therapistId,name,age,gender,email,phone,condition,lastSessionDate,const DeepCollectionEquality().hash(_sessions),const DeepCollectionEquality().hash(_notes),createdAt,updatedAt);

@override
String toString() {
  return 'Patient(id: $id, therapistId: $therapistId, name: $name, age: $age, gender: $gender, email: $email, phone: $phone, condition: $condition, lastSessionDate: $lastSessionDate, sessions: $sessions, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PatientCopyWith<$Res> implements $PatientCopyWith<$Res> {
  factory _$PatientCopyWith(_Patient value, $Res Function(_Patient) _then) = __$PatientCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'therapist_id') int therapistId, String name, int? age, String? gender, String? email, String? phone, String condition,@JsonKey(name: 'last_session_date') DateTime? lastSessionDate, List<PatientSession> sessions, List<PatientNote> notes,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$PatientCopyWithImpl<$Res>
    implements _$PatientCopyWith<$Res> {
  __$PatientCopyWithImpl(this._self, this._then);

  final _Patient _self;
  final $Res Function(_Patient) _then;

/// Create a copy of Patient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? therapistId = null,Object? name = null,Object? age = freezed,Object? gender = freezed,Object? email = freezed,Object? phone = freezed,Object? condition = null,Object? lastSessionDate = freezed,Object? sessions = null,Object? notes = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Patient(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,therapistId: null == therapistId ? _self.therapistId : therapistId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,lastSessionDate: freezed == lastSessionDate ? _self.lastSessionDate : lastSessionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<PatientSession>,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<PatientNote>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$PatientSession {

@JsonKey(name: 'booking_id') int get bookingId; String get treatment; String get location; String get status;@JsonKey(name: 'slot_date') DateTime get slotDate;@JsonKey(name: 'start_time') String get startTime;@JsonKey(name: 'end_time') String get endTime;
/// Create a copy of PatientSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientSessionCopyWith<PatientSession> get copyWith => _$PatientSessionCopyWithImpl<PatientSession>(this as PatientSession, _$identity);

  /// Serializes this PatientSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientSession&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.treatment, treatment) || other.treatment == treatment)&&(identical(other.location, location) || other.location == location)&&(identical(other.status, status) || other.status == status)&&(identical(other.slotDate, slotDate) || other.slotDate == slotDate)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookingId,treatment,location,status,slotDate,startTime,endTime);

@override
String toString() {
  return 'PatientSession(bookingId: $bookingId, treatment: $treatment, location: $location, status: $status, slotDate: $slotDate, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $PatientSessionCopyWith<$Res>  {
  factory $PatientSessionCopyWith(PatientSession value, $Res Function(PatientSession) _then) = _$PatientSessionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'booking_id') int bookingId, String treatment, String location, String status,@JsonKey(name: 'slot_date') DateTime slotDate,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'end_time') String endTime
});




}
/// @nodoc
class _$PatientSessionCopyWithImpl<$Res>
    implements $PatientSessionCopyWith<$Res> {
  _$PatientSessionCopyWithImpl(this._self, this._then);

  final PatientSession _self;
  final $Res Function(PatientSession) _then;

/// Create a copy of PatientSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookingId = null,Object? treatment = null,Object? location = null,Object? status = null,Object? slotDate = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_self.copyWith(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,treatment: null == treatment ? _self.treatment : treatment // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,slotDate: null == slotDate ? _self.slotDate : slotDate // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PatientSession].
extension PatientSessionPatterns on PatientSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatientSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatientSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatientSession value)  $default,){
final _that = this;
switch (_that) {
case _PatientSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatientSession value)?  $default,){
final _that = this;
switch (_that) {
case _PatientSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'booking_id')  int bookingId,  String treatment,  String location,  String status, @JsonKey(name: 'slot_date')  DateTime slotDate, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatientSession() when $default != null:
return $default(_that.bookingId,_that.treatment,_that.location,_that.status,_that.slotDate,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'booking_id')  int bookingId,  String treatment,  String location,  String status, @JsonKey(name: 'slot_date')  DateTime slotDate, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime)  $default,) {final _that = this;
switch (_that) {
case _PatientSession():
return $default(_that.bookingId,_that.treatment,_that.location,_that.status,_that.slotDate,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'booking_id')  int bookingId,  String treatment,  String location,  String status, @JsonKey(name: 'slot_date')  DateTime slotDate, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime)?  $default,) {final _that = this;
switch (_that) {
case _PatientSession() when $default != null:
return $default(_that.bookingId,_that.treatment,_that.location,_that.status,_that.slotDate,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PatientSession implements PatientSession {
  const _PatientSession({@JsonKey(name: 'booking_id') required this.bookingId, required this.treatment, required this.location, required this.status, @JsonKey(name: 'slot_date') required this.slotDate, @JsonKey(name: 'start_time') required this.startTime, @JsonKey(name: 'end_time') required this.endTime});
  factory _PatientSession.fromJson(Map<String, dynamic> json) => _$PatientSessionFromJson(json);

@override@JsonKey(name: 'booking_id') final  int bookingId;
@override final  String treatment;
@override final  String location;
@override final  String status;
@override@JsonKey(name: 'slot_date') final  DateTime slotDate;
@override@JsonKey(name: 'start_time') final  String startTime;
@override@JsonKey(name: 'end_time') final  String endTime;

/// Create a copy of PatientSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientSessionCopyWith<_PatientSession> get copyWith => __$PatientSessionCopyWithImpl<_PatientSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatientSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatientSession&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.treatment, treatment) || other.treatment == treatment)&&(identical(other.location, location) || other.location == location)&&(identical(other.status, status) || other.status == status)&&(identical(other.slotDate, slotDate) || other.slotDate == slotDate)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookingId,treatment,location,status,slotDate,startTime,endTime);

@override
String toString() {
  return 'PatientSession(bookingId: $bookingId, treatment: $treatment, location: $location, status: $status, slotDate: $slotDate, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$PatientSessionCopyWith<$Res> implements $PatientSessionCopyWith<$Res> {
  factory _$PatientSessionCopyWith(_PatientSession value, $Res Function(_PatientSession) _then) = __$PatientSessionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'booking_id') int bookingId, String treatment, String location, String status,@JsonKey(name: 'slot_date') DateTime slotDate,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'end_time') String endTime
});




}
/// @nodoc
class __$PatientSessionCopyWithImpl<$Res>
    implements _$PatientSessionCopyWith<$Res> {
  __$PatientSessionCopyWithImpl(this._self, this._then);

  final _PatientSession _self;
  final $Res Function(_PatientSession) _then;

/// Create a copy of PatientSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = null,Object? treatment = null,Object? location = null,Object? status = null,Object? slotDate = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_PatientSession(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,treatment: null == treatment ? _self.treatment : treatment // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,slotDate: null == slotDate ? _self.slotDate : slotDate // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
