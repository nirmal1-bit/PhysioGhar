import 'package:freezed_annotation/freezed_annotation.dart';

part 'therapist.freezed.dart';
part 'therapist.g.dart';

@freezed
abstract class Therapist with _$Therapist {
  const factory Therapist({
    required int id,
    required String email,
    required String name,
    required String username,
    @JsonKey(name: 'user_type') required String userType,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Therapist;

  factory Therapist.fromJson(Map<String, dynamic> json) =>
      _$TherapistFromJson(json);
}
