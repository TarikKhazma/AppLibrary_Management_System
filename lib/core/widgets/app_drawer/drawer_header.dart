import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../localization/app_localizations.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
          AppSize.md, topPadding + AppSize.md, AppSize.md, AppSize.lg),
      decoration: const BoxDecoration(gradient: AppColors.appBarGradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSize.radiusMd),
            ),
            child: const Icon(Icons.local_library_rounded,
                color: Colors.white, size: 32),
          ),
          const SizedBox(height: AppSize.md),
          Text(
            loc.appTitle,
            style: AppTextStyle.headlineSmall.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            'v1.0.0',
            style: AppTextStyle.bodySmall.copyWith(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
