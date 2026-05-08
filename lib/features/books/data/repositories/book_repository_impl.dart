import 'package:injectable/injectable.dart';
import '../../domain/entities/book.dart';
import '../../domain/repositories/i_book_repository.dart';
import '../datasources/book_remote_datasource.dart';

@LazySingleton(as: IBookRepository)
class BookRepositoryImpl implements IBookRepository {
  final IBookRemoteDataSource _dataSource;

  BookRepositoryImpl(this._dataSource);

  @override
  Future<List<Book>> getBooks() => _dataSource.getBooks();

  @override
  Future<List<Book>> getDeletedBooks() => _dataSource.getDeletedBooks();

  @override
  Future<void> addBook({
    required String title,
    required int publishedYear,
    required String authorId,
    String? imageUrl,
  }) =>
      _dataSource.addBook(
        title: title,
        publishedYear: publishedYear,
        authorId: authorId,
        imageUrl: imageUrl,
      );

  @override
  Future<void> updateBook({
    required String id,
    required String title,
    required int publishedYear,
    required String authorId,
    String? imageUrl,
  }) =>
      _dataSource.updateBook(
        id: id,
        title: title,
        publishedYear: publishedYear,
        authorId: authorId,
        imageUrl: imageUrl,
      );

  @override
  Future<void> deleteBook(String id) => _dataSource.deleteBook(id);

  @override
  Future<void> restoreBook(String id) => _dataSource.restoreBook(id);

  @override
  Future<void> permanentlyDeleteBook(String id) =>
      _dataSource.permanentlyDeleteBook(id);
}
