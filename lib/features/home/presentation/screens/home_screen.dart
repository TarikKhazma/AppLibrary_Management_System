import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../authors/presentation/cubits/authors_cubit.dart';
import '../../../books/presentation/cubits/books_cubit.dart';
import '../widgets/home_stats_row.dart';
import '../widgets/welcome_banner.dart';
import '../../../../core/widgets/gradient_app_bar.dart';
import '../../../../shared/widgets/nav_bar/bottom_nav_bar.dart';

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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSize.md),
            WelcomeBanner(),
            SizedBox(height: AppSize.lg),
            HomeStatsRow(),
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
