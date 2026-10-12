import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://finva-g6g9.onrender.com/api';

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders();
    try {
      final response = await http
          .post(
            url,
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      return http.Response(jsonEncode({'error': 'Connection failed: $e'}), 503);
    }
  }

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders();
    try {
      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      return http.Response(jsonEncode({'error': 'Connection failed: $e'}), 503);
    }
  }

  Map<String, dynamic> parseResponse(http.Response response) {
    try {
      return jsonDecode(response.body);
    } catch (e) {
      return {
        'error':
            'Server returned an invalid response. Status: ${response.statusCode}',
        'details': response.body.length > 100
            ? response.body.substring(0, 100)
            : response.body
      };
    }
  }
}
