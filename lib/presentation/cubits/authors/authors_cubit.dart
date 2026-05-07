import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/add_author_usecase.dart';
import '../../../domain/usecases/get_authors_usecase.dart';
import 'authors_state.dart';

class AuthorsCubit extends Cubit<AuthorsState> {
  final GetAuthorsUseCase _getAuthors;
  final AddAuthorUseCase _addAuthor;

  AuthorsCubit(this._getAuthors, this._addAuthor)
      : super(const AuthorsState());

  Future<void> loadAuthors() async {
    emit(state.copyWith(status: AuthorsStatus.loading, clearError: true));
    try {
      final authors = await _getAuthors();
      emit(state.copyWith(authors: authors, status: AuthorsStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: AuthorsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addAuthor(String name, {String? imageUrl}) async {
    emit(state.copyWith(status: AuthorsStatus.adding, clearError: true));
    try {
      await _addAuthor(name, imageUrl: imageUrl);
      await loadAuthors();
    } catch (e) {
      emit(state.copyWith(
          status: AuthorsStatus.error, errorMessage: e.toString()));
    }
  }
}
