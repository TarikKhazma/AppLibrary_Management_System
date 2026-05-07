import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../domain/entities/author.dart';
import '../cubits/authors_cubit.dart';
import '../cubits/authors_state.dart';

class EditAuthorDialog extends StatefulWidget {
  final Author author;

  const EditAuthorDialog({super.key, required this.author});

  @override
  State<EditAuthorDialog> createState() => _EditAuthorDialogState();
}

class _EditAuthorDialogState extends State<EditAuthorDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.author.name);
    _imageController =
        TextEditingController(text: widget.author.imageUrl ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _submit(AppLocalizations loc) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthorsCubit>().updateAuthor(
            widget.author.id,
            _nameController.text.trim(),
            imageUrl: _imageController.text.trim().isEmpty
                ? null
                : _imageController.text.trim(),
          );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.radiusLg),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.paddingLg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.edit_rounded,
                      color: AppColors.primary, size: AppSize.iconMd),
                  const SizedBox(width: AppSize.sm),
                  Text(loc.edit, style: AppTextStyle.headlineSmall),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded,
                        color: AppColors.textSecondary),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.md),
              AppTextField(
                controller: _nameController,
                hint: loc.enterAuthorName,
                svgIconPath: AppString.authorIcon,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[؀-ۿa-zA-Z\s]')),
                ],
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
                  text: loc.save,
                  isLoading: state.isAdding,
                  leadingIcon: const Icon(Icons.check_rounded,
                      color: Colors.white, size: 18),
                  onPressed: () => _submit(loc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
