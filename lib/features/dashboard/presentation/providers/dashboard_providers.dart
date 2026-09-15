import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/providers/core_providers.dart';
import 'package:physioghar/features/booking/presentation/providers/booking_providers.dart';
import 'package:physioghar/features/dashboard/data/models/response/availability.dart';
import 'package:physioghar/features/booking/data/models/response/booking.dart';
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
    final bookingsResult = await ref
        .read(bookingRepositoryProvider)
        .getBookings();
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
