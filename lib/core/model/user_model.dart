class UserModel {
  final String token;

  UserModel({required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserModel(token: json['token'] ?? '');
  }
}
