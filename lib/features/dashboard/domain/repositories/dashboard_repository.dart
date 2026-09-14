import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/dashboard/data/models/response/availability.dart';
import 'package:physioghar/features/dashboard/data/models/response/booking.dart';

abstract interface class DashboardRepository {
  EitherResponse<List<Booking>> getBookings();
  EitherResponse<Availability> getAvailability();
  EitherResponse<Availability> updateAvailability(bool isAvailable);
  EitherResponse<Booking> updateBookingStatus({
    required int bookingId,
    required String status,
  });
  EitherResponse<Booking> rescheduleBooking({
    required int bookingId,
    required int slotId,
  });
  EitherResponse<Booking> updateBookingNotes({
    required int bookingId,
    required String notes,
  });
}
