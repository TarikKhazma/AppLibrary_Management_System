import 'package:injectable/injectable.dart';
import '../repositories/i_book_repository.dart';

@lazySingleton
class DeleteBookUseCase {
  final IBookRepository _repository;
  DeleteBookUseCase(this._repository);
  Future<void> call(String id) => _repository.deleteBook(id);
}
