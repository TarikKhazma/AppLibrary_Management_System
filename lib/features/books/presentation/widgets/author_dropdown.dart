import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../authors/domain/entities/author.dart';

class AuthorDropdown extends StatelessWidget {
  final Author? value;
  final List<Author> authors;
  final String hint;
  final void Function(Author?) onChanged;

  const AuthorDropdown({
    super.key,
    required this.value,
    required this.authors,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.paddingMd,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(AppSize.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Author>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: AppTextStyle.hintText),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.textHint),
          borderRadius: BorderRadius.circular(AppSize.radiusMd),
          items: authors.map((author) {
            return DropdownMenuItem<Author>(
              value: author,
              child: Text(author.name, style: AppTextStyle.bodyMedium),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
