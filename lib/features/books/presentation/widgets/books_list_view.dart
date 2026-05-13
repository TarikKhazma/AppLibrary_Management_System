import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../authors/presentation/cubits/authors_cubit.dart';
import '../../../authors/presentation/cubits/authors_state.dart';
import '../cubits/books_cubit.dart';
import '../cubits/books_state.dart';
import 'book_list_item.dart';
import 'books_list_header.dart';
import 'edit_book_dialog.dart';

class BooksListView extends StatelessWidget {
  const BooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BlocConsumer<BooksCubit, BooksState>(
      listenWhen: (prev, curr) =>
          curr.status == BooksStatus.success ||
          curr.status == BooksStatus.error,
      listener: (context, state) {
        if (state.status == BooksStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.error,
            ),
          );
        }
        if (state.successOperation != null) {
          final loc = AppLocalizations.of(context);
          final message = switch (state.successOperation) {
            'added' => loc.bookAddedSuccess,
            'deleted' => loc.bookDeletedSuccess,
            'updated' => loc.bookUpdatedSuccess,
            _ => loc.success,
          };
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state.books.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.menu_book_outlined,
                    size: 64, color: AppColors.textHint),
                const SizedBox(height: AppSize.md),
                Text(
                  loc.noBooks,
                  style: AppTextStyle.bodyLarge
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            BooksListHeader(
              count: state.books.length,
              countLabel: loc.books,
              title: loc.booksList,
            ),
            Expanded(
              child: BlocBuilder<AuthorsCubit, AuthorsState>(
                builder: (context, authState) => ListView.builder(
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    final book = state.books[index];
                    return BookListItem(
                      book: book,
                      index: index,
                      onDelete: () =>
                          context.read<BooksCubit>().deleteBook(book.id),
                      onEdit: () => showDialog<void>(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<BooksCubit>(),
                          child: EditBookDialog(
                            book: book,
                            authors: authState.authors,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
