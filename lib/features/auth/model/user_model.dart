class UserModel {
  final String id;
  final String name;
  final String email;
  final String token;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.token = "",
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  factory UserModel.empty() => const UserModel(
        id: "",
        name: "",
        email: "",
      );

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map["id"],
        name: map["name"],
        email: map["email"],
      );

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, email: $email, token: $token)';
}
