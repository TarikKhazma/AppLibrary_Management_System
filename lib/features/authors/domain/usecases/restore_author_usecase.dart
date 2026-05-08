import 'package:injectable/injectable.dart';
import '../repositories/i_author_repository.dart';

@lazySingleton
class RestoreAuthorUseCase {
  final IAuthorRepository _repository;
  RestoreAuthorUseCase(this._repository);
  Future<void> call(String id) => _repository.restoreAuthor(id);
}
