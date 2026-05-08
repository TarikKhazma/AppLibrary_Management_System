import '../entities/author.dart';

abstract class IAuthorRepository {
  Future<List<Author>> getAuthors();
  Future<List<Author>> getDeletedAuthors();
  Future<void> addAuthor(String name, {String? imageUrl});
  Future<void> updateAuthor(String id, String name, {String? imageUrl});
  Future<void> deleteAuthor(String id);
  Future<void> restoreAuthor(String id);
  Future<void> permanentlyDeleteAuthor(String id);
}
