class UserModel {
  String? username;
  String? email;
  String? id;

  UserModel({required this.username, required this.email, required this.id});

  // Construtor que cria uma instância de UserModel a partir de um Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      id: json['id'],
    );
  }

  // Método para converter a instância de UserModel de volta para um Map
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'id': id,
    };
  }
}
