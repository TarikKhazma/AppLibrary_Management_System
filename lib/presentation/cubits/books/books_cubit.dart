import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/add_book_usecase.dart';
import '../../../domain/usecases/get_books_usecase.dart';
import 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  final GetBooksUseCase _getBooks;
  final AddBookUseCase _addBook;

  BooksCubit(this._getBooks, this._addBook) : super(const BooksState());

  Future<void> loadBooks() async {
    emit(state.copyWith(status: BooksStatus.loading, clearError: true));
    try {
      final books = await _getBooks();
      emit(state.copyWith(books: books, status: BooksStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: BooksStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addBook({
    required String title,
    required int publishedYear,
    required String authorId,
    String? imageUrl,
  }) async {
    emit(state.copyWith(status: BooksStatus.adding, clearError: true));
    try {
      await _addBook(
        title: title,
        publishedYear: publishedYear,
        authorId: authorId,
        imageUrl: imageUrl,
      );
      await loadBooks();
    } catch (e) {
      emit(state.copyWith(
          status: BooksStatus.error, errorMessage: e.toString()));
    }
  }
}
