import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/di/injection.dart';
import '../../../core/localization/app_localizations.dart';
import '../../cubits/authors/authors_cubit.dart';
import '../../cubits/authors/authors_state.dart';
import '../../widgets/authors/add_author_form.dart';
import '../../widgets/authors/author_list_item.dart';
import '../../widgets/common/gradient_app_bar.dart';
import '../../widgets/nav_bar/bottom_nav_bar.dart';

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
      body: Column(
        children: [
          const AddAuthorForm(),
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
    return BlocConsumer<AuthorsCubit, AuthorsState>(
      listener: (context, state) {
        if (state.status == AuthorsStatus.error &&
            state.errorMessage != null) {
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

        if (state.authors.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.people_outline_rounded,
                    size: 64, color: AppColors.textHint),
                const SizedBox(height: AppSize.md),
                Text(loc.noAuthors,
                    style: AppTextStyle.bodyLarge
                        .copyWith(color: AppColors.textSecondary)),
              ],
            ),
          );
        }

        return Column(
          children: [
            // List header
            _ListHeader(
              title: loc.authorsList,
              count: state.authors.length,
              countLabel: loc.authors,
              icon: Icons.people_rounded,
            ),
            // Authors list
            Expanded(
              child: ListView.builder(
                itemCount: state.authors.length,
                itemBuilder: (context, index) {
                  final author = state.authors[index];
                  return AuthorListItem(
                    author: author,
                    index: index,
                    onDelete: () =>
                        context.read<AuthorsCubit>().loadAuthors(),
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

class _ListHeader extends StatelessWidget {
  final String title;
  final int count;
  final String countLabel;
  final IconData icon;

  const _ListHeader({
    required this.title,
    required this.count,
    required this.countLabel,
    required this.icon,
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
          // Count badge
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
          // Title with icon
          Row(
            children: [
              Text(title, style: AppTextStyle.titleLarge),
              const SizedBox(width: AppSize.xs),
              Icon(icon, color: AppColors.primary, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
