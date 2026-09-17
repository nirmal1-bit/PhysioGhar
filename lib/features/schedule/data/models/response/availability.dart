import 'package:freezed_annotation/freezed_annotation.dart';

part 'availability.freezed.dart';
part 'availability.g.dart';

@freezed
abstract class ScheduleAvailability with _$ScheduleAvailability {
  const factory ScheduleAvailability({
    @JsonKey(name: 'is_available') required bool isAvailable,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ScheduleAvailability;

  factory ScheduleAvailability.fromJson(Map<String, dynamic> json) =>
      _$ScheduleAvailabilityFromJson(json);
}
