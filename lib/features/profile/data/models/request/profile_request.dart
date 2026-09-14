import 'package:image_picker/image_picker.dart';

class ProfileRequest {
  const ProfileRequest({
    required this.name,
    required this.email,
    this.profileImageUrl,
    required this.phone,
    required this.experienceYears,
    required this.specialization,
    required this.address,
    this.image,
  });

  final String name;
  final String email;
  final String? profileImageUrl;
  final String phone;
  final int experienceYears;
  final String specialization;
  final String address;
  final XFile? image;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'profile_image_url': profileImageUrl,
      'phone': phone,
      'experience_years': experienceYears,
      'specialization': specialization,
      'address': address,
    };
  }
}
