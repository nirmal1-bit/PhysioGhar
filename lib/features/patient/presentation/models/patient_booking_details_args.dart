import 'package:physioghar/features/patient/data/models/response/available_therapist.dart';

class PatientBookingDetailsArgs {
  const PatientBookingDetailsArgs({
    required this.therapist,
    required this.slot,
  });

  final AvailableTherapist therapist;
  final AvailableSlot slot;
}
