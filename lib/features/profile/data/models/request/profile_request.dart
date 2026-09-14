class ProfileRequest {
  const ProfileRequest({
    required this.name,
    required this.email,
    this.profileImageUrl,
    required this.phone,
    required this.experienceYears,
    required this.specialization,
    required this.address,
  });

  final String name;
  final String email;
  final String? profileImageUrl;
  final String phone;
  final int experienceYears;
  final String specialization;
  final String address;

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
