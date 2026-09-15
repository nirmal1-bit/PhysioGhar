import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/booking/data/models/response/booking.dart';

abstract interface class BookingRepository {
  EitherResponse<List<Booking>> getBookings();

  EitherResponse<Booking> updateStatus({
    required int bookingId,
    required String status,
  });

  EitherResponse<Booking> reschedule({
    required int bookingId,
    required int slotId,
    required DateTime slotDate,
  });

  EitherResponse<Booking> updateNotes({
    required int bookingId,
    required String notes,
  });
}
