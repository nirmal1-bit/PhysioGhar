import 'package:physioghar/core/api/base/base_remote_source.dart';
import 'package:physioghar/core/constants/api_endponts.dart';
import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/auth/data/models/requests/login_request.dart';
import 'package:physioghar/features/auth/data/models/requests/register_request.dart';
import 'package:physioghar/features/auth/data/models/responses/auth_token.dart';
import 'package:physioghar/features/auth/data/models/responses/therapist.dart';
import 'package:physioghar/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends BaseRemoteSource implements AuthRepository {
  AuthRepositoryImpl(super.dio, super.networkInfo);

  @override
  EitherResponse<Therapist> register(RegisterRequest request) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.register,
          data: request.toJson(),
        );
        return Therapist.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  @override
  EitherResponse<AuthToken> login(LoginRequest request) {
    return networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.login,
          data: request.toJson(),
        );
        return AuthToken.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }
}
