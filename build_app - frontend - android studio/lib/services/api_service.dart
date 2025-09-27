import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/property_model.dart';
import '../models/agent_model.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:5000";

  // ======== PROPERTY ========
  static Future<List<Property>> getProperties() async {
    final response = await http.get(Uri.parse("$baseUrl/api/properties"));
    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((e) => Property.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load properties");
    }
  }

  static Future<void> addProperty(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/properties"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to add property");
    }
  }

  static Future<void> deleteProperty(String id) async {
    final response = await http.delete(
        Uri.parse("$baseUrl/api/properties/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete property");
    }
  }

  // ======== AGENT ========
  static Future<List<Agent>> getAgents() async {
    final response = await http.get(Uri.parse("$baseUrl/api/agents"));
    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((e) => Agent.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load agents");
    }
  }

  static Future<void> addAgent(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/agents"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to add agent");
    }
  }

  static Future<void> deleteAgent(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/api/agents/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete agent");
    }
  }

  // ======== TEST GET REQUEST ========
  static Future<void> testGetRequest() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/test"));
      if (response.statusCode == 200) {
        print("Backend Response: ${response.body}");
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  // ======== AUTH ========


  // ======== AUTH ========
  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/auth/login"), // updated
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        print("Login Success: ${response.body}");
        return true;
      } else {
        print("Login Failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception during login: $e");
      return false;
    }
  }

  static Future<bool> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/auth/register"), // updated
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Register Success: ${response.body}");
        return true;
      } else {
        print("Register Failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception during register: $e");
      return false;
    }
  }

  static Future<void> logout() async {}


}