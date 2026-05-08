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

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _agreeToPolicy = false;
  bool? _passwordsMatch;
  String? _usernameError;
  String? _passwordError;
  String? _confirmError;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkMatch);
    _confirmController.addListener(_checkMatch);
  }

  void _checkMatch() {
    if (_confirmController.text.isEmpty) {
      setState(() => _passwordsMatch = null);
      return;
    }
    setState(() {
      _passwordsMatch = _confirmController.text == _passwordController.text;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusMd),
        ),
      ),
    );
  }

  void _signup() {
    final loc = AppLocalizations.of(context);
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    setState(() {
      _usernameError = username.isEmpty ? loc.fieldRequired : null;
      _passwordError = password.isEmpty
          ? loc.fieldRequired
          : (password.length < 6 ? loc.passwordTooShort : null);
      _confirmError = _confirmController.text.isEmpty
          ? loc.fieldRequired
          : (!(_passwordsMatch ?? false) ? loc.passwordsNotMatch : null);
    });

    if (_usernameError != null || _passwordError != null || _confirmError != null) {
      _showSnackBar(_usernameError ?? _passwordError ?? _confirmError!);
      return;
    }

    if (!_agreeToPolicy) {
      _showSnackBar(loc.mustAgreeToPolicy);
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
                content: Text(loc.signupSuccess),
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
              content: Text(state.errorMessage ?? loc.signupFailed),
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
                        loc.createAccount,
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
                        textInputAction: TextInputAction.next,
                        errorText: _passwordError,
                        onChanged: (_) =>
                            setState(() => _passwordError = null),
                      ),
                      const SizedBox(height: AppSize.sm),
                      AuthTextField(
                        hint: loc.confirmPassword,
                        controller: _confirmController,
                        isPassword: true,
                        showMatchIndicator: true,
                        isMatching: _passwordsMatch,
                        textInputAction: TextInputAction.done,
                        errorText: _confirmError,
                        onChanged: (_) =>
                            setState(() => _confirmError = null),
                      ),
                      const SizedBox(height: AppSize.md),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _agreeToPolicy,
                              onChanged: (v) =>
                                  setState(() => _agreeToPolicy = v ?? false),
                              activeColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSize.sm),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${loc.privacyPolicyPrefix} ',
                                    style: AppTextStyle.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  TextSpan(
                                    text: loc.privacyPolicy,
                                    style: AppTextStyle.bodySmall.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.lg),
                      AuthSubmitButton(
                        label: loc.getStarted,
                        isLoading: isLoading,
                        onTap: _signup,
                      ),
                      const SizedBox(height: AppSize.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${loc.haveAccount} ',
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => AppRouter.pop(context),
                            child: Text(
                              loc.signIn,
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
