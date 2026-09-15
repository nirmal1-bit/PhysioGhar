import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_slot.freezed.dart';
part 'schedule_slot.g.dart';

@freezed
abstract class ScheduleSlot with _$ScheduleSlot {
  const factory ScheduleSlot({
    required int id,
    @JsonKey(name: 'slot_date') required DateTime slotDate,
    @JsonKey(name: 'day_of_week') required int dayOfWeek,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ScheduleSlot;

  factory ScheduleSlot.fromJson(Map<String, dynamic> json) =>
      _$ScheduleSlotFromJson(json);
}
