import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Android emulator -> your PC. For a real phone use your PC's IP, e.g. http://192.168.1.5:5000
  static const String baseUrl = 'http://10.0.2.2:5000/api';

  static Future<Map<String, dynamic>> _post(String path, Map body) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl$path'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      data['ok'] = res.statusCode >= 200 && res.statusCode < 300;
      return data;
    } catch (e) {
      return {'ok': false, 'message': 'Cannot reach server: $e'};
    }
  }

  static Future<Map<String, dynamic>> signup(
      String name, String email, String password, String mobile) =>
      _post('/auth/signup',
          {'name': name, 'email': email, 'password': password, 'mobile': mobile});

  static Future<Map<String, dynamic>> login(String email, String password) =>
      _post('/auth/login', {'email': email, 'password': password});

  static Future<Map<String, dynamic>> verifyOtp(String email, String otp) =>
      _post('/auth/verify-otp', {'email': email, 'otp': otp});
}