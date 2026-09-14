import 'package:physioghar/core/typedef/typedefs.dart';
import 'package:physioghar/features/profile/data/models/response/profile.dart';
import 'package:physioghar/features/profile/data/models/request/profile_request.dart';

abstract interface class ProfileRepository {
  EitherResponse<Profile> getProfile();
  EitherResponse<Profile> createProfile(ProfileRequest request);
  EitherResponse<Profile> updateProfile(ProfileRequest request);
}
