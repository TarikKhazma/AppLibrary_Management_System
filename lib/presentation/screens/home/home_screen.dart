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
import '../../widgets/common/gradient_app_bar.dart';
import '../../widgets/nav_bar/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  final NavItem currentNavItem;
  final void Function(NavItem) onNavItemSelected;

  const HomeScreen({
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
      child: _HomeBody(
        currentNavItem: currentNavItem,
        onNavItemSelected: onNavItemSelected,
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  final NavItem currentNavItem;
  final void Function(NavItem) onNavItemSelected;

  const _HomeBody({
    required this.currentNavItem,
    required this.onNavItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: GradientAppBar(title: loc.appTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.md),
            // Welcome banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSize.paddingLg),
              decoration: BoxDecoration(
                gradient: AppColors.appBarGradient,
                borderRadius: BorderRadius.circular(AppSize.radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.local_library_rounded,
                      color: Colors.white, size: 40),
                  const SizedBox(height: AppSize.md),
                  Text(
                    loc.welcome,
                    style: AppTextStyle.titleLarge
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.lg),
            // Stats row
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<BooksCubit, BooksState>(
                    builder: (context, state) => _StatCard(
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
                    builder: (context, state) => _StatCard(
                      label: loc.totalAuthors,
                      count: state.authors.length,
                      icon: Icons.people_rounded,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentItem: currentNavItem,
        onItemSelected: onNavItemSelected,
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSize.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSize.radiusMd),
            ),
            child: Icon(icon, color: color, size: AppSize.iconMd),
          ),
          const SizedBox(height: AppSize.md),
          Text(
            '$count',
            style: AppTextStyle.headlineLarge.copyWith(color: color),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyle.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
