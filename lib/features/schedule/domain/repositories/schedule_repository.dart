import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/schedule/data/models/availability.dart';
import 'package:physioghar/features/schedule/data/models/schedule.dart';
import 'package:physioghar/features/schedule/data/models/schedule_slot.dart';

abstract interface class ScheduleRepository {
  EitherResponse<Schedule> getSchedule(DateTime date);
  EitherResponse<ScheduleAvailability> getAvailability();
  EitherResponse<ScheduleAvailability> updateAvailability(bool isAvailable);
  EitherResponse<ScheduleSlot> createSlot({
    required int dayOfWeek,
    required String startTime,
    required String endTime,
  });
  EitherResponse<ScheduleSlot> updateSlotStatus({
    required int slotId,
    required String status,
    required DateTime date,
  });
}
