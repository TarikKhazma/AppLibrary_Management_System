import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../authors/presentation/cubits/authors_cubit.dart';
import '../../../authors/presentation/cubits/authors_state.dart';
import '../../../books/presentation/cubits/books_cubit.dart';
import '../../../books/presentation/cubits/books_state.dart';
import 'stat_card.dart';

class HomeStatsRow extends StatelessWidget {
  const HomeStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<BooksCubit, BooksState>(
            builder: (context, state) => StatCard(
              label: loc.totalBooks,
              count: state.books.length,
              icon: Icons.menu_book_rounded,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: AppSize.md),
        Expanded(
          child: BlocBuilder<AuthorsCubit, AuthorsState>(
            builder: (context, state) => StatCard(
              label: loc.totalAuthors,
              count: state.authors.length,
              icon: Icons.people_rounded,
              color: AppColors.primaryLight,
            ),
          ),
        ),
      ],
    );
  }
}
