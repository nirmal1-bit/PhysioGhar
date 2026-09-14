// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Availability _$AvailabilityFromJson(Map<String, dynamic> json) =>
    _Availability(
      isAvailable: json['is_available'] as bool,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AvailabilityToJson(_Availability instance) =>
    <String, dynamic>{
      'is_available': instance.isAvailable,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
