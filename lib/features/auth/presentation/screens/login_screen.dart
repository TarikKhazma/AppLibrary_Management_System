import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/navigation/app_router.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';
import '../widgets/auth_language_button.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_or_divider.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_auth_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _usernameError;
  String? _passwordError;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final loc = AppLocalizations.of(context);
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    setState(() {
      _usernameError = username.isEmpty ? loc.fieldRequired : null;
      _passwordError = password.isEmpty ? loc.fieldRequired : null;
    });

    if (_usernameError != null || _passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.fieldRequired),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.radiusMd),
          ),
        ),
      );
      return;
    }

    context.read<AuthCubit>().login(username, password);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          final loc = AppLocalizations.of(context);
          final messenger = ScaffoldMessenger.of(context);
          AppRouter.toMain(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            messenger.showSnackBar(
              SnackBar(
                content: Text(loc.loginSuccess),
                backgroundColor: AppColors.success,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.radiusMd),
                ),
              ),
            );
          });
        } else if (state.status == AuthStatus.error) {
          final loc = AppLocalizations.of(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? loc.loginFailed),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.radiusMd),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final loc = AppLocalizations.of(context);
        final isLoading = state.status == AuthStatus.loading;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.lg,
                    vertical: AppSize.lg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSize.xl),
                      const AuthLogo(),
                      const SizedBox(height: AppSize.xl),
                      Text(
                        loc.welcomeBack,
                        style: AppTextStyle.displaySmall.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSize.xl),
                      SocialAuthButton(
                        svgPath: AppImages.facebookIcon,
                        label: loc.continueWithFacebook,
                        backgroundColor: const Color(0xFF1877F2),
                        textColor: Colors.white,
                        onTap: () {},
                      ),
                      const SizedBox(height: AppSize.sm),
                      SocialAuthButton(
                        svgPath: AppImages.googleIcon,
                        label: loc.continueWithGoogle,
                        backgroundColor: Colors.white,
                        textColor: AppColors.textPrimary,
                        borderColor: AppColors.border,
                        onTap: () {},
                      ),
                      const SizedBox(height: AppSize.lg),
                      const AuthOrDivider(),
                      const SizedBox(height: AppSize.lg),
                      AuthTextField(
                        hint: 'stanleycohen@gmail.com',
                        controller: _usernameController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        errorText: _usernameError,
                        onChanged: (_) =>
                            setState(() => _usernameError = null),
                      ),
                      const SizedBox(height: AppSize.sm),
                      AuthTextField(
                        hint: loc.password,
                        controller: _passwordController,
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        errorText: _passwordError,
                        onChanged: (_) =>
                            setState(() => _passwordError = null),
                      ),
                      const SizedBox(height: AppSize.lg),
                      AuthSubmitButton(
                        label: loc.signIn,
                        isLoading: isLoading,
                        onTap: _login,
                      ),
                      const SizedBox(height: AppSize.md),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            loc.forgotPassword,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSize.xs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${loc.noAccount} ',
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => AppRouter.toSignup(context),
                            child: Text(
                              loc.signUp,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: AppSize.xs,
                      top: AppSize.xs,
                    ),
                    child: AuthLanguageButton(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
