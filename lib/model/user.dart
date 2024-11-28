class User {
  String? username;
  String? email;
  int? id;

  User({
    required this.username,
    required this.email,
    required this.id,
  });

  User.fromJson(Map<String, Object?> json)
      : this(
          username: json['username']! as String,
          email: json['email']! as String,
          id: json['id']! as int,
        );

  User copyWith({
    String? username,
    String? email,
    int? id,
  }) {
    return User(
        username: username ?? this.username,
        email: email ?? this.email,
        id: id ?? this.id);
  }

  Map<String, Object?> toJson() {
    return {
      'username': username,
      'email': email,
      'id': id,
    };
  }
}
