import '../../domain/entities/book.dart';
import '../../domain/repositories/i_book_repository.dart';
import '../datasources/book_remote_datasource.dart';

class BookRepositoryImpl implements IBookRepository {
  final IBookRemoteDataSource _dataSource;

  BookRepositoryImpl(this._dataSource);

  @override
  Future<List<Book>> getBooks() => _dataSource.getBooks();

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
  Future<void> deleteBook(String id) => _dataSource.deleteBook(id);
}
