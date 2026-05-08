import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../models/auth_user_model.dart';

abstract class IAuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String username, String password);
  Future<AuthUserModel> getCurrentUser(String accessToken);
  Future<Map<String, dynamic>> refreshToken(String refreshToken);
}

@LazySingleton(as: IAuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  static const _baseUrl = 'https://dummyjson.com';

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 60,
      }),
    );
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) return json;
    throw Exception(json['message'] ?? 'Login failed');
  }

  @override
  Future<AuthUserModel> getCurrentUser(String accessToken) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/auth/me'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      return AuthUserModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }
    throw Exception('Session expired');
  }

  @override
  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'refreshToken': refreshToken,
        'expiresInMins': 60,
      }),
    );
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) return json;
    throw Exception('Token refresh failed');
  }
}
