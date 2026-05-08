import 'package:injectable/injectable.dart';
import '../repositories/i_auth_repository.dart';

@lazySingleton
class RefreshTokenUseCase {
  final IAuthRepository _repository;
  const RefreshTokenUseCase(this._repository);

  Future<({String accessToken, String refreshToken})> call(String token) =>
      _repository.refreshToken(token);
}
