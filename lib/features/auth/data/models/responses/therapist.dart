class Therapist {
  const Therapist({
    required this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.userType,
    required this.isActive,
    required this.createdAt,
  });

  factory Therapist.fromJson(Map<String, dynamic> json) {
    return Therapist(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      userType: json['user_type'] as String,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  final int id;
  final String email;
  final String name;
  final String username;
  final String userType;
  final bool isActive;
  final DateTime createdAt;
}
