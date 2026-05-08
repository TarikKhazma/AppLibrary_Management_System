import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/refresh_token_usecase.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  final IAuthRepository _authRepository;

  AuthCubit({
    required LoginUseCase loginUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required RefreshTokenUseCase refreshTokenUseCase,
    required IAuthRepository authRepository,
  })  : _loginUseCase = loginUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _refreshTokenUseCase = refreshTokenUseCase,
        _authRepository = authRepository,
        super(AuthState.initial());

  Future<void> checkAuth() async {
    final accessToken = await _authRepository.getAccessToken();
    if (accessToken == null) {
      emit(AuthState.unauthenticated());
      return;
    }
    emit(AuthState.loading());
    try {
      final user = await _getCurrentUserUseCase(accessToken);
      emit(AuthState.authenticated(user));
    } catch (_) {
      final refreshToken = await _authRepository.getRefreshToken();
      if (refreshToken == null) {
        emit(AuthState.unauthenticated());
        return;
      }
      try {
        final tokens = await _refreshTokenUseCase(refreshToken);
        final user = await _getCurrentUserUseCase(tokens.accessToken);
        emit(AuthState.authenticated(user));
      } catch (_) {
        await _authRepository.clearTokens();
        emit(AuthState.unauthenticated());
      }
    }
  }

  Future<void> login(String username, String password) async {
    emit(AuthState.loading());
    try {
      final user = await _loginUseCase(username, password);
      emit(AuthState.authenticated(user));
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> logout() async {
    await _authRepository.clearTokens();
    emit(AuthState.unauthenticated());
  }
}
