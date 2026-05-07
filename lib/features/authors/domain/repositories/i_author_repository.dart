import '../entities/author.dart';

abstract class IAuthorRepository {
  Future<List<Author>> getAuthors();
  Future<void> addAuthor(String name, {String? imageUrl});
  Future<void> updateAuthor(String id, String name, {String? imageUrl});
  Future<void> deleteAuthor(String id);
}
