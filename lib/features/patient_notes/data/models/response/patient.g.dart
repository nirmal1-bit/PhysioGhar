// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Patient _$PatientFromJson(Map<String, dynamic> json) => _Patient(
  id: (json['id'] as num).toInt(),
  therapistId: (json['therapist_id'] as num).toInt(),
  name: json['name'] as String,
  age: (json['age'] as num?)?.toInt(),
  gender: json['gender'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  condition: json['condition'] as String,
  lastSessionDate: json['last_session_date'] == null
      ? null
      : DateTime.parse(json['last_session_date'] as String),
  sessions:
      (json['sessions'] as List<dynamic>?)
          ?.map((e) => PatientSession.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  notes:
      (json['notes'] as List<dynamic>?)
          ?.map((e) => PatientNote.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$PatientToJson(_Patient instance) => <String, dynamic>{
  'id': instance.id,
  'therapist_id': instance.therapistId,
  'name': instance.name,
  'age': instance.age,
  'gender': instance.gender,
  'email': instance.email,
  'phone': instance.phone,
  'condition': instance.condition,
  'last_session_date': instance.lastSessionDate?.toIso8601String(),
  'sessions': instance.sessions,
  'notes': instance.notes,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

_PatientSession _$PatientSessionFromJson(Map<String, dynamic> json) =>
    _PatientSession(
      bookingId: (json['booking_id'] as num).toInt(),
      treatment: json['treatment'] as String,
      location: json['location'] as String,
      status: json['status'] as String,
      slotDate: DateTime.parse(json['slot_date'] as String),
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
    );

Map<String, dynamic> _$PatientSessionToJson(_PatientSession instance) =>
    <String, dynamic>{
      'booking_id': instance.bookingId,
      'treatment': instance.treatment,
      'location': instance.location,
      'status': instance.status,
      'slot_date': instance.slotDate.toIso8601String(),
      'start_time': instance.startTime,
      'end_time': instance.endTime,
    };
