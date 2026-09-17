// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatientNote _$PatientNoteFromJson(Map<String, dynamic> json) => _PatientNote(
  id: (json['id'] as num).toInt(),
  patientId: (json['patient_id'] as num).toInt(),
  bookingId: (json['booking_id'] as num).toInt(),
  note: json['note'] as String,
  exercises: json['exercises'] as String?,
  nextSession: json['next_session'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$PatientNoteToJson(_PatientNote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_id': instance.patientId,
      'booking_id': instance.bookingId,
      'note': instance.note,
      'exercises': instance.exercises,
      'next_session': instance.nextSession,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
