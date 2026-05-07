import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasources/author_remote_datasource.dart';
import '../../data/datasources/book_remote_datasource.dart';
import '../../data/repositories/author_repository_impl.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/repositories/i_author_repository.dart';
import '../../domain/repositories/i_book_repository.dart';
import '../../domain/usecases/add_author_usecase.dart';
import '../../domain/usecases/add_book_usecase.dart';
import '../../domain/usecases/get_authors_usecase.dart';
import '../../domain/usecases/get_books_usecase.dart';
import '../../presentation/cubits/authors/authors_cubit.dart';
import '../../presentation/cubits/books/books_cubit.dart';
import '../../presentation/cubits/locale/locale_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  // Supabase client
  getIt.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );

  // Data sources
  getIt.registerLazySingleton<IAuthorRemoteDataSource>(
    () => AuthorRemoteDataSource(getIt()),
  );
  getIt.registerLazySingleton<IBookRemoteDataSource>(
    () => BookRemoteDataSource(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<IAuthorRepository>(
    () => AuthorRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<IBookRepository>(
    () => BookRepositoryImpl(getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetAuthorsUseCase(getIt()));
  getIt.registerLazySingleton(() => AddAuthorUseCase(getIt()));
  getIt.registerLazySingleton(() => GetBooksUseCase(getIt()));
  getIt.registerLazySingleton(() => AddBookUseCase(getIt()));

  // Cubits
  getIt.registerLazySingleton(() => LocaleCubit());
  getIt.registerFactory(() => AuthorsCubit(getIt(), getIt()));
  getIt.registerFactory(() => BooksCubit(getIt(), getIt()));
}
