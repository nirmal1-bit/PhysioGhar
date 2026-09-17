import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/providers/core_providers.dart';
import 'package:physioghar/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:physioghar/features/auth/data/models/requests/login_request.dart';
import 'package:physioghar/features/auth/data/models/requests/register_request.dart';
import 'package:physioghar/features/auth/data/models/responses/auth_token.dart';
import 'package:physioghar/features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.read(dioProvider),
    ref.read(networkInfoProvider),
  );
});

final authControllerProvider =
    AsyncNotifierProvider<AuthController, AuthToken?>(AuthController.new);

class AuthController extends AsyncNotifier<AuthToken?> {
  @override
  Future<AuthToken?> build() async => null;

  Future<AppError?> login(LoginRequest request) async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).login(request);

    return result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
        return error;
      },
      (token) async {
        final session = await ref.read(sessionServiceProvider.future);
        await session.saveToken(token.accessToken);
        await session.saveUserRole(token.userType);
        state = AsyncData(token);
        return null;
      },
    );
  }

  Future<AppError?> register(RegisterRequest request) async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).register(request);

    return result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
        return error;
      },
      (_) {
        state = const AsyncData(null);
        return null;
      },
    );
  }

  Future<void> logout() async {
    final session = await ref.read(sessionServiceProvider.future);
    await session.removeToken();
    state = const AsyncData(null);
  }

  static String errorMessage(AppError error) {
    return error.when(
      serverError: (serverError) => serverError.message,
      validationError: (validationError) {
        if (validationError.errors.isNotEmpty) {
          return validationError.errors.values.first.toString();
        }
        return validationError.message;
      },
      noInternet: (noInternetError) => noInternetError.message,
    );
  }
}
