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
  final PreferredSizeWidget? bottom;

  const GradientAppBar({
    super.key,
    required this.title,
    this.onMenuPressed,
    this.onAddPressed,
    this.actions,
    this.bottom,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

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
          leading: Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.menu_rounded, color: Colors.white),
              onPressed: onMenuPressed ?? () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
          title: Text(title, style: AppTextStyle.appBarTitle),
          centerTitle: true,
          bottom: bottom,
          actions: [
            PopupMenuButton<String>(
              tooltip: '',
              offset: const Offset(0, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.radiusMd),
              ),
              icon: const Icon(
                Icons.language_rounded,
                color: Colors.white,
                size: 26,
              ),
              onSelected: (code) =>
                  context.read<LocaleCubit>().setLanguage(context, code),
              itemBuilder: (_) => const [
                PopupMenuItem(
                  value: 'ar',
                  child: Row(children: [
                    Text('🇸🇦', style: TextStyle(fontSize: 22)),
                    SizedBox(width: 10),
                    Text('العربية'),
                  ]),
                ),
                PopupMenuItem(
                  value: 'en',
                  child: Row(children: [
                    Text('🇺🇸', style: TextStyle(fontSize: 22)),
                    SizedBox(width: 10),
                    Text('English'),
                  ]),
                ),
                PopupMenuItem(
                  value: 'ms',
                  child: Row(children: [
                    Text('🇲🇾', style: TextStyle(fontSize: 22)),
                    SizedBox(width: 10),
                    Text('Melayu'),
                  ]),
                ),
              ],
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
