import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_therapist.freezed.dart';
part 'available_therapist.g.dart';

@freezed
abstract class AvailableTherapist with _$AvailableTherapist {
  const factory AvailableTherapist({
    required int id,
    required String name,
    required String username,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    @JsonKey(name: 'experience_years') int? experienceYears,
    String? specialization,
    String? address,
    @Default([]) List<AvailableSlot> slots,
  }) = _AvailableTherapist;

  factory AvailableTherapist.fromJson(Map<String, dynamic> json) =>
      _$AvailableTherapistFromJson(json);
}

@freezed
abstract class AvailableSlot with _$AvailableSlot {
  const factory AvailableSlot({
    required int id,
    @JsonKey(name: 'slot_date') required DateTime slotDate,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
  }) = _AvailableSlot;

  factory AvailableSlot.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotFromJson(json);
}
