import 'package:injectable/injectable.dart';
import '../entities/author.dart';
import '../repositories/i_author_repository.dart';

@lazySingleton
class GetDeletedAuthorsUseCase {
  final IAuthorRepository _repository;
  GetDeletedAuthorsUseCase(this._repository);
  Future<List<Author>> call() => _repository.getDeletedAuthors();
}
