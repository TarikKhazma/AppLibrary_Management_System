import 'package:injectable/injectable.dart';
import '../repositories/i_author_repository.dart';

@lazySingleton
class PermanentlyDeleteAuthorUseCase {
  final IAuthorRepository _repository;
  PermanentlyDeleteAuthorUseCase(this._repository);
  Future<void> call(String id) => _repository.permanentlyDeleteAuthor(id);
}
