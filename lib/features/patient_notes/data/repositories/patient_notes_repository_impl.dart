import 'package:physioghar/core/api/base/base_remote_source.dart';
import 'package:physioghar/core/constants/api_endponts.dart';
import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/patient_notes/data/models/response/patient.dart';
import 'package:physioghar/features/patient_notes/data/models/response/patient_note.dart';
import 'package:physioghar/features/patient_notes/domain/repositories/patient_notes_repository.dart';

class PatientNotesRepositoryImpl extends BaseRemoteSource
    implements PatientNotesRepository {
  PatientNotesRepositoryImpl(super.dio, super.networkInfo);

  @override
  EitherResponse<List<Patient>> getPatients() {
    return networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.patients);
        return (response.data as List)
            .map((item) => Patient.fromJson(item as Map<String, dynamic>))
            .toList();
      },
    );
  }

  @override
  EitherResponse<Patient> getPatient(int patientId) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.patient(patientId));
        return Patient.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  @override
  EitherResponse<PatientNote> createNote({
    required int patientId,
    required String note,
    String? exercises,
    String? nextSession,
    required int bookingId,
  }) {
    return _saveNote(
      method: 'post',
      path: ApiEndpoints.patientNotes(patientId),
      data: {
        'note': note,
        'exercises': _value(exercises),
        'next_session': _value(nextSession),
        'booking_id': bookingId,
      },
    );
  }

  @override
  EitherResponse<PatientNote> updateNote({
    required int patientId,
    required int noteId,
    required String note,
    String? exercises,
    String? nextSession,
    required int bookingId,
  }) {
    return _saveNote(
      method: 'put',
      path: ApiEndpoints.patientNote(patientId, noteId),
      data: {
        'note': note,
        'exercises': _value(exercises),
        'next_session': _value(nextSession),
        'booking_id': bookingId,
      },
    );
  }

  EitherResponse<PatientNote> _saveNote({
    required String method,
    required String path,
    required Map<String, dynamic> data,
  }) {
    return networkRequest(
      request: (dio) async {
        final response = method == 'post'
            ? await dio.post(path, data: data)
            : await dio.put(path, data: data);
        return PatientNote.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  String? _value(String? value) =>
      value?.trim().isEmpty == true ? null : value?.trim();
}
