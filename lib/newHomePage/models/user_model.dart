class User {
  final String name;
  final String email;
  final String authToken;
  final bool isAdmin;

  User({
    required this.name,
    required this.email,
    required this.authToken,
    required this.isAdmin,
  });

  // Factory method to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      authToken: json['auth_token'] as String,
      isAdmin: json['is_admin'] as bool,
    );
  }

  // Optionally: Method to convert User back to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'auth_token': authToken,
      'is_admin': isAdmin,
    };
  }
}