import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/providers/core_providers.dart';
import 'package:physioghar/features/schedule/data/models/availability.dart';
import 'package:physioghar/features/schedule/data/models/schedule.dart';
import 'package:physioghar/features/schedule/data/models/schedule_slot.dart';
import 'package:physioghar/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:physioghar/features/schedule/domain/repositories/schedule_repository.dart';

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepositoryImpl(
    ref.read(dioProvider),
    ref.read(networkInfoProvider),
  );
});

final scheduleControllerProvider =
    AsyncNotifierProvider<ScheduleController, ScheduleData>(
      ScheduleController.new,
    );

class ScheduleData {
  const ScheduleData({
    required this.schedule,
    required this.availability,
    required this.selectedDate,
  });

  final Schedule schedule;
  final ScheduleAvailability availability;
  final DateTime selectedDate;

  List<ScheduleSlot> get selectedDaySlots => schedule.slots
      .where(
        (slot) =>
            slot.slotDate.year == selectedDate.year &&
            slot.slotDate.month == selectedDate.month &&
            slot.slotDate.day == selectedDate.day,
      )
      .toList();
}

class ScheduleController extends AsyncNotifier<ScheduleData> {
  @override
  Future<ScheduleData> build() async {
    final selectedDate = _dateOnly(DateTime.now());
    return _load(selectedDate);
  }

  Future<ScheduleData> _load(DateTime selectedDate) async {
    final repository = ref.read(scheduleRepositoryProvider);
    final scheduleResult = await repository.getSchedule(selectedDate);
    final availabilityResult = await repository.getAvailability();

    return scheduleResult.fold(
      (error) => throw error,
      (schedule) => availabilityResult.fold(
        (error) => throw error,
        (availability) => ScheduleData(
          schedule: schedule,
          availability: availability,
          selectedDate: selectedDate,
        ),
      ),
    );
  }

  Future<void> selectDate(DateTime date) async {
    final current = state.valueOrNull;
    final selectedDate = _dateOnly(date);
    if (current?.selectedDate == selectedDate) return;
    if (current != null && _isInCurrentWeek(current.schedule, selectedDate)) {
      state = AsyncData(
        ScheduleData(
          schedule: current.schedule,
          availability: current.availability,
          selectedDate: selectedDate,
        ),
      );
      return;
    }

    state = const AsyncLoading();
    try {
      state = AsyncData(await _load(selectedDate));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<AppError?> setAvailability(bool value) async {
    final result = await ref
        .read(scheduleRepositoryProvider)
        .updateAvailability(value);
    return result.fold((error) => error, (availability) {
      final current = state.valueOrNull;
      if (current != null) {
        state = AsyncData(
          ScheduleData(
            schedule: current.schedule,
            availability: availability,
            selectedDate: current.selectedDate,
          ),
        );
      }
      return null;
    });
  }

  Future<AppError?> addSlot({
    required DateTime date,
    required String startTime,
    required String endTime,
  }) async {
    final result = await ref
        .read(scheduleRepositoryProvider)
        .createSlot(date: date, startTime: startTime, endTime: endTime);
    return result.fold((error) => error, (_) async {
      await _refreshSelectedDate();
      return null;
    });
  }

  Future<AppError?> changeSlotStatus({
    required int slotId,
    required String status,
  }) async {
    final result = await ref
        .read(scheduleRepositoryProvider)
        .updateSlotStatus(slotId: slotId, status: status);
    return result.fold((error) => error, (_) async {
      await _refreshSelectedDate();
      return null;
    });
  }

  Future<void> _refreshSelectedDate() async {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(await _load(current.selectedDate));
  }

  Future<void> reload() async {
    ref.invalidateSelf();
    await future;
  }

  static DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  bool _isInCurrentWeek(Schedule schedule, DateTime date) {
    final start = _dateOnly(schedule.weekStart);
    final end = _dateOnly(schedule.weekEnd);
    return !date.isBefore(start) && !date.isAfter(end);
  }

  static String errorMessage(AppError error) {
    return error.when(
      serverError: (serverError) => serverError.message,
      validationError: (validationError) => validationError.message,
      noInternet: (noInternetError) => noInternetError.message,
    );
  }
}
