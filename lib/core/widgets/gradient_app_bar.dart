import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/app_colors.dart';
import '../constants/app_size.dart';
import '../constants/app_text_style.dart';
import '../../shared/cubits/locale/locale_cubit.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onAddPressed;
  final List<Widget>? actions;

  const GradientAppBar({
    super.key,
    required this.title,
    this.onMenuPressed,
    this.onAddPressed,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.appBarGradient,
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          leading: IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
            onPressed: onMenuPressed ?? () {},
          ),
          title: Text(title, style: AppTextStyle.appBarTitle),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () => context.read<LocaleCubit>().cycleLanguage(context),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 4,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSize.radiusFull),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  context.locale.languageCode.toUpperCase(),
                  style: AppTextStyle.labelMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            if (actions != null) ...actions!,
            if (onAddPressed != null)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: onAddPressed,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
