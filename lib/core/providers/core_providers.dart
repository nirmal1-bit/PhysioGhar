import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:physioghar/core/network/auth_interaceptor.dart';
import 'package:physioghar/core/network/network_info.dart';
import 'package:physioghar/core/session/session_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// changes whenever the authenticated account changes.
///
/// user-scoped providers watch this value so a logout or a new login cannot
/// reuse the previous account's in-memory API state.

final sessionRevisionProvider = StateProvider<int>((ref) => 0);

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://prod.creativeinkflow.tech/api/v1',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(
    AuthInterceptor(ref.read(sharedPreferencesProvider.future)),
  );

  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 100,
      ),
    );
  }

  ref.onDispose(() {
    dio.close();
  });

  return dio;
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(InternetConnectionChecker.instance);
});

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

final sessionServiceProvider = FutureProvider<SessionService>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);

  return SessionService(prefs);
});
