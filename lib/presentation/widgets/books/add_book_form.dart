import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/constants/app_string.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../domain/entities/author.dart';
import '../../cubits/books/books_cubit.dart';
import '../../cubits/books/books_state.dart';
import '../common/app_text_field.dart';
import '../common/gradient_button.dart';

class AddBookForm extends StatefulWidget {
  final List<Author> authors;

  const AddBookForm({super.key, required this.authors});

  @override
  State<AddBookForm> createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  final _imageController = TextEditingController();
  Author? _selectedAuthor;

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
      context.read<BooksCubit>().addBook(
            title: _titleController.text.trim(),
            publishedYear: int.parse(_yearController.text.trim()),
            authorId: _selectedAuthor!.id,
            imageUrl: _imageController.text.trim().isEmpty
                ? null
                : _imageController.text.trim(),
          );
      _titleController.clear();
      _yearController.clear();
      _imageController.clear();
      setState(() => _selectedAuthor = null);
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
            // Header
            Row(
              children: [
                const Icon(Icons.menu_book_rounded,
                    color: AppColors.primary, size: AppSize.iconMd),
                const SizedBox(width: AppSize.sm),
                Text(loc.addNewBook, style: AppTextStyle.headlineSmall),
              ],
            ),
            const SizedBox(height: AppSize.md),
            // Title field
            AppTextField(
              controller: _titleController,
              hint: loc.enterBookTitle,
              svgIconPath: AppString.bookIcon,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? loc.fieldRequired : null,
            ),
            const SizedBox(height: AppSize.sm),
            // Year field
            AppTextField(
              controller: _yearController,
              hint: loc.enterPublishYear,
              svgIconPath: AppString.calendarIcon,
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return loc.fieldRequired;
                if (int.tryParse(v.trim()) == null) return loc.invalidYear;
                return null;
              },
            ),
            const SizedBox(height: AppSize.sm),
            // Author dropdown
            _buildAuthorDropdown(loc),
            const SizedBox(height: AppSize.sm),
            AppTextField(
              controller: _imageController,
              hint: loc.enterImageUrl,
              svgIconPath: AppString.addIcon,
            ),
            const SizedBox(height: AppSize.md),
            // Submit button
            BlocBuilder<BooksCubit, BooksState>(
              builder: (context, state) => GradientButton(
                text: loc.addBook,
                isLoading: state.isAdding,
                leadingIcon: const Icon(Icons.menu_book_rounded,
                    color: Colors.white, size: 18),
                onPressed: () => _submit(loc),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorDropdown(AppLocalizations loc) {
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
          value: _selectedAuthor,
          isExpanded: true,
          hint: Text(loc.selectAuthor, style: AppTextStyle.hintText),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.textHint),
          borderRadius: BorderRadius.circular(AppSize.radiusMd),
          items: widget.authors.map((author) {
            return DropdownMenuItem<Author>(
              value: author,
              child: Text(author.name, style: AppTextStyle.bodyMedium),
            );
          }).toList(),
          onChanged: (author) => setState(() => _selectedAuthor = author),
        ),
      ),
    );
  }
}
