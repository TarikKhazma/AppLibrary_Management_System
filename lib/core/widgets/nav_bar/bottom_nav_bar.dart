import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../localization/app_localizations.dart';

enum NavItem { home, books, authors, search, trash }

class AppBottomNavBar extends StatelessWidget {
  final NavItem currentItem;
  final void Function(NavItem) onItemSelected;

  const AppBottomNavBar({
    super.key,
    required this.currentItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSize.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBarItem(
                icon: Icons.home_rounded,
                label: loc.home,
                isSelected: currentItem == NavItem.home,
                onTap: () => onItemSelected(NavItem.home),
              ),
              _NavBarItem(
                icon: Icons.menu_book_rounded,
                label: loc.books,
                isSelected: currentItem == NavItem.books,
                onTap: () => onItemSelected(NavItem.books),
              ),
              _NavBarItem(
                icon: Icons.people_rounded,
                label: loc.authors,
                isSelected: currentItem == NavItem.authors,
                onTap: () => onItemSelected(NavItem.authors),
              ),
              _NavBarItem(
                icon: Icons.search_rounded,
                label: loc.search,
                isSelected: currentItem == NavItem.search,
                onTap: () => onItemSelected(NavItem.search),
              ),
              _NavBarItem(
                icon: Icons.delete_outline_rounded,
                label: loc.trash,
                isSelected: currentItem == NavItem.trash,
                onTap: () => onItemSelected(NavItem.trash),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        isSelected ? AppColors.primary : AppColors.textSecondary;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSize.radiusMd),
              ),
              child: Icon(icon, color: color, size: AppSize.iconMd),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyle.labelSmall.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
