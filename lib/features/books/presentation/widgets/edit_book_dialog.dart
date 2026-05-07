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
import '../../../authors/domain/entities/author.dart';
import '../../domain/entities/book.dart';
import '../cubits/books_cubit.dart';
import '../cubits/books_state.dart';
import 'author_dropdown.dart';

class EditBookDialog extends StatefulWidget {
  final Book book;
  final List<Author> authors;

  const EditBookDialog({super.key, required this.book, required this.authors});

  @override
  State<EditBookDialog> createState() => _EditBookDialogState();
}

class _EditBookDialogState extends State<EditBookDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _yearController;
  late final TextEditingController _imageController;
  Author? _selectedAuthor;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _yearController = TextEditingController(
        text: widget.book.publishedYear?.toString() ?? '');
    _imageController = TextEditingController(text: widget.book.imageUrl ?? '');
    _selectedAuthor = widget.authors.where((a) => a.id == widget.book.authorId).firstOrNull;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _submit(AppLocalizations loc) {
    if (_formKey.currentState!.validate()) {
      if (_selectedAuthor == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.fieldRequired),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      context.read<BooksCubit>().updateBook(
            id: widget.book.id,
            title: _titleController.text.trim(),
            publishedYear: int.parse(_yearController.text.trim()),
            authorId: _selectedAuthor!.id,
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
                controller: _titleController,
                hint: loc.enterBookTitle,
                svgIconPath: AppString.bookIcon,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[؀-ۿa-zA-Z\s]')),
                ],
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? loc.fieldRequired : null,
              ),
              const SizedBox(height: AppSize.sm),
              AppTextField(
                controller: _yearController,
                hint: loc.enterPublishYear,
                svgIconPath: AppString.calendarIcon,
                keyboardType: TextInputType.number,
                maxLength: 4,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return loc.fieldRequired;
                  final year = int.tryParse(v.trim());
                  if (year == null || year < 1000 || year > 2100) {
                    return loc.invalidYear;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSize.sm),
              AuthorDropdown(
                value: _selectedAuthor,
                authors: widget.authors,
                hint: loc.selectAuthor,
                onChanged: (author) => setState(() => _selectedAuthor = author),
              ),
              const SizedBox(height: AppSize.sm),
              AppTextField(
                controller: _imageController,
                hint: loc.enterImageUrl,
                svgIconPath: AppString.addIcon,
              ),
              const SizedBox(height: AppSize.md),
              BlocBuilder<BooksCubit, BooksState>(
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
