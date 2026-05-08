import '../entities/auth_user.dart';

abstract class IAuthRepository {
  Future<AuthUser> login(String username, String password);
  Future<AuthUser> getCurrentUser(String accessToken);
  Future<({String accessToken, String refreshToken})> refreshToken(String token);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
}
