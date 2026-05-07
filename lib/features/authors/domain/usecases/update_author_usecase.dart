import 'package:injectable/injectable.dart';
import '../repositories/i_author_repository.dart';

@lazySingleton
class UpdateAuthorUseCase {
  final IAuthorRepository _repository;
  UpdateAuthorUseCase(this._repository);
  Future<void> call(String id, String name, {String? imageUrl}) =>
      _repository.updateAuthor(id, name, imageUrl: imageUrl);
}
