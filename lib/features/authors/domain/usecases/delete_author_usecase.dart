import 'package:injectable/injectable.dart';
import '../repositories/i_author_repository.dart';

@lazySingleton
class DeleteAuthorUseCase {
  final IAuthorRepository _repository;
  DeleteAuthorUseCase(this._repository);
  Future<void> call(String id) => _repository.deleteAuthor(id);
}
