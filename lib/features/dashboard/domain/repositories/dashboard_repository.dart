import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/dashboard/data/models/response/availability.dart';

abstract interface class DashboardRepository {
  EitherResponse<Availability> getAvailability();
  EitherResponse<Availability> updateAvailability(bool isAvailable);
}
