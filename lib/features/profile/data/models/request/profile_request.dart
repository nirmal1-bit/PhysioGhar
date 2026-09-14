import 'package:image_picker/image_picker.dart';

class ProfileRequest {
  const ProfileRequest({
    this.profileImageUrl,
    required this.experienceYears,
    required this.specialization,
    required this.address,
    this.image,
  });

  final String? profileImageUrl;
  final int experienceYears;
  final String specialization;
  final String address;
  final XFile? image;

  Map<String, dynamic> toJson() {
    return {
      'profile_image_url': profileImageUrl,
      'experience_years': experienceYears,
      'specialization': specialization,
      'address': address,
    };
  }
}
