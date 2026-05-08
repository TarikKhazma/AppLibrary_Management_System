import 'package:injectable/injectable.dart';
import '../entities/auth_user.dart';
import '../repositories/i_auth_repository.dart';

@lazySingleton
class GetCurrentUserUseCase {
  final IAuthRepository _repository;
  const GetCurrentUserUseCase(this._repository);

  Future<AuthUser> call(String accessToken) =>
      _repository.getCurrentUser(accessToken);
}
