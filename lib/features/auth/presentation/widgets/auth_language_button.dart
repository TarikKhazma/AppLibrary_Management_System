import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../locale/locale_cubit.dart';

class AuthLanguageButton extends StatelessWidget {
  const AuthLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: '',
      offset: const Offset(0, 44),
      icon: const Icon(
        Icons.language_rounded,
        color: AppColors.primary,
        size: 26,
      ),
      onSelected: (code) =>
          context.read<LocaleCubit>().setLanguage(context, code),
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'ar',
          child: Row(children: [
            Text('🇸🇦', style: TextStyle(fontSize: 20)),
            SizedBox(width: 8),
            Text('العربية'),
          ]),
        ),
        PopupMenuItem(
          value: 'en',
          child: Row(children: [
            Text('🇺🇸', style: TextStyle(fontSize: 20)),
            SizedBox(width: 8),
            Text('English'),
          ]),
        ),
        PopupMenuItem(
          value: 'ms',
          child: Row(children: [
            Text('🇲🇾', style: TextStyle(fontSize: 20)),
            SizedBox(width: 8),
            Text('Melayu'),
          ]),
        ),
      ],
    );
  }
}
