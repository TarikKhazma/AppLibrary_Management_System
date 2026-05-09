import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'drawer_about.dart';
import 'drawer_header.dart';
import 'drawer_language.dart';
import 'drawer_stats.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          const AppDrawerHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                DrawerStats(),
                Divider(height: 1, color: AppColors.divider),
                DrawerLanguage(),
                Divider(height: 1, color: AppColors.divider),
                DrawerAbout(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
