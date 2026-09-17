// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Complaint _$ComplaintFromJson(Map<String, dynamic> json) => _Complaint(
  id: (json['id'] as num).toInt(),
  category: json['category'] as String,
  subject: json['subject'] as String,
  description: json['description'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ComplaintToJson(_Complaint instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'subject': instance.subject,
      'description': instance.description,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
