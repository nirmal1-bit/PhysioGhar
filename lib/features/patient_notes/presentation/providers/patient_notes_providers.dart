import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/providers/core_providers.dart';
import 'package:physioghar/features/patient_notes/data/models/response/patient.dart';
import 'package:physioghar/features/patient_notes/data/repositories/patient_notes_repository_impl.dart';
import 'package:physioghar/features/patient_notes/domain/repositories/patient_notes_repository.dart';

final patientNotesRepositoryProvider = Provider<PatientNotesRepository>((ref) {
  return PatientNotesRepositoryImpl(
    ref.read(dioProvider),
    ref.read(networkInfoProvider),
  );
});

final patientNotesProvider =
    AsyncNotifierProvider<PatientNotesController, List<Patient>>(
      PatientNotesController.new,
    );

final patientNotesDetailsProvider = FutureProvider.autoDispose
    .family<Patient, int>(
      (ref, patientId) => ref
          .read(patientNotesRepositoryProvider)
          .getPatient(patientId)
          .then(
            (result) =>
                result.fold((error) => throw error, (patient) => patient),
          ),
    );

class PatientNotesController extends AsyncNotifier<List<Patient>> {
  @override
  Future<List<Patient>> build() async {
    final result = await ref.read(patientNotesRepositoryProvider).getPatients();
    return result.fold((error) => throw error, (patients) => patients);
  }

  Future<AppError?> saveNote({
    required int patientId,
    int? noteId,
    required String note,
    String? exercises,
    String? nextSession,
    required int bookingId,
  }) async {
    final repository = ref.read(patientNotesRepositoryProvider);
    final result = noteId == null
        ? await repository.createNote(
            patientId: patientId,
            note: note,
            exercises: exercises,
            nextSession: nextSession,
            bookingId: bookingId,
          )
        : await repository.updateNote(
            patientId: patientId,
            noteId: noteId,
            note: note,
            exercises: exercises,
            nextSession: nextSession,
            bookingId: bookingId,
          );

    return result.fold((error) => error, (_) {
      ref.invalidate(patientNotesDetailsProvider(patientId));
      return null;
    });
  }

  Future<void> reload() async {
    ref.invalidateSelf();
    await future;
  }

  static String errorMessage(AppError error) => error.when(
    serverError: (value) => value.message,
    validationError: (value) => value.message,
    noInternet: (value) => value.message,
  );
}
