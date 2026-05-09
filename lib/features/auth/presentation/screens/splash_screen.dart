import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/navigation/app_router.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        context.read<AuthCubit>().checkAuth(),
        Future.delayed(const Duration(seconds: 2)),
      ]);
      if (!mounted) return;
      final status = context.read<AuthCubit>().state.status;
      if (status == AuthStatus.authenticated) {
        AppRouter.toMain(context);
      } else {
        AppRouter.toLogin(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSize.radiusMd * 1.5),
                ),
                child: const Icon(
                  Icons.local_library_rounded,
                  color: Colors.white,
                  size: 44,
                ),
              ),
              const SizedBox(height: AppSize.lg),
              Text(
                loc.libraryHub,
                style: AppTextStyle.displaySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 64),
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
