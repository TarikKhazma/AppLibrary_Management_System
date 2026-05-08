// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:library_management_system/core/di/register_module.dart'
    as _i453;
import 'package:library_management_system/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i100;
import 'package:library_management_system/features/auth/data/repositories/auth_repository_impl.dart'
    as _i101;
import 'package:library_management_system/features/auth/domain/repositories/i_auth_repository.dart'
    as _i102;
import 'package:library_management_system/features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i103;
import 'package:library_management_system/features/auth/domain/usecases/login_usecase.dart'
    as _i104;
import 'package:library_management_system/features/auth/domain/usecases/refresh_token_usecase.dart'
    as _i105;
import 'package:library_management_system/features/auth/presentation/cubits/auth_cubit.dart'
    as _i106;
import 'package:library_management_system/features/authors/data/datasources/author_remote_datasource.dart'
    as _i828;
import 'package:library_management_system/features/authors/data/repositories/author_repository_impl.dart'
    as _i766;
import 'package:library_management_system/features/authors/domain/repositories/i_author_repository.dart'
    as _i178;
import 'package:library_management_system/features/authors/domain/usecases/add_author_usecase.dart'
    as _i391;
import 'package:library_management_system/features/authors/domain/usecases/delete_author_usecase.dart'
    as _i816;
import 'package:library_management_system/features/authors/domain/usecases/get_authors_usecase.dart'
    as _i566;
import 'package:library_management_system/features/authors/domain/usecases/get_deleted_authors_usecase.dart'
    as _i601;
import 'package:library_management_system/features/authors/domain/usecases/permanently_delete_author_usecase.dart'
    as _i701;
import 'package:library_management_system/features/authors/domain/usecases/restore_author_usecase.dart'
    as _i801;
import 'package:library_management_system/features/authors/domain/usecases/update_author_usecase.dart'
    as _i852;
import 'package:library_management_system/features/authors/presentation/cubits/authors_cubit.dart'
    as _i713;
import 'package:library_management_system/features/books/data/datasources/book_remote_datasource.dart'
    as _i127;
import 'package:library_management_system/features/books/data/repositories/book_repository_impl.dart'
    as _i328;
import 'package:library_management_system/features/books/domain/repositories/i_book_repository.dart'
    as _i610;
import 'package:library_management_system/features/books/domain/usecases/add_book_usecase.dart'
    as _i198;
import 'package:library_management_system/features/books/domain/usecases/delete_book_usecase.dart'
    as _i312;
import 'package:library_management_system/features/books/domain/usecases/get_books_usecase.dart'
    as _i742;
import 'package:library_management_system/features/books/domain/usecases/get_deleted_books_usecase.dart'
    as _i602;
import 'package:library_management_system/features/books/domain/usecases/permanently_delete_book_usecase.dart'
    as _i702;
import 'package:library_management_system/features/books/domain/usecases/restore_book_usecase.dart'
    as _i802;
import 'package:library_management_system/features/books/domain/usecases/update_book_usecase.dart'
    as _i43;
import 'package:library_management_system/features/books/presentation/cubits/books_cubit.dart'
    as _i1057;
import 'package:library_management_system/features/trash/presentation/cubits/trash_cubit.dart'
    as _i900;
