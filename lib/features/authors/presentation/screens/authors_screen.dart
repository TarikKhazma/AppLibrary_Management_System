import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import '../widgets/add_author_form.dart';
import '../widgets/authors_list_view.dart';
import '../../../../core/widgets/gradient_app_bar.dart';
import '../../../../core/widgets/app_drawer/app_drawer.dart';
import '../../../../core/widgets/nav_bar/bottom_nav_bar.dart';

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
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.surface,
      drawer: const AppDrawer(),
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
