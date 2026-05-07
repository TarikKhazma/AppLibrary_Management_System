import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_text_style.dart';

class AuthorsListHeader extends StatelessWidget {
  final String title;
  final int count;
  final String countLabel;

  const AuthorsListHeader({
    super.key,
    required this.title,
    required this.count,
    required this.countLabel,
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
              style: AppTextStyle.labelMedium.copyWith(color: AppColors.primary),
            ),
          ),
          Row(
            children: [
              Text(title, style: AppTextStyle.titleLarge),
              const SizedBox(width: AppSize.xs),
              const Icon(Icons.people_rounded,
                  color: AppColors.primary, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