import 'package:library_management_system/shared/cubits/locale/locale_cubit.dart'
    as _i464;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i100.IAuthRemoteDataSource>(
      () => _i100.AuthRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i102.IAuthRepository>(
      () => _i101.AuthRepositoryImpl(gh<_i100.IAuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i104.LoginUseCase>(
      () => _i104.LoginUseCase(gh<_i102.IAuthRepository>()),
    );
    gh.lazySingleton<_i103.GetCurrentUserUseCase>(
      () => _i103.GetCurrentUserUseCase(gh<_i102.IAuthRepository>()),
    );
    gh.lazySingleton<_i105.RefreshTokenUseCase>(
      () => _i105.RefreshTokenUseCase(gh<_i102.IAuthRepository>()),
    );
    gh.factory<_i106.AuthCubit>(
      () => _i106.AuthCubit(
        loginUseCase: gh<_i104.LoginUseCase>(),
        getCurrentUserUseCase: gh<_i103.GetCurrentUserUseCase>(),
        refreshTokenUseCase: gh<_i105.RefreshTokenUseCase>(),
        authRepository: gh<_i102.IAuthRepository>(),
      ),
    );
    gh.lazySingleton<_i464.LocaleCubit>(() => _i464.LocaleCubit());
    gh.lazySingleton<_i127.IBookRemoteDataSource>(
      () => _i127.BookRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i828.IAuthorRemoteDataSource>(
      () => _i828.AuthorRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i178.IAuthorRepository>(
      () => _i766.AuthorRepositoryImpl(gh<_i828.IAuthorRemoteDataSource>()),
    );
    gh.lazySingleton<_i610.IBookRepository>(
      () => _i328.BookRepositoryImpl(gh<_i127.IBookRemoteDataSource>()),
    );
    gh.lazySingleton<_i391.AddAuthorUseCase>(
      () => _i391.AddAuthorUseCase(gh<_i178.IAuthorRepository>()),
    );
    gh.lazySingleton<_i816.DeleteAuthorUseCase>(
      () => _i816.DeleteAuthorUseCase(gh<_i178.IAuthorRepository>()),
    );
    gh.lazySingleton<_i566.GetAuthorsUseCase>(
      () => _i566.GetAuthorsUseCase(gh<_i178.IAuthorRepository>()),
    );
    gh.lazySingleton<_i601.GetDeletedAuthorsUseCase>(
      () => _i601.GetDeletedAuthorsUseCase(gh<_i178.IAuthorRepository>()),
    );
    gh.lazySingleton<_i701.PermanentlyDeleteAuthorUseCase>(
      () =>
          _i701.PermanentlyDeleteAuthorUseCase(gh<_i178.IAuthorRepository>()),
    );
    gh.lazySingleton<_i801.RestoreAuthorUseCase>(
      () => _i801.RestoreAuthorUseCase(gh<_i178.IAuthorRepository>()),
    );
    gh.lazySingleton<_i852.UpdateAuthorUseCase>(
      () => _i852.UpdateAuthorUseCase(gh<_i178.IAuthorRepository>()),
    );
    gh.factory<_i713.AuthorsCubit>(
      () => _i713.AuthorsCubit(
        gh<_i566.GetAuthorsUseCase>(),
        gh<_i391.AddAuthorUseCase>(),
        gh<_i816.DeleteAuthorUseCase>(),
        gh<_i852.UpdateAuthorUseCase>(),
      ),
    );
    gh.lazySingleton<_i198.AddBookUseCase>(
      () => _i198.AddBookUseCase(gh<_i610.IBookRepository>()),
    );
    gh.lazySingleton<_i312.DeleteBookUseCase>(
      () => _i312.DeleteBookUseCase(gh<_i610.IBookRepository>()),
    );
    gh.lazySingleton<_i742.GetBooksUseCase>(
      () => _i742.GetBooksUseCase(gh<_i610.IBookRepository>()),
    );
    gh.lazySingleton<_i602.GetDeletedBooksUseCase>(
      () => _i602.GetDeletedBooksUseCase(gh<_i610.IBookRepository>()),
    );
    gh.lazySingleton<_i702.PermanentlyDeleteBookUseCase>(
      () => _i702.PermanentlyDeleteBookUseCase(gh<_i610.IBookRepository>()),
    );
    gh.lazySingleton<_i802.RestoreBookUseCase>(
      () => _i802.RestoreBookUseCase(gh<_i610.IBookRepository>()),
    );
    gh.lazySingleton<_i43.UpdateBookUseCase>(
      () => _i43.UpdateBookUseCase(gh<_i610.IBookRepository>()),
    );
    gh.factory<_i1057.BooksCubit>(
      () => _i1057.BooksCubit(
        gh<_i742.GetBooksUseCase>(),
        gh<_i198.AddBookUseCase>(),
        gh<_i312.DeleteBookUseCase>(),
        gh<_i43.UpdateBookUseCase>(),
      ),
    );
    gh.factory<_i900.TrashCubit>(
      () => _i900.TrashCubit(
        gh<_i602.GetDeletedBooksUseCase>(),
        gh<_i601.GetDeletedAuthorsUseCase>(),
        gh<_i802.RestoreBookUseCase>(),
        gh<_i801.RestoreAuthorUseCase>(),
        gh<_i702.PermanentlyDeleteBookUseCase>(),
        gh<_i701.PermanentlyDeleteAuthorUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i453.RegisterModule {}
