import 'package:dio/dio.dart';
import 'package:physioghar/core/api/base/base_remote_source.dart';
import 'package:physioghar/core/constants/api_endponts.dart';
import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/schedule/data/models/availability.dart';
import 'package:physioghar/features/schedule/data/models/schedule.dart';
import 'package:physioghar/features/schedule/data/models/schedule_slot.dart';
import 'package:physioghar/features/schedule/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl extends BaseRemoteSource
    implements ScheduleRepository {
  ScheduleRepositoryImpl(super.dio, super.networkInfo);

  @override
  EitherResponse<Schedule> getSchedule(DateTime date) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.get(
          ApiEndpoints.schedule,
          queryParameters: {'date': _dateValue(date)},
        );
        return Schedule.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  @override
  EitherResponse<ScheduleAvailability> getAvailability() {
    return networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.availability);
        return ScheduleAvailability.fromJson(
          response.data as Map<String, dynamic>,
        );
      },
    );
  }

  @override
  EitherResponse<ScheduleAvailability> updateAvailability(bool isAvailable) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.put(
          ApiEndpoints.availability,
          data: {'is_available': isAvailable},
          options: Options(contentType: Headers.jsonContentType),
        );
        return ScheduleAvailability.fromJson(
          response.data as Map<String, dynamic>,
        );
      },
    );
  }

  @override
  EitherResponse<ScheduleSlot> createSlot({
    required DateTime date,
    required String startTime,
    required String endTime,
  }) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.scheduleSlots,
          data: {
            'slot_date': _dateValue(date),
            'start_time': startTime,
            'end_time': endTime,
          },
          options: Options(contentType: Headers.jsonContentType),
        );
        return ScheduleSlot.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  @override
  EitherResponse<ScheduleSlot> updateSlotStatus({
    required int slotId,
    required String status,
  }) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.patch(
          '${ApiEndpoints.scheduleSlots}/$slotId',
          data: {'status': status},
          options: Options(contentType: Headers.jsonContentType),
        );
        return ScheduleSlot.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  String _dateValue(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
