import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_string.dart';
import '../models/author_model.dart';

abstract class IAuthorRemoteDataSource {
  Future<List<AuthorModel>> getAuthors();
  Future<List<AuthorModel>> getDeletedAuthors();
  Future<void> addAuthor(String name, {String? imageUrl});
  Future<void> updateAuthor(String id, String name, {String? imageUrl});
  Future<void> deleteAuthor(String id);
  Future<void> restoreAuthor(String id);
  Future<void> permanentlyDeleteAuthor(String id);
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
        .filter('deleted_at', 'is', null)
        .order('created_at', ascending: false);
    return (response as List)
        .map((e) => AuthorModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<AuthorModel>> getDeletedAuthors() async {
    final thirtyDaysAgo =
        DateTime.now().subtract(const Duration(days: 30)).toIso8601String();
    final response = await _supabase
        .from(AppString.authorsTable)
        .select()
        .not('deleted_at', 'is', null)
        .gte('deleted_at', thirtyDaysAgo)
        .order('deleted_at', ascending: false);
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
    await _supabase
        .from(AppString.authorsTable)
        .update({'deleted_at': DateTime.now().toIso8601String()}).eq('id', id);
  }

  @override
  Future<void> restoreAuthor(String id) async {
    await _supabase
        .from(AppString.authorsTable)
        .update({'deleted_at': null}).eq('id', id);
  }

  @override
  Future<void> permanentlyDeleteAuthor(String id) async {
    await _supabase.from(AppString.authorsTable).delete().eq('id', id);
  }
}
