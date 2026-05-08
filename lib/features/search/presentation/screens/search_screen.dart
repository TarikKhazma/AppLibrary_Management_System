import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/gradient_app_bar.dart';
import '../../../../shared/widgets/app_drawer/app_drawer.dart';
import '../../../../shared/widgets/nav_bar/bottom_nav_bar.dart';
import '../../../authors/domain/entities/author.dart';
import '../../../authors/presentation/cubits/authors_cubit.dart';
import '../../../authors/presentation/cubits/authors_state.dart';
import '../../../books/domain/entities/book.dart';
import '../../../books/presentation/cubits/books_cubit.dart';
import '../../../books/presentation/cubits/books_state.dart';

class SearchScreen extends StatefulWidget {
  final NavItem currentNavItem;
  final void Function(NavItem) onNavItemSelected;

  const SearchScreen({
    super.key,
    required this.currentNavItem,
    required this.onNavItemSelected,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.surface,
      drawer: const AppDrawer(),
      appBar: GradientAppBar(title: loc.search),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSize.md),
            child: TextField(
              controller: _controller,
              onChanged: (v) =>
                  setState(() => _query = v.trim().toLowerCase()),
              decoration: InputDecoration(
                hintText: loc.searchHint,
                prefixIcon:
                    const Icon(Icons.search_rounded, color: AppColors.primary),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.radiusLg),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.radiusLg),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.radiusLg),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
            ),
          ),
          Expanded(
            child: _query.isEmpty
                ? _SearchEmpty(hint: loc.searchHint)
                : _SearchResults(query: _query),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentItem: widget.currentNavItem,
        onItemSelected: widget.onNavItemSelected,
      ),
    );
  }
}

class _SearchEmpty extends StatelessWidget {
  final String hint;
  const _SearchEmpty({required this.hint});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_rounded,
                size: 72, color: AppColors.textHint),
            const SizedBox(height: AppSize.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.xl),
              child: Text(
                hint,
                style: AppTextStyle.bodyLarge
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
}

class _SearchResults extends StatelessWidget {
  final String query;
  const _SearchResults({required this.query});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, booksState) {
        return BlocBuilder<AuthorsCubit, AuthorsState>(
          builder: (context, authorsState) {
            final books = booksState.books
                .where((b) =>
                    b.title.toLowerCase().contains(query) ||
                    (b.authorName?.toLowerCase().contains(query) ?? false))
                .toList();
            final authors = authorsState.authors
                .where((a) => a.name.toLowerCase().contains(query))
                .toList();

            if (books.isEmpty && authors.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.search_off_rounded,
                        size: 64, color: AppColors.textHint),
                    const SizedBox(height: AppSize.md),
                    Text(
                      loc.noResults,
                      style: AppTextStyle.bodyLarge
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.md),
              children: [
                if (books.isNotEmpty) ...[
                  _SectionHeader(
                    icon: Icons.menu_book_rounded,
                    title: '${loc.books} (${books.length})',
                  ),
                  ...books.map((b) => _BookResultCard(book: b)),
                ],
                if (authors.isNotEmpty) ...[
                  _SectionHeader(
                    icon: Icons.people_rounded,
                    title: '${loc.authors} (${authors.length})',
                  ),
                  ...authors.map((a) => _AuthorResultCard(author: a)),
                ],
                const SizedBox(height: AppSize.md),
              ],
            );
          },
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: AppSize.md, bottom: AppSize.sm),
        child: Row(
          children: [
            Icon(icon, size: AppSize.iconMd, color: AppColors.primary),
            const SizedBox(width: AppSize.sm),
            Text(title,
                style: AppTextStyle.titleMedium
                    .copyWith(color: AppColors.primary)),
          ],
        ),
      );
}

class _BookResultCard extends StatelessWidget {
  final Book book;
  const _BookResultCard({required this.book});

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: AppSize.sm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusMd),
        ),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: AppColors.primaryLight,
            child: Icon(Icons.menu_book_rounded, color: AppColors.primary),
          ),
          title: Text(book.title, style: AppTextStyle.titleSmall),
          subtitle: Text(
            [
              if (book.authorName != null) book.authorName!,
              if (book.publishedYear != null) book.publishedYear.toString(),
            ].join(' · '),
            style:
                AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
        ),
      );
}

class _AuthorResultCard extends StatelessWidget {
  final Author author;
  const _AuthorResultCard({required this.author});

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: AppSize.sm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusMd),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primaryLight,
            backgroundImage: author.imageUrl != null
                ? NetworkImage(author.imageUrl!)
                : null,
            child: author.imageUrl == null
                ? const Icon(Icons.person_rounded, color: AppColors.primary)
                : null,
          ),
          title: Text(author.name, style: AppTextStyle.titleSmall),
        ),
      );
}
