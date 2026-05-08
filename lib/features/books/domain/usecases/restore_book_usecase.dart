import 'package:injectable/injectable.dart';
import '../repositories/i_book_repository.dart';

@lazySingleton
class RestoreBookUseCase {
  final IBookRepository _repository;
  RestoreBookUseCase(this._repository);
  Future<void> call(String id) => _repository.restoreBook(id);
}
