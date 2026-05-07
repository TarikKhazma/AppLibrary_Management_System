import 'package:injectable/injectable.dart';
import '../entities/author.dart';
import '../repositories/i_author_repository.dart';

@lazySingleton
class GetAuthorsUseCase {
  final IAuthorRepository _repository;

  GetAuthorsUseCase(this._repository);

  Future<List<Author>> call() => _repository.getAuthors();
}
