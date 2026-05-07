import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/add_book_usecase.dart';
import '../../domain/usecases/delete_book_usecase.dart';
import '../../domain/usecases/get_books_usecase.dart';
import '../../domain/usecases/update_book_usecase.dart';
import 'books_state.dart';

@injectable
class BooksCubit extends Cubit<BooksState> {
  final GetBooksUseCase _getBooks;
  final AddBookUseCase _addBook;
  final DeleteBookUseCase _deleteBook;
  final UpdateBookUseCase _updateBook;

  BooksCubit(this._getBooks, this._addBook, this._deleteBook, this._updateBook)
      : super(const BooksState());

  Future<void> loadBooks({String? successOperation}) async {
    emit(state.copyWith(
      status: BooksStatus.loading,
      clearError: true,
      clearSuccess: true,
    ));
    try {
      final books = await _getBooks();
      emit(state.copyWith(
        books: books,
        status: BooksStatus.success,
        successOperation: successOperation,
      ));
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
      await loadBooks(successOperation: 'added');
    } catch (e) {
      emit(state.copyWith(
          status: BooksStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> deleteBook(String id) async {
    try {
      await _deleteBook(id);
      await loadBooks(successOperation: 'deleted');
    } catch (e) {
      emit(state.copyWith(
          status: BooksStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> updateBook({
    required String id,
    required String title,
    required int publishedYear,
    required String authorId,
    String? imageUrl,
  }) async {
    emit(state.copyWith(status: BooksStatus.adding, clearError: true));
    try {
      await _updateBook(
        id: id,
        title: title,
        publishedYear: publishedYear,
        authorId: authorId,
        imageUrl: imageUrl,
      );
      await loadBooks(successOperation: 'updated');
    } catch (e) {
      emit(state.copyWith(
          status: BooksStatus.error, errorMessage: e.toString()));
    }
  }
}
