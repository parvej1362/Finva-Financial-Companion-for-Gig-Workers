import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> login(String identifier, String password) async {
    final response = await _apiService.post('/auth/login', {
      'identifier': identifier,
      'password': password,
    });

    return _apiService.parseResponse(response);
  }

  Future<Map<String, dynamic>> loginVerifyOtp(String phone, String otp) async {
    final response = await _apiService.post('/auth/login-verify-otp', {
      'phone': phone,
      'otp': otp,
    });

    final data = _apiService.parseResponse(response);
    if (response.statusCode == 200 && data['token'] != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', data['token']);
    }
    return data;
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String dob,
  }) async {
    final response = await _apiService.post('/auth/register', {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'dob': dob,
    });

    return _apiService.parseResponse(response);
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    final response = await _apiService.post('/auth/verify-otp', {
      'phone': phone,
      'otp': otp,
    });

    return _apiService.parseResponse(response);
  }

  Future<void> logout() async {
    await _apiService.post('/auth/logout', {});
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token');
  }
}
