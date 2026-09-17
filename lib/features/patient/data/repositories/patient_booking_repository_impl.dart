import 'package:physioghar/core/api/base/base_remote_source.dart';
import 'package:physioghar/core/constants/api_endponts.dart';
import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/booking/data/models/response/booking.dart';
import 'package:physioghar/features/patient/data/models/response/available_therapist.dart';
import 'package:physioghar/features/patient/domain/repositories/patient_booking_repository.dart';
import 'package:physioghar/utils/date_utils.dart';

class PatientBookingRepositoryImpl extends BaseRemoteSource
    implements PatientBookingRepository {
  PatientBookingRepositoryImpl(super.dio, super.networkInfo);

  @override
  EitherResponse<List<AvailableTherapist>> getAvailableTherapists(
    DateTime date,
  ) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.get(
          ApiEndpoints.availableTherapists,
          queryParameters: {'date': formatApiDate(date)},
        );
        return (response.data as List)
            .map(
              (item) =>
                  AvailableTherapist.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      },
    );
  }

  @override
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
  }) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.createBooking,
          data: {
            'therapist_id': therapistId,
            'slot_id': slotId,
            'slot_date': formatApiDate(slotDate),
            'patient_name': patientName.trim(),
            'patient_email': patientEmail.trim(),
            'patient_phone': patientPhone.trim(),
            'patient_age': patientAge,
            'patient_gender': _optional(patientGender),
            'patient_condition': _optional(patientCondition),
            'treatment': treatment.trim(),
            'location': location.trim(),
          },
        );
        return Booking.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  String? _optional(String? value) =>
      value?.trim().isEmpty == true ? null : value?.trim();
}
