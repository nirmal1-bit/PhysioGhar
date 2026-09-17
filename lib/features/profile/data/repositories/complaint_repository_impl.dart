import 'package:physioghar/core/api/base/base_remote_source.dart';
import 'package:physioghar/core/constants/api_endponts.dart';
import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/profile/data/models/response/complaint.dart';
import 'package:physioghar/features/profile/domain/repositories/complaint_repository.dart';

class ComplaintRepositoryImpl extends BaseRemoteSource
    implements ComplaintRepository {
  ComplaintRepositoryImpl(super.dio, super.networkInfo);

  @override
  EitherResponse<List<Complaint>> getComplaints() {
    return networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.complaints);
        return (response.data as List)
            .map((item) => Complaint.fromJson(item as Map<String, dynamic>))
            .toList();
      },
    );
  }

  @override
  EitherResponse<Complaint> createComplaint({
    required String category,
    required String subject,
    required String description,
  }) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.complaints,
          data: {
            'category': category,
            'subject': subject,
            'description': description,
          },
        );
        return Complaint.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }
}
