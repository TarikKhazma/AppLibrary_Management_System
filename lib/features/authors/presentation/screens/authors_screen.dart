import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/localization/app_localizations.dart';
import '../cubits/authors_cubit.dart';
import '../widgets/add_author_form.dart';
import '../widgets/authors_list_view.dart';
import '../../../../core/widgets/gradient_app_bar.dart';
import '../../../../shared/widgets/nav_bar/bottom_nav_bar.dart';

class AuthorsScreen extends StatelessWidget {
  final NavItem currentNavItem;
  final void Function(NavItem) onNavItemSelected;

  const AuthorsScreen({
    super.key,
    required this.currentNavItem,
    required this.onNavItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthorsCubit>()..loadAuthors(),
      child: _AuthorsBody(
        currentNavItem: currentNavItem,
        onNavItemSelected: onNavItemSelected,
      ),
    );
  }
}

class _AuthorsBody extends StatelessWidget {
  final NavItem currentNavItem;
  final void Function(NavItem) onNavItemSelected;

  const _AuthorsBody({
    required this.currentNavItem,
    required this.onNavItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: GradientAppBar(title: loc.authors),
      body: const Column(
        children: [
          AddAuthorForm(),
          Expanded(child: AuthorsListView()),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentItem: currentNavItem,
        onItemSelected: onNavItemSelected,
      ),
    );
  }
}
