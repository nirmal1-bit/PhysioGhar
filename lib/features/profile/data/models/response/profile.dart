import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required int id,
    @JsonKey(name: 'therapist_id') required int therapistId,
    required String name,
    required String email,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    String? phone,
    @JsonKey(name: 'experience_years') required int experienceYears,
    required String specialization,
    required String address,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
