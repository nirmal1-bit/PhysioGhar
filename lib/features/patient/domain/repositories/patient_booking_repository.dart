import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/booking/data/models/response/booking.dart';
import 'package:physioghar/features/patient/data/models/response/available_therapist.dart';

abstract interface class PatientBookingRepository {
  EitherResponse<List<AvailableTherapist>> getAvailableTherapists(
    DateTime date,
  );

  EitherResponse<Booking> createBooking({
    required int therapistId,
    required int slotId,
    required DateTime slotDate,
    required String patientName,
    required String patientEmail,
    required String patientPhone,
    required String treatment,
    required String location,
    int? patientAge,
    String? patientGender,
    String? patientCondition,
  });
}
