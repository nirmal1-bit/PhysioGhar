import 'package:physioghar/core/api/base/base_remote_source.dart';
import 'package:physioghar/core/constants/api_endponts.dart';
import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/booking/data/models/response/booking.dart';
import 'package:physioghar/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl extends BaseRemoteSource
    implements BookingRepository {
  BookingRepositoryImpl(super.dio, super.networkInfo);

  @override
  EitherResponse<List<Booking>> getBookings() {
    return networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.therapistBookings);
        return (response.data as List)
            .map((item) => Booking.fromJson(item as Map<String, dynamic>))
            .toList();
      },
    );
  }

  @override
  EitherResponse<Booking> updateStatus({
    required int bookingId,
    required String status,
  }) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.patch(
          ApiEndpoints.bookingStatus(bookingId),
          data: {'status': status},
        );
        return Booking.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  @override
  EitherResponse<Booking> reschedule({
    required int bookingId,
    required int slotId,
    required DateTime slotDate,
  }) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.patch(
          ApiEndpoints.bookingReschedule(bookingId),
          data: {
            'slot_id': slotId,
            'slot_date': _dateValue(slotDate),
          },
        );
        return Booking.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  @override
  EitherResponse<Booking> updateNotes({
    required int bookingId,
    required String notes,
  }) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.patch(
          ApiEndpoints.bookingNotes(bookingId),
          data: {'notes': notes},
        );
        return Booking.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  String _dateValue(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
