// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Booking _$BookingFromJson(Map<String, dynamic> json) => _Booking(
  id: (json['id'] as num).toInt(),
  therapistId: (json['therapist_id'] as num).toInt(),
  slotId: (json['slot_id'] as num).toInt(),
  patientName: json['patient_name'] as String,
  patientEmail: json['patient_email'] as String,
  patientPhone: json['patient_phone'] as String,
  treatment: json['treatment'] as String,
  location: json['location'] as String,
  status: json['status'] as String,
  slotDate: DateTime.parse(json['slot_date'] as String),
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String,
  therapistNotes: json['therapist_notes'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$BookingToJson(_Booking instance) => <String, dynamic>{
  'id': instance.id,
  'therapist_id': instance.therapistId,
  'slot_id': instance.slotId,
  'patient_name': instance.patientName,
  'patient_email': instance.patientEmail,
  'patient_phone': instance.patientPhone,
  'treatment': instance.treatment,
  'location': instance.location,
  'status': instance.status,
  'slot_date': instance.slotDate.toIso8601String(),
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'therapist_notes': instance.therapistNotes,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
