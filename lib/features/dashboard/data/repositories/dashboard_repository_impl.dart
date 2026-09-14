import 'package:dio/dio.dart';
import 'package:physioghar/core/api/base/base_remote_source.dart';
import 'package:physioghar/core/constants/api_endponts.dart';
import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/dashboard/data/models/response/availability.dart';
import 'package:physioghar/features/dashboard/data/models/response/booking.dart';
import 'package:physioghar/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl extends BaseRemoteSource
    implements DashboardRepository {
  DashboardRepositoryImpl(super.dio, super.networkInfo);

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
  EitherResponse<Availability> getAvailability() {
    return networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.availability);
        return Availability.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  @override
  EitherResponse<Availability> updateAvailability(bool isAvailable) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.put(
          ApiEndpoints.availability,
          data: {'is_available': isAvailable},
          options: Options(contentType: Headers.jsonContentType),
        );
        return Availability.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  @override
  EitherResponse<Booking> updateBookingStatus({
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
  EitherResponse<Booking> rescheduleBooking({
    required int bookingId,
    required int slotId,
  }) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.patch(
          ApiEndpoints.bookingReschedule(bookingId),
          data: {'slot_id': slotId},
        );
        return Booking.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  @override
  EitherResponse<Booking> updateBookingNotes({
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
}
