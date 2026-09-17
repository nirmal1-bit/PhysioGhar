import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_note.freezed.dart';
part 'patient_note.g.dart';

@freezed
abstract class PatientNote with _$PatientNote {
  const factory PatientNote({
    required int id,
    @JsonKey(name: 'patient_id') required int patientId,
    @JsonKey(name: 'booking_id') required int bookingId,
    required String note,
    String? exercises,
    @JsonKey(name: 'next_session') String? nextSession,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _PatientNote;

  factory PatientNote.fromJson(Map<String, dynamic> json) =>
      _$PatientNoteFromJson(json);
}
