import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';

class DrawerAbout extends StatelessWidget {
  const DrawerAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSize.md, AppSize.md, AppSize.md, AppSize.xs),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'About / عن التطبيق',
              style: AppTextStyle.labelMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
          ),
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.info_outline_rounded,
              color: AppColors.primary, size: AppSize.iconMd),
          title: Text('Library Management System',
              style: AppTextStyle.bodyMedium),
          subtitle: Text(
            'Built with Flutter & Supabase',
            style: AppTextStyle.bodySmall.copyWith(color: AppColors.textHint),
          ),
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.code_rounded,
              color: AppColors.primary, size: AppSize.iconMd),
          title: Text('Version 1.0.0', style: AppTextStyle.bodyMedium),
        ),
      ],
    );
  }
}
