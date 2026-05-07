import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_string.dart';
import '../models/author_model.dart';

abstract class IAuthorRemoteDataSource {
  Future<List<AuthorModel>> getAuthors();
  Future<void> addAuthor(String name, {String? imageUrl});
  Future<void> updateAuthor(String id, String name, {String? imageUrl});
  Future<void> deleteAuthor(String id);
}

@LazySingleton(as: IAuthorRemoteDataSource)
class AuthorRemoteDataSource implements IAuthorRemoteDataSource {
  final SupabaseClient _supabase;

  AuthorRemoteDataSource(this._supabase);

  @override
  Future<List<AuthorModel>> getAuthors() async {
    final response = await _supabase
        .from(AppString.authorsTable)
        .select()
        .order('created_at', ascending: false);
    return (response as List)
        .map((e) => AuthorModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> addAuthor(String name, {String? imageUrl}) async {
    await _supabase.from(AppString.authorsTable).insert({
      'name': name,
      if (imageUrl != null && imageUrl.isNotEmpty) 'image_url': imageUrl,
    });
  }

  @override
  Future<void> updateAuthor(String id, String name, {String? imageUrl}) async {
    await _supabase.from(AppString.authorsTable).update({
      'name': name,
      'image_url': imageUrl,
    }).eq('id', id);
  }

  @override
  Future<void> deleteAuthor(String id) async {
    await _supabase.from(AppString.authorsTable).delete().eq('id', id);
  }
}
