import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../books/domain/usecases/get_deleted_books_usecase.dart';
import '../../../books/domain/usecases/permanently_delete_book_usecase.dart';
import '../../../books/domain/usecases/restore_book_usecase.dart';
import '../../../authors/domain/usecases/get_deleted_authors_usecase.dart';
import '../../../authors/domain/usecases/permanently_delete_author_usecase.dart';
import '../../../authors/domain/usecases/restore_author_usecase.dart';
import 'trash_state.dart';

@injectable
class TrashCubit extends Cubit<TrashState> {
  final GetDeletedBooksUseCase _getDeletedBooks;
  final GetDeletedAuthorsUseCase _getDeletedAuthors;
  final RestoreBookUseCase _restoreBook;
  final RestoreAuthorUseCase _restoreAuthor;
  final PermanentlyDeleteBookUseCase _permanentlyDeleteBook;
  final PermanentlyDeleteAuthorUseCase _permanentlyDeleteAuthor;

  TrashCubit(
    this._getDeletedBooks,
    this._getDeletedAuthors,
    this._restoreBook,
    this._restoreAuthor,
    this._permanentlyDeleteBook,
    this._permanentlyDeleteAuthor,
  ) : super(const TrashState());

  Future<void> loadTrash() async {
    emit(state.copyWith(
      status: TrashStatus.loading,
      clearError: true,
      clearSuccess: true,
    ));
    try {
      final books = await _getDeletedBooks();
      final authors = await _getDeletedAuthors();
      emit(state.copyWith(
        deletedBooks: books,
        deletedAuthors: authors,
        status: TrashStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: TrashStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> restoreBook(String id) async {
    try {
      await _restoreBook(id);
      await loadTrash();
      emit(state.copyWith(successOperation: 'book_restored'));
    } catch (e) {
      emit(state.copyWith(
          status: TrashStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> restoreAuthor(String id) async {
    try {
      await _restoreAuthor(id);
      await loadTrash();
      emit(state.copyWith(successOperation: 'author_restored'));
    } catch (e) {
      emit(state.copyWith(
          status: TrashStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> permanentlyDeleteBook(String id) async {
    try {
      await _permanentlyDeleteBook(id);
      await loadTrash();
      emit(state.copyWith(successOperation: 'book_permanently_deleted'));
    } catch (e) {
      emit(state.copyWith(
          status: TrashStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> permanentlyDeleteAuthor(String id) async {
    try {
      await _permanentlyDeleteAuthor(id);
      await loadTrash();
      emit(state.copyWith(successOperation: 'author_permanently_deleted'));
    } catch (e) {
      emit(state.copyWith(
          status: TrashStatus.error, errorMessage: e.toString()));
    }
  }
}
