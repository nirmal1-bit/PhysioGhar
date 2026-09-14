import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/providers/core_providers.dart';
import 'package:physioghar/features/dashboard/data/models/response/availability.dart';
import 'package:physioghar/features/dashboard/data/models/response/booking.dart';
import 'package:physioghar/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:physioghar/features/dashboard/domain/repositories/dashboard_repository.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl(
    ref.read(dioProvider),
    ref.read(networkInfoProvider),
  );
});

final dashboardControllerProvider =
    AsyncNotifierProvider<DashboardController, DashboardData>(
      DashboardController.new,
    );

class DashboardData {
  const DashboardData({required this.bookings, required this.availability});

  final List<Booking> bookings;
  final Availability availability;
}

class DashboardController extends AsyncNotifier<DashboardData> {
  @override
  Future<DashboardData> build() async {
    final repository = ref.read(dashboardRepositoryProvider);
    final bookingsResult = await repository.getBookings();
    final availabilityResult = await repository.getAvailability();

    return bookingsResult.fold(
      (error) => throw error,
      (bookings) => availabilityResult.fold(
        (error) => throw error,
        (availability) =>
            DashboardData(bookings: bookings, availability: availability),
      ),
    );
  }

  Future<AppError?> setAvailability(bool isAvailable) async {
    final result = await ref
        .read(dashboardRepositoryProvider)
        .updateAvailability(isAvailable);

    return result.fold((error) => error, (availability) {
      final current = state.valueOrNull;
      if (current != null) {
        state = AsyncData(
          DashboardData(bookings: current.bookings, availability: availability),
        );
      }
      return null;
    });
  }

  Future<AppError?> updateBookingStatus({
    required int bookingId,
    required String status,
  }) async {
    final result = await ref
        .read(dashboardRepositoryProvider)
        .updateBookingStatus(bookingId: bookingId, status: status);
    return result.fold((error) => error, (updated) {
      _replaceBooking(updated);
      return null;
    });
  }

  Future<AppError?> rescheduleBooking({
    required int bookingId,
    required int slotId,
  }) async {
    final result = await ref
        .read(dashboardRepositoryProvider)
        .rescheduleBooking(bookingId: bookingId, slotId: slotId);
    return result.fold((error) => error, (updated) {
      _replaceBooking(updated);
      return null;
    });
  }

  Future<AppError?> updateBookingNotes({
    required int bookingId,
    required String notes,
  }) async {
    final result = await ref
        .read(dashboardRepositoryProvider)
        .updateBookingNotes(bookingId: bookingId, notes: notes);
    return result.fold((error) => error, (updated) {
      _replaceBooking(updated);
      return null;
    });
  }

  void _replaceBooking(Booking updated) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(
      DashboardData(
        bookings: [
          for (final booking in current.bookings)
            if (booking.id == updated.id) updated else booking,
        ],
        availability: current.availability,
      ),
    );
  }

  Future<void> reload() async {
    ref.invalidateSelf();
    await future;
  }

  static String errorMessage(AppError error) {
    return error.when(
      serverError: (serverError) => serverError.message,
      validationError: (validationError) => validationError.message,
      noInternet: (noInternetError) => noInternetError.message,
    );
  }
}
