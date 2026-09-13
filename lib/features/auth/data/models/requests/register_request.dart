class RegisterRequest {
  const RegisterRequest({
    required this.email,
    required this.name,
    required this.username,
    required this.password,
  });

  final String email;
  final String name;
  final String username;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'username': username,
      'password': password,
    };
  }
}
