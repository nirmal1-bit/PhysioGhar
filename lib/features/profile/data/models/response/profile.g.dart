// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  id: (json['id'] as num).toInt(),
  therapistId: (json['therapist_id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  profileImageUrl: json['profile_image_url'] as String?,
  phone: json['phone'] as String,
  experienceYears: (json['experience_years'] as num).toInt(),
  specialization: json['specialization'] as String,
  address: json['address'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'id': instance.id,
  'therapist_id': instance.therapistId,
  'name': instance.name,
  'email': instance.email,
  'profile_image_url': instance.profileImageUrl,
  'phone': instance.phone,
  'experience_years': instance.experienceYears,
  'specialization': instance.specialization,
  'address': instance.address,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
