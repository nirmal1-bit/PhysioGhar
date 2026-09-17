import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/auth/data/models/requests/login_request.dart';
import 'package:physioghar/features/auth/data/models/requests/register_request.dart';
import 'package:physioghar/features/auth/data/models/responses/auth_token.dart';
import 'package:physioghar/features/auth/data/models/responses/user.dart';

abstract interface class AuthRepository {
  EitherResponse<User> register(RegisterRequest request);
  EitherResponse<AuthToken> login(LoginRequest request);
}
