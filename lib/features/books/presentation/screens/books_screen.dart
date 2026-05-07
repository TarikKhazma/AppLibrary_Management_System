import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../authors/presentation/cubits/authors_cubit.dart';
import '../cubits/books_cubit.dart';
import '../widgets/add_book_form.dart';
import '../widgets/books_list_view.dart';
import '../../../../core/widgets/gradient_app_bar.dart';
import '../../../../shared/widgets/nav_bar/bottom_nav_bar.dart';
import '../../../authors/presentation/cubits/authors_state.dart';

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
          BlocBuilder<AuthorsCubit, AuthorsState>(
            builder: (context, authState) =>
                AddBookForm(authors: authState.authors),
          ),
          const Expanded(child: BooksListView()),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentItem: currentNavItem,
        onItemSelected: onNavItemSelected,
      ),
    );
  }
}
