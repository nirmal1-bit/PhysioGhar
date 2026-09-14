// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Schedule _$ScheduleFromJson(Map<String, dynamic> json) => _Schedule(
  weekStart: DateTime.parse(json['week_start'] as String),
  weekEnd: DateTime.parse(json['week_end'] as String),
  slots:
      (json['slots'] as List<dynamic>?)
          ?.map((e) => ScheduleSlot.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ScheduleToJson(_Schedule instance) => <String, dynamic>{
  'week_start': instance.weekStart.toIso8601String(),
  'week_end': instance.weekEnd.toIso8601String(),
  'slots': instance.slots,
};
