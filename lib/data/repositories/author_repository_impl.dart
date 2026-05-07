import '../../domain/entities/author.dart';
import '../../domain/repositories/i_author_repository.dart';
import '../datasources/author_remote_datasource.dart';

class AuthorRepositoryImpl implements IAuthorRepository {
  final IAuthorRemoteDataSource _dataSource;

  AuthorRepositoryImpl(this._dataSource);

  @override
  Future<List<Author>> getAuthors() => _dataSource.getAuthors();

  @override
  Future<void> addAuthor(String name, {String? imageUrl}) =>
      _dataSource.addAuthor(name, imageUrl: imageUrl);

  @override
  Future<void> deleteAuthor(String id) => _dataSource.deleteAuthor(id);
}
