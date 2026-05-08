import 'package:injectable/injectable.dart';
import '../entities/auth_user.dart';
import '../repositories/i_auth_repository.dart';

@lazySingleton
class LoginUseCase {
  final IAuthRepository _repository;
  const LoginUseCase(this._repository);

  Future<AuthUser> call(String username, String password) =>
      _repository.login(username, password);
}
