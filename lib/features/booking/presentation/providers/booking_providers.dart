import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/providers/core_providers.dart';
import 'package:physioghar/features/booking/data/models/response/booking.dart';
import 'package:physioghar/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:physioghar/features/booking/domain/repositories/booking_repository.dart';

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  return BookingRepositoryImpl(
    ref.read(dioProvider),
    ref.read(networkInfoProvider),
  );
});

final bookingControllerProvider =
    AsyncNotifierProvider<BookingController, List<Booking>>(
      BookingController.new,
    );

class BookingController extends AsyncNotifier<List<Booking>> {
  @override
  Future<List<Booking>> build() async {
    final result = await ref.read(bookingRepositoryProvider).getBookings();
    return result.fold((error) => throw error, (bookings) => bookings);
  }

  Future<AppError?> updateStatus({
    required int bookingId,
    required String status,
  }) async {
    final result = await ref
        .read(bookingRepositoryProvider)
        .updateStatus(bookingId: bookingId, status: status);
    return _replace(result);
  }

  Future<AppError?> reschedule({
    required int bookingId,
    required int slotId,
    required DateTime slotDate,
  }) async {
    final result = await ref
        .read(bookingRepositoryProvider)
        .reschedule(bookingId: bookingId, slotId: slotId, slotDate: slotDate);
    return _replace(result);
  }

  Future<AppError?> updateNotes({
    required int bookingId,
    required String notes,
  }) async {
    final result = await ref
        .read(bookingRepositoryProvider)
        .updateNotes(bookingId: bookingId, notes: notes);
    return _replace(result);
  }

  AppError? _replace(Either<AppError, Booking> result) {
    return result.fold((error) => error, (updated) {
      final current = state.valueOrNull ?? const <Booking>[];
      state = AsyncData([
        for (final booking in current)
          if (booking.id == updated.id) updated else booking,
      ]);
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
