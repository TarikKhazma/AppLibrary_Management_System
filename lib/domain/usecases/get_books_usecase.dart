import '../entities/book.dart';
import '../repositories/i_book_repository.dart';

class GetBooksUseCase {
  final IBookRepository _repository;

  GetBooksUseCase(this._repository);

  Future<List<Book>> call() => _repository.getBooks();
}
