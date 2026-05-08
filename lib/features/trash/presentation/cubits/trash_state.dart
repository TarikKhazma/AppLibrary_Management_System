import '../../../books/domain/entities/book.dart';
import '../../../authors/domain/entities/author.dart';

enum TrashStatus { initial, loading, success, error }

class TrashState {
  final List<Book> deletedBooks;
  final List<Author> deletedAuthors;
  final TrashStatus status;
  final String? errorMessage;
  final String? successOperation;

  const TrashState({
    this.deletedBooks = const [],
    this.deletedAuthors = const [],
    this.status = TrashStatus.initial,
    this.errorMessage,
    this.successOperation,
  });

  bool get isLoading => status == TrashStatus.loading;

  TrashState copyWith({
    List<Book>? deletedBooks,
    List<Author>? deletedAuthors,
    TrashStatus? status,
    String? errorMessage,
    bool clearError = false,
    String? successOperation,
    bool clearSuccess = false,
  }) =>
      TrashState(
        deletedBooks: deletedBooks ?? this.deletedBooks,
        deletedAuthors: deletedAuthors ?? this.deletedAuthors,
        status: status ?? this.status,
        errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
        successOperation:
            clearSuccess ? null : (successOperation ?? this.successOperation),
      );
}
