import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_text_style.dart';

class AuthTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final bool showMatchIndicator;
  final bool? isMatching;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const AuthTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.showMatchIndicator = false,
    this.isMatching,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onChanged,
    this.errorText,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: AppSize.inputHeight,
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(AppSize.radiusMd),
            border: hasError
                ? Border.all(color: AppColors.error, width: 1.5)
                : null,
          ),
          child: TextField(
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPassword && _obscureText,
            onChanged: widget.onChanged,
            style: AppTextStyle.bodyMedium,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyle.hintText,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSize.md,
                vertical: AppSize.sm,
              ),
              suffixIcon: _buildSuffix(),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: Text(
              widget.errorText!,
              style: AppTextStyle.labelSmall.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
      ],
    );
  }

  Widget? _buildSuffix() {
    if (widget.showMatchIndicator) {
      if (widget.isMatching == true) {
        return const Padding(
          padding: EdgeInsets.only(right: AppSize.sm),
          child: Icon(
            Icons.check_rounded,
            color: AppColors.success,
            size: AppSize.iconMd,
          ),
        );
      }
      return null;
    }
    if (widget.isPassword) {
      return IconButton(
        onPressed: () => setState(() => _obscureText = !_obscureText),
        icon: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.textHint,
          size: AppSize.iconMd,
        ),
      );
    }
    return null;
  }
}
