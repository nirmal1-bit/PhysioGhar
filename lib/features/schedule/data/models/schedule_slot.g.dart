// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScheduleSlot _$ScheduleSlotFromJson(Map<String, dynamic> json) =>
    _ScheduleSlot(
      id: (json['id'] as num).toInt(),
      slotDate: DateTime.parse(json['slot_date'] as String),
      dayOfWeek: (json['day_of_week'] as num).toInt(),
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ScheduleSlotToJson(_ScheduleSlot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slot_date': instance.slotDate.toIso8601String(),
      'day_of_week': instance.dayOfWeek,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
