import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:physioghar/core/api/error/app_error.dart';

extension ApiExceptionDioX on DioException {
  AppError get toAppError {
    if (kDebugMode) {
      debugPrint('DioException [$type]: $message');
    }

    switch (type) {
      case DioExceptionType.badResponse:
        return _fromResponse(response);
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const AppError.noInternet(error: NoInternetError());
      case DioExceptionType.badCertificate:
        return AppError.serverError(
          error: ServerError(
            code: response?.statusCode ?? 495,
            message: 'Could not establish a secure connection',
          ),
        );
      case DioExceptionType.cancel:
        return AppError.serverError(
          error: ServerError(code: 499, message: 'The request was cancelled'),
        );
      case DioExceptionType.unknown:
        return AppError.serverError(
          error: ServerError(
            code: response?.statusCode ?? 500,
            message: _messageFromData(
              response?.data,
              message ?? 'Request failed',
            ),
          ),
        );
    }
  }
}

AppError _fromResponse(Response<dynamic>? response) {
  final statusCode = response?.statusCode ?? 500;
  final data = response?.data;

  if (statusCode == 422) {
    return AppError.validationError(
      validationError: ValidationError(
        code: statusCode,
        message: _messageFromData(data, 'Please check the submitted fields'),
        errors: _validationErrorsFromData(data),
      ),
    );
  }

  return AppError.serverError(
    error: ServerError(
      code: statusCode,
      message: _messageFromData(data, 'Something went wrong'),
    ),
  );
}

String _messageFromData(dynamic data, String fallback) {
  if (data is String && data.trim().isNotEmpty) {
    return data;
  }

  if (data is Map) {
    for (final key in ['detail', 'message', 'error']) {
      final value = data[key];
      if (value is String && value.trim().isNotEmpty) {
        return value;
      }
      if (value is List && value.isNotEmpty) {
        final first = value.first;
        if (first is Map && first['msg'] is String) {
          return first['msg'] as String;
        }
      }
    }
  }

  return fallback;
}

Map<String, dynamic> _validationErrorsFromData(dynamic data) {
  if (data is! Map) {
    return <String, dynamic>{};
  }

  final detail = data['detail'];
  if (detail is Map) {
    return Map<String, dynamic>.from(detail);
  }

  if (detail is List) {
    final errors = <String, dynamic>{};
    for (final item in detail) {
      if (item is Map) {
        final location = item['loc'];
        final message = item['msg'];
        if (message is String) {
          final key = location is List && location.isNotEmpty
              ? location.skip(1).join('.')
              : 'form';
          errors[key] = message;
        }
      }
    }
    return errors;
  }

  return <String, dynamic>{};
}
