import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qutoes_app/core/model/user_model.dart';

class AuthService {
  static const String baseUrl = "https://article-api-z472.onrender.com/api"; 

  static Future<UserModel?> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception("Failed to register: ${response.body}");
    }
  }

  static Future<UserModel?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception("Failed to login: ${response.body}");
    }
  }
}
