import '../../domain/entities/book.dart';

enum BooksStatus { initial, loading, adding, success, error }

class BooksState {
  final List<Book> books;
  final BooksStatus status;
  final String? errorMessage;
  final String? successOperation; // 'added' | 'updated' | 'deleted'

  const BooksState({
    this.books = const [],
    this.status = BooksStatus.initial,
    this.errorMessage,
    this.successOperation,
  });

  bool get isLoading => status == BooksStatus.loading;
  bool get isAdding => status == BooksStatus.adding;

  BooksState copyWith({
    List<Book>? books,
    BooksStatus? status,
    String? errorMessage,
    bool clearError = false,
    String? successOperation,
    bool clearSuccess = false,
  }) =>
      BooksState(
        books: books ?? this.books,
        status: status ?? this.status,
        errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
        successOperation:
            clearSuccess ? null : (successOperation ?? this.successOperation),
      );
}
