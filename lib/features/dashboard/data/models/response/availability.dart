import 'package:freezed_annotation/freezed_annotation.dart';

part 'availability.freezed.dart';
part 'availability.g.dart';

@freezed
abstract class Availability with _$Availability {
  const factory Availability({
    @JsonKey(name: 'is_available') required bool isAvailable,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Availability;

  factory Availability.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityFromJson(json);
}
