// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'therapist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Therapist _$TherapistFromJson(Map<String, dynamic> json) => _Therapist(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  name: json['name'] as String,
  username: json['username'] as String,
  userType: json['user_type'] as String,
  isActive: json['is_active'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$TherapistToJson(_Therapist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'username': instance.username,
      'user_type': instance.userType,
      'is_active': instance.isActive,
      'created_at': instance.createdAt.toIso8601String(),
    };
