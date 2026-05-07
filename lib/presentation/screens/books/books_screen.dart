import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/di/injection.dart';
import '../../../core/localization/app_localizations.dart';
import '../../cubits/authors/authors_cubit.dart';
import '../../cubits/authors/authors_state.dart';
import '../../cubits/books/books_cubit.dart';
import '../../cubits/books/books_state.dart';
import '../../widgets/books/add_book_form.dart';
import '../../widgets/books/book_list_item.dart';
import '../../widgets/common/gradient_app_bar.dart';
import '../../widgets/nav_bar/bottom_nav_bar.dart';

class BooksScreen extends StatelessWidget {
  final NavItem currentNavItem;
  final void Function(NavItem) onNavItemSelected;

  const BooksScreen({
    super.key,
    required this.currentNavItem,
    required this.onNavItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<BooksCubit>()..loadBooks()),
        BlocProvider(create: (_) => getIt<AuthorsCubit>()..loadAuthors()),
      ],
      child: _BooksBody(
        currentNavItem: currentNavItem,
        onNavItemSelected: onNavItemSelected,
      ),
    );
  }
}

class _BooksBody extends StatelessWidget {
  final NavItem currentNavItem;
  final void Function(NavItem) onNavItemSelected;

  const _BooksBody({
    required this.currentNavItem,
    required this.onNavItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: GradientAppBar(title: loc.books),
      body: Column(
        children: [
          // Add book form with authors dropdown
          BlocBuilder<AuthorsCubit, AuthorsState>(
            builder: (context, authState) => AddBookForm(
              authors: authState.authors,
            ),
          ),
          Expanded(child: _buildList(context, loc)),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentItem: currentNavItem,
        onItemSelected: onNavItemSelected,
      ),
    );
  }

  Widget _buildList(BuildContext context, AppLocalizations loc) {
    return BlocConsumer<BooksCubit, BooksState>(
      listener: (context, state) {
        if (state.status == BooksStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.error,
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
                Text(loc.noBooks,
                    style: AppTextStyle.bodyLarge
                        .copyWith(color: AppColors.textSecondary)),
              ],
            ),
          );
        }

        return Column(
          children: [
            // List header
            _BooksListHeader(
              count: state.books.length,
              countLabel: loc.books,
              title: loc.booksList,
            ),
            // Books list
            Expanded(
              child: ListView.builder(
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return BookListItem(
                    book: book,
                    index: index,
                    onDelete: () => context.read<BooksCubit>().loadBooks(),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BooksListHeader extends StatelessWidget {
  final int count;
  final String countLabel;
  final String title;

  const _BooksListHeader({
    required this.count,
    required this.countLabel,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.paddingMd,
        vertical: AppSize.paddingSm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.paddingSm,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSize.radiusFull),
            ),
            child: Text(
              '$count $countLabel',
              style: AppTextStyle.labelMedium
                  .copyWith(color: AppColors.primary),
            ),
          ),
          Row(
            children: [
              Text(title, style: AppTextStyle.titleLarge),
              const SizedBox(width: AppSize.xs),
              const Icon(Icons.menu_book_rounded,
                  color: AppColors.primary, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
