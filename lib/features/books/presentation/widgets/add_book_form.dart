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
import '../cubits/books_cubit.dart';
import '../cubits/books_state.dart';
import 'author_dropdown.dart';

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
            Row(
              children: [
                const Icon(Icons.menu_book_rounded,
                    color: AppColors.primary, size: AppSize.iconMd),
                const SizedBox(width: AppSize.sm),
                Text(loc.addNewBook, style: AppTextStyle.headlineSmall),
              ],
            ),
            const SizedBox(height: AppSize.md),
            AppTextField(
              controller: _titleController,
              hint: loc.enterBookTitle,
              svgIconPath: AppString.bookIcon,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[؀-ۿa-zA-Z\s]'),
                ),
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

}
