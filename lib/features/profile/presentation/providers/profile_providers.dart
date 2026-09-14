import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/providers/core_providers.dart';
import 'package:physioghar/features/profile/data/models/response/profile.dart';
import 'package:physioghar/features/profile/data/models/request/profile_request.dart';
import 'package:physioghar/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:physioghar/features/profile/domain/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(
    ref.read(dioProvider),
    ref.read(networkInfoProvider),
  );
});

final profileControllerProvider =
    AsyncNotifierProvider<ProfileController, Profile?>(ProfileController.new);

class ProfileController extends AsyncNotifier<Profile?> {
  @override
  Future<Profile?> build() async {
    final result = await ref.read(profileRepositoryProvider).getProfile();

    return result.fold((error) {
      if (_isNotFound(error)) return null;
      throw error;
    }, (profile) => profile);
  }

  Future<AppError?> save(ProfileRequest request) async {
    final hasExistingProfile = state.valueOrNull != null;
    state = const AsyncLoading();
    final repository = ref.read(profileRepositoryProvider);
    final result = !hasExistingProfile
        ? await repository.createProfile(request)
        : await repository.updateProfile(request);

    return result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
        return error;
      },
      (profile) {
        state = AsyncData(profile);
        return null;
      },
    );
  }

  Future<void> reload() async {
    ref.invalidateSelf();
    await future;
  }

  static bool _isNotFound(AppError error) {
    return error.when(
      serverError: (serverError) => serverError.code == 404,
      validationError: (_) => false,
      noInternet: (_) => false,
    );
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
