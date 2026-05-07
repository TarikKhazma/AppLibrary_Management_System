import '../entities/book.dart';

abstract class IBookRepository {
  Future<List<Book>> getBooks();
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
}
