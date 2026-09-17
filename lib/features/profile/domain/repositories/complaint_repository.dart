import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/profile/data/models/response/complaint.dart';

abstract interface class ComplaintRepository {
  EitherResponse<List<Complaint>> getComplaints();

  EitherResponse<Complaint> createComplaint({
    required String category,
    required String subject,
    required String description,
  });
}
