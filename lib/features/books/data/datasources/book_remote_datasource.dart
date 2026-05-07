import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_string.dart';
import '../models/book_model.dart';

abstract class IBookRemoteDataSource {
  Future<List<BookModel>> getBooks();
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

@LazySingleton(as: IBookRemoteDataSource)
class BookRemoteDataSource implements IBookRemoteDataSource {
  final SupabaseClient _supabase;

  BookRemoteDataSource(this._supabase);

  @override
  Future<List<BookModel>> getBooks() async {
    final response = await _supabase
        .from(AppString.booksTable)
        .select('*, authors(name)')
        .order('created_at', ascending: false);
    return (response as List)
        .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> addBook({
    required String title,
    required int publishedYear,
    required String authorId,
    String? imageUrl,
  }) async {
    await _supabase.from(AppString.booksTable).insert({
      'title': title,
      'published_year': publishedYear,
      'author_id': authorId,
      if (imageUrl != null && imageUrl.isNotEmpty) 'image_url': imageUrl,
    });
  }

  @override
  Future<void> updateBook({
    required String id,
    required String title,
    required int publishedYear,
    required String authorId,
    String? imageUrl,
  }) async {
    await _supabase.from(AppString.booksTable).update({
      'title': title,
      'published_year': publishedYear,
      'author_id': authorId,
      'image_url': imageUrl,
    }).eq('id', id);
  }

  @override
  Future<void> deleteBook(String id) async {
    await _supabase.from(AppString.booksTable).delete().eq('id', id);
  }
}
