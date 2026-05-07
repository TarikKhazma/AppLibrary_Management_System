import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_size.dart';
import '../constants/app_text_style.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? leadingIcon;
  final double? height;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.leadingIcon,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: height ?? AppSize.buttonHeight,
        decoration: BoxDecoration(
          gradient: isLoading
              ? const LinearGradient(
                  colors: [Color(0xFFB39DDB), Color(0xFF9575CD)],
                )
              : AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppSize.radiusMd),
          boxShadow: isLoading
              ? []
              : [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            else ...[
              if (leadingIcon != null) ...[
                leadingIcon!,
                const SizedBox(width: AppSize.sm),
              ],
              Text(text, style: AppTextStyle.buttonText),
            ],
          ],
        ),
      ),
    );
  }
}
