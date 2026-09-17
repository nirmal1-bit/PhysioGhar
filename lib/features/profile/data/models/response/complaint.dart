import 'package:freezed_annotation/freezed_annotation.dart';

part 'complaint.freezed.dart';
part 'complaint.g.dart';

@freezed
abstract class Complaint with _$Complaint {
  const factory Complaint({
    required int id,
    required String category,
    required String subject,
    required String description,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Complaint;

  factory Complaint.fromJson(Map<String, dynamic> json) =>
      _$ComplaintFromJson(json);
}
