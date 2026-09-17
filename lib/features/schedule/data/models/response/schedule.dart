import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:physioghar/features/schedule/data/models/response/schedule_slot.dart';

part 'schedule.freezed.dart';
part 'schedule.g.dart';

@freezed
abstract class Schedule with _$Schedule {
  const factory Schedule({
    @JsonKey(name: 'week_start') required DateTime weekStart,
    @JsonKey(name: 'week_end') required DateTime weekEnd,
    @Default([]) List<ScheduleSlot> slots,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}
