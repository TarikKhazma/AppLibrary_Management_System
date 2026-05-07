import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/add_author_usecase.dart';
import '../../domain/usecases/delete_author_usecase.dart';
import '../../domain/usecases/get_authors_usecase.dart';
import '../../domain/usecases/update_author_usecase.dart';
import 'authors_state.dart';

@injectable
class AuthorsCubit extends Cubit<AuthorsState> {
  final GetAuthorsUseCase _getAuthors;
  final AddAuthorUseCase _addAuthor;
  final DeleteAuthorUseCase _deleteAuthor;
  final UpdateAuthorUseCase _updateAuthor;

  AuthorsCubit(
    this._getAuthors,
    this._addAuthor,
    this._deleteAuthor,
    this._updateAuthor,
  ) : super(const AuthorsState());

  Future<void> loadAuthors({String? successOperation}) async {
    emit(state.copyWith(
      status: AuthorsStatus.loading,
      clearError: true,
      clearSuccess: true,
    ));
    try {
      final authors = await _getAuthors();
      emit(state.copyWith(
        authors: authors,
        status: AuthorsStatus.success,
        successOperation: successOperation,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: AuthorsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addAuthor(String name, {String? imageUrl}) async {
    emit(state.copyWith(status: AuthorsStatus.adding, clearError: true));
    try {
      await _addAuthor(name, imageUrl: imageUrl);
      await loadAuthors(successOperation: 'added');
    } catch (e) {
      emit(state.copyWith(
          status: AuthorsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> deleteAuthor(String id) async {
    try {
      await _deleteAuthor(id);
      await loadAuthors(successOperation: 'deleted');
    } catch (e) {
      emit(state.copyWith(
          status: AuthorsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> updateAuthor(String id, String name, {String? imageUrl}) async {
    emit(state.copyWith(status: AuthorsStatus.adding, clearError: true));
    try {
      await _updateAuthor(id, name, imageUrl: imageUrl);
      await loadAuthors(successOperation: 'updated');
    } catch (e) {
      emit(state.copyWith(
          status: AuthorsStatus.error, errorMessage: e.toString()));
    }
  }
}
