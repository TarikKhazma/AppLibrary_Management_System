import 'package:injectable/injectable.dart';
import '../repositories/i_book_repository.dart';

@lazySingleton
class PermanentlyDeleteBookUseCase {
  final IBookRepository _repository;
  PermanentlyDeleteBookUseCase(this._repository);
  Future<void> call(String id) => _repository.permanentlyDeleteBook(id);
}
