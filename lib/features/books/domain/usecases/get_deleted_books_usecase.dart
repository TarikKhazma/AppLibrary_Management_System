import 'package:injectable/injectable.dart';
import '../entities/book.dart';
import '../repositories/i_book_repository.dart';

@lazySingleton
class GetDeletedBooksUseCase {
  final IBookRepository _repository;
  GetDeletedBooksUseCase(this._repository);
  Future<List<Book>> call() => _repository.getDeletedBooks();
}
