import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_text_style.dart';

class SocialAuthButton extends StatelessWidget {
  final String svgPath;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? svgColor;
  final VoidCallback? onTap;

  const SocialAuthButton({
    super.key,
    required this.svgPath,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.svgColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.buttonHeight,
      child: Material(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(AppSize.radiusFull),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSize.radiusFull),
          child: Container(
            decoration: BoxDecoration(
              border: borderColor != null
                  ? Border.all(color: borderColor!)
                  : null,
              borderRadius: BorderRadius.circular(AppSize.radiusFull),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  svgPath,
                  width: 24,
                  height: 24,
                  colorFilter: svgColor != null
                      ? ColorFilter.mode(svgColor!, BlendMode.srcIn)
                      : null,
                ),
                const SizedBox(width: AppSize.sm),
                Text(
                  label,
                  style: AppTextStyle.buttonText.copyWith(
                    color: textColor ?? Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
