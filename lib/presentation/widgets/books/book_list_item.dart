import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../domain/entities/book.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final int index;
  final VoidCallback? onDelete;

  const BookListItem({
    super.key,
    required this.book,
    required this.index,
    this.onDelete,
  });

  Color get _bookColor =>
      AppColors.avatarColors[index % AppColors.avatarColors.length];

  Widget _buildCover() {
    if (book.imageUrl != null && book.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.radiusSm),
        child: Image.network(
          book.imageUrl!,
          width: 44,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _buildColorBlock(),
        ),
      );
    }
    return _buildColorBlock();
  }

  Widget _buildColorBlock() => Container(
        width: 44,
        height: 60,
        decoration: BoxDecoration(
          color: _bookColor,
          borderRadius: BorderRadius.circular(AppSize.radiusSm),
        ),
        child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 22),
      );

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.paddingMd,
        vertical: AppSize.paddingMd,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Book cover: image or color block
          _buildCover(),
          const SizedBox(width: AppSize.md),
          // Book info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: AppTextStyle.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (book.publishedYear != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${loc.publishYear}: ${book.publishedYear}',
                    style: AppTextStyle.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSize.sm),
          // Author name + options
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (book.authorName != null)
                Text(
                  book.authorName!,
                  style: AppTextStyle.labelMedium
                      .copyWith(color: AppColors.primary),
                ),
              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.radiusMd),
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(Icons.delete_outline_rounded,
                            color: AppColors.error, size: 18),
                        const SizedBox(width: AppSize.sm),
                        Text(
                          loc.delete,
                          style: AppTextStyle.bodyMedium
                              .copyWith(color: AppColors.error),
                        ),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'delete') _confirmDelete(context, loc);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, AppLocalizations loc) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusLg),
        ),
        title: Text(loc.confirmDelete, style: AppTextStyle.titleLarge),
        content: Text(loc.confirmDeleteMsg, style: AppTextStyle.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(loc.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onDelete?.call();
            },
            child: Text(
              loc.delete,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
