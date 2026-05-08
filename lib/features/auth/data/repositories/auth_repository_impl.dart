import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_user_model.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource _remote;

  static const _accessTokenKey = 'auth_access_token';
  static const _refreshTokenKey = 'auth_refresh_token';

  AuthRepositoryImpl(this._remote);

  @override
  Future<AuthUser> login(String username, String password) async {
    final data = await _remote.login(username, password);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, data['accessToken'] as String);
    await prefs.setString(_refreshTokenKey, data['refreshToken'] as String);
    return AuthUserModel.fromJson(data);
  }

  @override
  Future<AuthUser> getCurrentUser(String accessToken) =>
      _remote.getCurrentUser(accessToken);

  @override
  Future<({String accessToken, String refreshToken})> refreshToken(
    String token,
  ) async {
    final data = await _remote.refreshToken(token);
    final newAccess = data['accessToken'] as String;
    final newRefresh = data['refreshToken'] as String;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, newAccess);
    await prefs.setString(_refreshTokenKey, newRefresh);
    return (accessToken: newAccess, refreshToken: newRefresh);
  }

  @override
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  @override
  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
  }
}
