import '../repositories/i_book_repository.dart';

class AddBookUseCase {
  final IBookRepository _repository;

  AddBookUseCase(this._repository);

  Future<void> call({
    required String title,
    required int publishedYear,
    required String authorId,
    String? imageUrl,
  }) =>
      _repository.addBook(
        title: title,
        publishedYear: publishedYear,
        authorId: authorId,
        imageUrl: imageUrl,
      );
}
