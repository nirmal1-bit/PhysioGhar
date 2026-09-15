import 'package:dio/dio.dart';
import 'package:physioghar/core/api/base/base_remote_source.dart';
import 'package:physioghar/core/constants/api_endponts.dart';
import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/dashboard/data/models/response/availability.dart';
import 'package:physioghar/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl extends BaseRemoteSource
    implements DashboardRepository {
  DashboardRepositoryImpl(super.dio, super.networkInfo);

  @override
  EitherResponse<Availability> getAvailability() {
    return networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.availability);
        return Availability.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  @override
  EitherResponse<Availability> updateAvailability(bool isAvailable) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.put(
          ApiEndpoints.availability,
          data: {'is_available': isAvailable},
          options: Options(contentType: Headers.jsonContentType),
        );
        return Availability.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }
}
