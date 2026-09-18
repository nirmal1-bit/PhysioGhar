import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/providers/core_providers.dart';
import 'package:physioghar/features/patient/data/models/response/available_therapist.dart';
import 'package:physioghar/features/patient/data/repositories/patient_booking_repository_impl.dart';
import 'package:physioghar/features/patient/domain/repositories/patient_booking_repository.dart';

final patientBookingRepositoryProvider = Provider<PatientBookingRepository>((
  ref,
) {
  return PatientBookingRepositoryImpl(
    ref.read(dioProvider),
    ref.read(networkInfoProvider),
  );
});

final patientBookingProvider =
    AsyncNotifierProvider<PatientBookingController, List<AvailableTherapist>>(
      PatientBookingController.new,
    );

class PatientBookingController extends AsyncNotifier<List<AvailableTherapist>> {
  DateTime selectedDate = DateTime.now();

  @override
  Future<List<AvailableTherapist>> build() {
    ref.watch(sessionRevisionProvider);
    return _load(selectedDate);
  }

  Future<void> selectDate(DateTime date) async {
    selectedDate = date;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _load(date));
  }

  Future<AppError?> book({
    required int therapistId,
    required int slotId,
    required String patientName,
    required String patientEmail,
    required String patientPhone,
    required String treatment,
    required String location,
    int? patientAge,
    String? patientGender,
    String? patientCondition,
  }) async {
    final result = await ref
        .read(patientBookingRepositoryProvider)
        .createBooking(
          therapistId: therapistId,
          slotId: slotId,
          slotDate: selectedDate,
          patientName: patientName,
          patientEmail: patientEmail,
          patientPhone: patientPhone,
          treatment: treatment,
          location: location,
          patientAge: patientAge,
          patientGender: patientGender,
          patientCondition: patientCondition,
        );
    return result.fold((error) => error, (_) async {
      state = await AsyncValue.guard(() => _load(selectedDate));
      return null;
    });
  }

  Future<List<AvailableTherapist>> _load(DateTime date) async {
    final result = await ref
        .read(patientBookingRepositoryProvider)
        .getAvailableTherapists(date);
    return result.fold((error) => throw error, (therapists) => therapists);
  }

  static String errorMessage(AppError error) => error.when(
    serverError: (value) => value.message,
    validationError: (value) => value.message,
    noInternet: (value) => value.message,
  );
}
