import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/constants/app_string.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/localization/app_localizations.dart';
import '../../cubits/authors/authors_cubit.dart';
import '../../cubits/authors/authors_state.dart';
import '../common/app_text_field.dart';
import '../common/gradient_button.dart';

class AddAuthorForm extends StatefulWidget {
  const AddAuthorForm({super.key});

  @override
  State<AddAuthorForm> createState() => _AddAuthorFormState();
}

class _AddAuthorFormState extends State<AddAuthorForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthorsCubit>().addAuthor(
            _nameController.text.trim(),
            imageUrl: _imageController.text.trim().isEmpty
                ? null
                : _imageController.text.trim(),
          );
      _nameController.clear();
      _imageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.all(AppSize.paddingMd),
      padding: const EdgeInsets.all(AppSize.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSize.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person_add_rounded,
                    color: AppColors.primary, size: AppSize.iconMd),
                const SizedBox(width: AppSize.sm),
                Text(loc.addNewAuthor, style: AppTextStyle.headlineSmall),
              ],
            ),
            const SizedBox(height: AppSize.md),
            AppTextField(
              controller: _nameController,
              hint: loc.enterAuthorName,
              svgIconPath: AppString.authorIcon,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? loc.fieldRequired : null,
            ),
            const SizedBox(height: AppSize.sm),
            AppTextField(
              controller: _imageController,
              hint: loc.enterImageUrl,
              svgIconPath: AppString.addIcon,
            ),
            const SizedBox(height: AppSize.md),
            BlocBuilder<AuthorsCubit, AuthorsState>(
              builder: (context, state) => GradientButton(
                text: loc.addAuthor,
                isLoading: state.isAdding,
                leadingIcon: const Icon(Icons.add, color: Colors.white, size: 20),
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
