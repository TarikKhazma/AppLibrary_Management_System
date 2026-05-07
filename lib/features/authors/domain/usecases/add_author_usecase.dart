import 'package:injectable/injectable.dart';
import '../repositories/i_author_repository.dart';

@lazySingleton
class AddAuthorUseCase {
  final IAuthorRepository _repository;

  AddAuthorUseCase(this._repository);

  Future<void> call(String name, {String? imageUrl}) =>
      _repository.addAuthor(name, imageUrl: imageUrl);
}
