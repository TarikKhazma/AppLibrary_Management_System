import 'package:injectable/injectable.dart';
import '../../domain/entities/author.dart';
import '../../domain/repositories/i_author_repository.dart';
import '../datasources/author_remote_datasource.dart';

@LazySingleton(as: IAuthorRepository)
class AuthorRepositoryImpl implements IAuthorRepository {
  final IAuthorRemoteDataSource _dataSource;

  AuthorRepositoryImpl(this._dataSource);

  @override
  Future<List<Author>> getAuthors() => _dataSource.getAuthors();

  @override
  Future<List<Author>> getDeletedAuthors() => _dataSource.getDeletedAuthors();

  @override
  Future<void> addAuthor(String name, {String? imageUrl}) =>
      _dataSource.addAuthor(name, imageUrl: imageUrl);

  @override
  Future<void> updateAuthor(String id, String name, {String? imageUrl}) =>
      _dataSource.updateAuthor(id, name, imageUrl: imageUrl);

  @override
  Future<void> deleteAuthor(String id) => _dataSource.deleteAuthor(id);

  @override
  Future<void> restoreAuthor(String id) => _dataSource.restoreAuthor(id);

  @override
  Future<void> permanentlyDeleteAuthor(String id) =>
      _dataSource.permanentlyDeleteAuthor(id);
}
