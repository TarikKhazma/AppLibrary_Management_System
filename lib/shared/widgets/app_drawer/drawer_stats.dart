import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../features/authors/presentation/cubits/authors_cubit.dart';
import '../../../features/authors/presentation/cubits/authors_state.dart';
import '../../../features/books/presentation/cubits/books_cubit.dart';
import '../../../features/books/presentation/cubits/books_state.dart';

class DrawerStats extends StatelessWidget {
  const DrawerStats({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, booksState) {
        return BlocBuilder<AuthorsCubit, AuthorsState>(
          builder: (context, authorsState) {
            return Padding(
              padding: const EdgeInsets.all(AppSize.md),
              child: Row(
                children: [
                  Expanded(
                    child: DrawerStatChip(
                      icon: Icons.menu_book_rounded,
                      count: booksState.books.length,
                      label: loc.books,
                    ),
                  ),
                  const SizedBox(width: AppSize.sm),
                  Expanded(
                    child: DrawerStatChip(
                      icon: Icons.people_rounded,
                      count: authorsState.authors.length,
                      label: loc.authors,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class DrawerStatChip extends StatelessWidget {
  final IconData icon;
  final int count;
  final String label;

  const DrawerStatChip({
    super.key,
    required this.icon,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
            vertical: AppSize.sm, horizontal: AppSize.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSize.radiusMd),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: AppSize.iconMd),
            const SizedBox(width: AppSize.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count.toString(),
                  style: AppTextStyle.titleLarge
                      .copyWith(color: AppColors.primary),
                ),
                Text(
                  label,
                  style: AppTextStyle.labelSmall
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ],
        ),
      );
}
