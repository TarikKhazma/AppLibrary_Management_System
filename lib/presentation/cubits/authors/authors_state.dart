import '../../../domain/entities/author.dart';

enum AuthorsStatus { initial, loading, adding, success, error }

class AuthorsState {
  final List<Author> authors;
  final AuthorsStatus status;
  final String? errorMessage;

  const AuthorsState({
    this.authors = const [],
    this.status = AuthorsStatus.initial,
    this.errorMessage,
  });

  bool get isLoading => status == AuthorsStatus.loading;
  bool get isAdding => status == AuthorsStatus.adding;

  AuthorsState copyWith({
    List<Author>? authors,
    AuthorsStatus? status,
    String? errorMessage,
    bool clearError = false,
  }) =>
      AuthorsState(
        authors: authors ?? this.authors,
        status: status ?? this.status,
        errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      );
}
