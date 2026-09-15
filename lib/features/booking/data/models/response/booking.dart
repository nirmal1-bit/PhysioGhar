import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

@freezed
abstract class Booking with _$Booking {
  const factory Booking({
    required int id,
    @JsonKey(name: 'therapist_id') required int therapistId,
    @JsonKey(name: 'slot_id') required int slotId,
    @JsonKey(name: 'patient_name') required String patientName,
    @JsonKey(name: 'patient_email') required String patientEmail,
    @JsonKey(name: 'patient_phone') required String patientPhone,
    required String treatment,
    required String location,
    required String status,
    @JsonKey(name: 'slot_date') required DateTime slotDate,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    @JsonKey(name: 'therapist_notes') String? therapistNotes,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
}
