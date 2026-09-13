import 'package:dartz/dartz.dart';
import 'package:physioghar/core/api/error/app_error.dart';

typedef EitherResponse<T> = Future<Either<AppError, T>>;
