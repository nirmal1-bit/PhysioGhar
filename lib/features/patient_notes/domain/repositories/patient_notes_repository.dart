import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/patient_notes/data/models/response/patient.dart';
import 'package:physioghar/features/patient_notes/data/models/response/patient_note.dart';

abstract interface class PatientNotesRepository {
  EitherResponse<List<Patient>> getPatients();
  EitherResponse<Patient> getPatient(int patientId);
  EitherResponse<PatientNote> createNote({
    required int patientId,
    required String note,
    String? exercises,
    String? nextSession,
    required int bookingId,
  });
  EitherResponse<PatientNote> updateNote({
    required int patientId,
    required int noteId,
    required String note,
    String? exercises,
    String? nextSession,
    required int bookingId,
  });
}
