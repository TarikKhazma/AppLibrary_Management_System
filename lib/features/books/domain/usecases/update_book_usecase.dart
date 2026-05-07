import 'package:injectable/injectable.dart';
import '../repositories/i_book_repository.dart';

@lazySingleton
class UpdateBookUseCase {
  final IBookRepository _repository;
  UpdateBookUseCase(this._repository);

  Future<void> call({
    required String id,
    required String title,
    required int publishedYear,
    required String authorId,
    String? imageUrl,
  }) =>
      _repository.updateBook(
        id: id,
        title: title,
        publishedYear: publishedYear,
        authorId: authorId,
        imageUrl: imageUrl,
      );
}
