import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthService {
  static const String baseUrl = "http://10.0.2.2:5000/api";

  // ======== LOGIN ========
  static Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception("Invalid username or password");
    }
  }

  // ======== LOGOUT ========
  static Future<void> logout(String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/logout"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Logout failed");
    }
  }
}
