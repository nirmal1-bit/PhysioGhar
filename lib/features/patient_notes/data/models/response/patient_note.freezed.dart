// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatientNote {

 int get id;@JsonKey(name: 'patient_id') int get patientId;@JsonKey(name: 'booking_id') int get bookingId; String get note; String? get exercises;@JsonKey(name: 'next_session') String? get nextSession;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of PatientNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientNoteCopyWith<PatientNote> get copyWith => _$PatientNoteCopyWithImpl<PatientNote>(this as PatientNote, _$identity);

  /// Serializes this PatientNote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientNote&&(identical(other.id, id) || other.id == id)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.note, note) || other.note == note)&&(identical(other.exercises, exercises) || other.exercises == exercises)&&(identical(other.nextSession, nextSession) || other.nextSession == nextSession)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,patientId,bookingId,note,exercises,nextSession,createdAt,updatedAt);

@override
String toString() {
  return 'PatientNote(id: $id, patientId: $patientId, bookingId: $bookingId, note: $note, exercises: $exercises, nextSession: $nextSession, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PatientNoteCopyWith<$Res>  {
  factory $PatientNoteCopyWith(PatientNote value, $Res Function(PatientNote) _then) = _$PatientNoteCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'patient_id') int patientId,@JsonKey(name: 'booking_id') int bookingId, String note, String? exercises,@JsonKey(name: 'next_session') String? nextSession,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$PatientNoteCopyWithImpl<$Res>
    implements $PatientNoteCopyWith<$Res> {
  _$PatientNoteCopyWithImpl(this._self, this._then);

  final PatientNote _self;
  final $Res Function(PatientNote) _then;

/// Create a copy of PatientNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? patientId = null,Object? bookingId = null,Object? note = null,Object? exercises = freezed,Object? nextSession = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as int,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,exercises: freezed == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as String?,nextSession: freezed == nextSession ? _self.nextSession : nextSession // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PatientNote].
extension PatientNotePatterns on PatientNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatientNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatientNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatientNote value)  $default,){
final _that = this;
switch (_that) {
case _PatientNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatientNote value)?  $default,){
final _that = this;
switch (_that) {
case _PatientNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'patient_id')  int patientId, @JsonKey(name: 'booking_id')  int bookingId,  String note,  String? exercises, @JsonKey(name: 'next_session')  String? nextSession, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatientNote() when $default != null:
return $default(_that.id,_that.patientId,_that.bookingId,_that.note,_that.exercises,_that.nextSession,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'patient_id')  int patientId, @JsonKey(name: 'booking_id')  int bookingId,  String note,  String? exercises, @JsonKey(name: 'next_session')  String? nextSession, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PatientNote():
return $default(_that.id,_that.patientId,_that.bookingId,_that.note,_that.exercises,_that.nextSession,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'patient_id')  int patientId, @JsonKey(name: 'booking_id')  int bookingId,  String note,  String? exercises, @JsonKey(name: 'next_session')  String? nextSession, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PatientNote() when $default != null:
return $default(_that.id,_that.patientId,_that.bookingId,_that.note,_that.exercises,_that.nextSession,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PatientNote implements PatientNote {
  const _PatientNote({required this.id, @JsonKey(name: 'patient_id') required this.patientId, @JsonKey(name: 'booking_id') required this.bookingId, required this.note, this.exercises, @JsonKey(name: 'next_session') this.nextSession, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _PatientNote.fromJson(Map<String, dynamic> json) => _$PatientNoteFromJson(json);

@override final  int id;
@override@JsonKey(name: 'patient_id') final  int patientId;
@override@JsonKey(name: 'booking_id') final  int bookingId;
@override final  String note;
@override final  String? exercises;
@override@JsonKey(name: 'next_session') final  String? nextSession;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of PatientNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientNoteCopyWith<_PatientNote> get copyWith => __$PatientNoteCopyWithImpl<_PatientNote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatientNoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatientNote&&(identical(other.id, id) || other.id == id)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.note, note) || other.note == note)&&(identical(other.exercises, exercises) || other.exercises == exercises)&&(identical(other.nextSession, nextSession) || other.nextSession == nextSession)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,patientId,bookingId,note,exercises,nextSession,createdAt,updatedAt);

@override
String toString() {
  return 'PatientNote(id: $id, patientId: $patientId, bookingId: $bookingId, note: $note, exercises: $exercises, nextSession: $nextSession, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PatientNoteCopyWith<$Res> implements $PatientNoteCopyWith<$Res> {
  factory _$PatientNoteCopyWith(_PatientNote value, $Res Function(_PatientNote) _then) = __$PatientNoteCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'patient_id') int patientId,@JsonKey(name: 'booking_id') int bookingId, String note, String? exercises,@JsonKey(name: 'next_session') String? nextSession,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$PatientNoteCopyWithImpl<$Res>
    implements _$PatientNoteCopyWith<$Res> {
  __$PatientNoteCopyWithImpl(this._self, this._then);

  final _PatientNote _self;
  final $Res Function(_PatientNote) _then;

/// Create a copy of PatientNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? patientId = null,Object? bookingId = null,Object? note = null,Object? exercises = freezed,Object? nextSession = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PatientNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as int,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,exercises: freezed == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as String?,nextSession: freezed == nextSession ? _self.nextSession : nextSession // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
