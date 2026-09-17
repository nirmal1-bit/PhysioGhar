import 'package:freezed_annotation/freezed_annotation.dart';
import 'patient_note.dart';

part 'patient.freezed.dart';
part 'patient.g.dart';

@freezed
abstract class Patient with _$Patient {
  const factory Patient({
    required int id,
    @JsonKey(name: 'therapist_id') required int therapistId,
    required String name,
    int? age,
    String? gender,
    String? email,
    String? phone,
    required String condition,
    @JsonKey(name: 'last_session_date') DateTime? lastSessionDate,
    @Default([]) List<PatientSession> sessions,
    @Default([]) List<PatientNote> notes,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Patient;

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);
}

@freezed
abstract class PatientSession with _$PatientSession {
  const factory PatientSession({
    @JsonKey(name: 'booking_id') required int bookingId,
    required String treatment,
    required String location,
    required String status,
    @JsonKey(name: 'slot_date') required DateTime slotDate,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
  }) = _PatientSession;

  factory PatientSession.fromJson(Map<String, dynamic> json) =>
      _$PatientSessionFromJson(json);
}
