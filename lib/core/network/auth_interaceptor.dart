import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:physioghar/core/constants/storage_keys.dart';

class AuthInterceptor extends QueuedInterceptorsWrapper {
  AuthInterceptor(this._preferences);

  final Future<SharedPreferences> _preferences;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(err);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final preferences = await _preferences;
    final token = preferences.getString(StorageKeys.token);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }
}
