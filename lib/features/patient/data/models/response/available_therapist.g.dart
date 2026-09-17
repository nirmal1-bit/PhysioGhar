// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_therapist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AvailableTherapist _$AvailableTherapistFromJson(Map<String, dynamic> json) =>
    _AvailableTherapist(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      username: json['username'] as String,
      profileImageUrl: json['profile_image_url'] as String?,
      experienceYears: (json['experience_years'] as num?)?.toInt(),
      specialization: json['specialization'] as String?,
      address: json['address'] as String?,
      slots:
          (json['slots'] as List<dynamic>?)
              ?.map((e) => AvailableSlot.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AvailableTherapistToJson(_AvailableTherapist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'profile_image_url': instance.profileImageUrl,
      'experience_years': instance.experienceYears,
      'specialization': instance.specialization,
      'address': instance.address,
      'slots': instance.slots,
    };

_AvailableSlot _$AvailableSlotFromJson(Map<String, dynamic> json) =>
    _AvailableSlot(
      id: (json['id'] as num).toInt(),
      slotDate: DateTime.parse(json['slot_date'] as String),
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
    );

Map<String, dynamic> _$AvailableSlotToJson(_AvailableSlot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slot_date': instance.slotDate.toIso8601String(),
      'start_time': instance.startTime,
      'end_time': instance.endTime,
    };
