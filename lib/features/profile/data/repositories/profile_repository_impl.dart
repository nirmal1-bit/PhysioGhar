import 'package:physioghar/core/api/base/base_remote_source.dart';
import 'package:physioghar/core/constants/api_endponts.dart';
import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/profile/data/models/response/profile.dart';
import 'package:physioghar/features/profile/data/models/request/profile_request.dart';
import 'package:physioghar/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends BaseRemoteSource
    implements ProfileRepository {
  ProfileRepositoryImpl(super.dio, super.networkInfo);

  @override
  EitherResponse<Profile> getProfile() {
    return networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.profile);
        return Profile.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  @override
  EitherResponse<Profile> createProfile(ProfileRequest request) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.profile,
          data: request.toJson(),
        );
        return Profile.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  @override
  EitherResponse<Profile> updateProfile(ProfileRequest request) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.put(
          ApiEndpoints.profile,
          data: request.toJson(),
        );
        return Profile.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }
}
