import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/gradient_app_bar.dart';
import '../../../../core/widgets/app_drawer/app_drawer.dart';
import '../../../../core/widgets/nav_bar/bottom_nav_bar.dart';
import '../../../books/presentation/cubits/books_cubit.dart';
import '../../../authors/presentation/cubits/authors_cubit.dart';
import '../cubits/trash_cubit.dart';
import '../cubits/trash_state.dart';

class TrashScreen extends StatefulWidget {
  final NavItem currentNavItem;
  final void Function(NavItem) onNavItemSelected;

  const TrashScreen({
    super.key,
    required this.currentNavItem,
    required this.onNavItemSelected,
  });

  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TrashCubit>().loadTrash();
  }

  @override
  void didUpdateWidget(covariant TrashScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentNavItem == NavItem.trash &&
        oldWidget.currentNavItem != NavItem.trash) {
      context.read<TrashCubit>().loadTrash();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        drawer: const AppDrawer(),
        appBar: GradientAppBar(
          title: loc.trash,
          bottom: TabBar(
            tabs: [
              Tab(text: loc.deletedBooks),
              Tab(text: loc.deletedAuthors),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            labelStyle: AppTextStyle.labelMedium,
          ),
        ),
        body: BlocConsumer<TrashCubit, TrashState>(
          listener: (context, state) {
            if (state.status == TrashStatus.error &&
                state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ));
            }
            if (state.successOperation != null) {
              final message = switch (state.successOperation) {
                'book_restored' => loc.bookRestoredSuccess,
                'author_restored' => loc.authorRestoredSuccess,
                'book_permanently_deleted' => loc.bookPermanentlyDeleted,
                'author_permanently_deleted' => loc.authorPermanentlyDeleted,
                _ => loc.success,
              };
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message),
                backgroundColor: AppColors.success,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ));
              // Refresh active lists after restore/delete
              context.read<BooksCubit>().loadBooks();
              context.read<AuthorsCubit>().loadAuthors();
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child:
                    CircularProgressIndicator(color: AppColors.primary),
              );
            }
            return TabBarView(
              children: [
                _DeletedBooksList(state: state),
                _DeletedAuthorsList(state: state),
              ],
            );
          },
        ),
        bottomNavigationBar: AppBottomNavBar(
          currentItem: widget.currentNavItem,
          onItemSelected: widget.onNavItemSelected,
        ),
      ),
    );
  }
}

class _DeletedBooksList extends StatelessWidget {
  final TrashState state;
  const _DeletedBooksList({required this.state});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    if (state.deletedBooks.isEmpty) {
      return _EmptyTrash(message: loc.emptyTrash);
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppSize.md),
      itemCount: state.deletedBooks.length,
      itemBuilder: (context, index) {
        final book = state.deletedBooks[index];
        final daysLeft = book.deletedAt != null
            ? 30 -
                DateTime.now()
                    .difference(book.deletedAt!)
                    .inDays
                    .clamp(0, 30)
            : 30;
        return _TrashItemCard(
          icon: Icons.menu_book_rounded,
          title: book.title,
          subtitle: [
            if (book.authorName != null) book.authorName!,
            if (book.publishedYear != null) book.publishedYear.toString(),
          ].join(' · '),
          daysLeft: daysLeft,
          daysLabel: loc.daysRemaining,
          onRestore: () =>
              context.read<TrashCubit>().restoreBook(book.id),
          onDeleteForever: () =>
              context.read<TrashCubit>().permanentlyDeleteBook(book.id),
          restoreLabel: loc.restore,
          deleteForeverLabel: loc.deleteForever,
        );
      },
    );
  }
}

class _DeletedAuthorsList extends StatelessWidget {
  final TrashState state;
  const _DeletedAuthorsList({required this.state});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    if (state.deletedAuthors.isEmpty) {
      return _EmptyTrash(message: loc.emptyTrash);
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppSize.md),
      itemCount: state.deletedAuthors.length,
      itemBuilder: (context, index) {
        final author = state.deletedAuthors[index];
        final daysLeft = author.deletedAt != null
            ? 30 -
                DateTime.now()
                    .difference(author.deletedAt!)
                    .inDays
                    .clamp(0, 30)
            : 30;
        return _TrashItemCard(
          icon: Icons.person_rounded,
          title: author.name,
          subtitle: null,
          daysLeft: daysLeft,
          daysLabel: loc.daysRemaining,
          onRestore: () =>
              context.read<TrashCubit>().restoreAuthor(author.id),
          onDeleteForever: () =>
              context.read<TrashCubit>().permanentlyDeleteAuthor(author.id),
          restoreLabel: loc.restore,
          deleteForeverLabel: loc.deleteForever,
        );
      },
    );
  }
}

class _TrashItemCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final int daysLeft;
  final String daysLabel;
  final VoidCallback onRestore;
  final VoidCallback onDeleteForever;
  final String restoreLabel;
  final String deleteForeverLabel;

  const _TrashItemCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.daysLeft,
    required this.daysLabel,
    required this.onRestore,
    required this.onDeleteForever,
    required this.restoreLabel,
    required this.deleteForeverLabel,
  });

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: AppSize.sm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusMd),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSize.md),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.error.withValues(alpha: 0.1),
                child: Icon(icon, color: AppColors.error, size: AppSize.iconMd),
              ),
              const SizedBox(width: AppSize.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyle.titleSmall),
                    if (subtitle != null && subtitle!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: AppTextStyle.bodySmall
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      '$daysLeft $daysLabel',
                      style: AppTextStyle.labelSmall.copyWith(
                        color: daysLeft <= 7
                            ? AppColors.error
                            : AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  _ActionButton(
                    label: restoreLabel,
                    color: AppColors.success,
                    onTap: onRestore,
                  ),
                  const SizedBox(height: AppSize.xs),
                  _ActionButton(
                    label: deleteForeverLabel,
                    color: AppColors.error,
                    onTap: onDeleteForever,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSize.sm, vertical: AppSize.xs),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSize.radiusSm),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Text(
            label,
            style: AppTextStyle.labelSmall.copyWith(color: color),
          ),
        ),
      );
}

class _EmptyTrash extends StatelessWidget {
  final String message;
  const _EmptyTrash({required this.message});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.delete_outline_rounded,
                size: 72, color: AppColors.textHint),
            const SizedBox(height: AppSize.md),
            Text(
              message,
              style: AppTextStyle.bodyLarge
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      );
}
