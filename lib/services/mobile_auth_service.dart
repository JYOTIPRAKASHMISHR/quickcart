import 'dart:convert';

import 'package:http/http.dart' as http;

class MobileAuthService {

  // SPRING BOOT BASE URL
  static const String baseUrl =
      "http://10.248.129.139:8080/api/mobile";

  // SIGNUP
  static Future<Map<String, dynamic>> signup({

    required String name,
    required String email,
    required String phone,
    required String password,

  }) async {

    final response = await http.post(

      Uri.parse("$baseUrl/signup"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({

        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      }),
    );

    return {
      "status": response.statusCode,
      "body": response.body,
    };
  }

  // LOGIN
  static Future<Map<String, dynamic>> login({

    required String email,
    required String password,

  }) async {

    final response = await http.post(

      Uri.parse("$baseUrl/login"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({

        "email": email,
        "password": password,
      }),
    );

    return {
      "status": response.statusCode,
      "body": jsonDecode(response.body),
    };
  }
}

