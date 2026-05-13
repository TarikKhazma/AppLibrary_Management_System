import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/localization/app_localizations.dart';
import '../cubits/authors_cubit.dart';
import '../cubits/authors_state.dart';
import 'author_list_item.dart';
import 'authors_list_header.dart';
import 'edit_author_dialog.dart';

class AuthorsListView extends StatelessWidget {
  const AuthorsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BlocConsumer<AuthorsCubit, AuthorsState>(
      listenWhen: (prev, curr) =>
          curr.status == AuthorsStatus.success ||
          curr.status == AuthorsStatus.error,
      listener: (context, state) {
        if (state.status == AuthorsStatus.error &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.error,
            ),
          );
        }
        if (state.successOperation != null) {
          final loc = AppLocalizations.of(context);
          final message = switch (state.successOperation) {
            'added' => loc.authorAddedSuccess,
            'deleted' => loc.authorDeletedSuccess,
            'updated' => loc.authorUpdatedSuccess,
            _ => loc.success,
          };
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state.authors.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.people_outline_rounded,
                    size: 64, color: AppColors.textHint),
                const SizedBox(height: AppSize.md),
                Text(
                  loc.noAuthors,
                  style: AppTextStyle.bodyLarge
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            AuthorsListHeader(
              title: loc.authorsList,
              count: state.authors.length,
              countLabel: loc.authors,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.authors.length,
                itemBuilder: (context, index) {
                  final author = state.authors[index];
                  return AuthorListItem(
                    author: author,
                    index: index,
                    onDelete: () =>
                        context.read<AuthorsCubit>().deleteAuthor(author.id),
                    onEdit: () => showDialog<void>(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: context.read<AuthorsCubit>(),
                        child: EditAuthorDialog(author: author),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
