import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:physioghar/core/api/error/api_exception.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/api/extension/api_extension.dart';
import 'package:physioghar/core/network/network_info.dart';
import 'package:physioghar/core/typedef/typedefs.dart';

class BaseRemoteSource {
  BaseRemoteSource(this._dio, this._networkInfo);
  final Dio _dio;
  // final context = getIt<AppRouter>().navigatorKey.currentContext;
  final NetworkInfo _networkInfo;

  /// [T] is return type from network request
  ///
  /// [request] callback returns [Response] and accepts [Dio] instance
  ///
  /// [onResponse] callback returns [T] and accepts [dynamic] data from [Response]
  ///
  /// throws [ApiException]
  EitherResponse<T> networkRequest<T>({
    required Future<T> Function(Dio dio) request,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await request(_dio);
        return right(response);
      } on ApiException catch (e) {
        return left(
          e.when(
            serverException: (message) => AppError.serverError(
              error: ServerError(code: 500, message: message),
            ),
            unprocessableEntity: (message, errors) => AppError.validationError(
              validationError: ValidationError(
                message: message,
                errors: errors,
              ),
            ),
            unAuthorized: () => const AppError.serverError(
              error: ServerError(code: 401, message: 'Unauthorized'),
            ),
            network: () => const AppError.noInternet(error: NoInternetError()),
            formatException: () => const AppError.serverError(
              error: ServerError(code: 500, message: 'Something went wrong'),
            ),
          ),
        );
      } on DioException catch (e) {
        return left(e.toAppError);
      } on FormatException catch (e) {
        return left(
          AppError.serverError(
            error: ServerError(code: 500, message: e.message),
          ),
        );
      }
    } else {
      return left(const AppError.noInternet(error: NoInternetError()));
    }
  }
}
