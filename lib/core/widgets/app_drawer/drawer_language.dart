import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../../features/locale/locale_cubit.dart';

class DrawerLanguage extends StatelessWidget {
  const DrawerLanguage({super.key});

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
              'Language / اللغة',
              style: AppTextStyle.labelMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
          ),
        ),
        const DrawerLangTile(flag: '🇸🇦', label: 'العربية', code: 'ar'),
        const DrawerLangTile(flag: '🇺🇸', label: 'English', code: 'en'),
        const DrawerLangTile(flag: '🇲🇾', label: 'Melayu', code: 'ms'),
        const SizedBox(height: AppSize.sm),
      ],
    );
  }
}

class DrawerLangTile extends StatelessWidget {
  final String flag;
  final String label;
  final String code;

  const DrawerLangTile({
    super.key,
    required this.flag,
    required this.label,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = Localizations.localeOf(context).languageCode == code;
    return ListTile(
      dense: true,
      leading: Text(flag, style: const TextStyle(fontSize: 22)),
      title: Text(
        label,
        style: AppTextStyle.bodyMedium.copyWith(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_rounded,
              color: AppColors.primary, size: AppSize.iconSm)
          : null,
      onTap: () {
        context.read<LocaleCubit>().setLanguage(context, code);
        Navigator.of(context).pop();
      },
    );
  }
}
