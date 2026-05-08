import '../entities/book.dart';

abstract class IBookRepository {
  Future<List<Book>> getBooks();
  Future<List<Book>> getDeletedBooks();
  Future<void> addBook({
    required String title,
    required int publishedYear,
    required String authorId,
    String? imageUrl,
  });
  Future<void> updateBook({
    required String id,
    required String title,
    required int publishedYear,
    required String authorId,
    String? imageUrl,
  });
  Future<void> deleteBook(String id);
  Future<void> restoreBook(String id);
  Future<void> permanentlyDeleteBook(String id);
}
