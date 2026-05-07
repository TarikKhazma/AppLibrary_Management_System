import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../domain/entities/author.dart';

class AuthorListItem extends StatelessWidget {
  final Author author;
  final int index;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const AuthorListItem({
    super.key,
    required this.author,
    required this.index,
    this.onDelete,
    this.onEdit,
  });

  Color get _avatarColor =>
      AppColors.avatarColors[index % AppColors.avatarColors.length];

  String get _initial =>
      author.name.isNotEmpty ? author.name[0].toUpperCase() : '?';

  Widget _buildAvatar() {
    if (author.imageUrl != null && author.imageUrl!.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          author.imageUrl!,
          width: AppSize.avatarMd,
          height: AppSize.avatarMd,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _buildInitial(),
        ),
      );
    }
    return _buildInitial();
  }

  Widget _buildInitial() => Container(
        width: AppSize.avatarMd,
        height: AppSize.avatarMd,
        decoration: BoxDecoration(color: _avatarColor, shape: BoxShape.circle),
        child: Center(
          child: Text(_initial,
              style: AppTextStyle.titleMedium.copyWith(color: Colors.white)),
        ),
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
          SizedBox(
            width: 28,
            child: Text(
              '${index + 1}',
              style: AppTextStyle.bodySmall
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: AppSize.sm),
          _buildAvatar(),
          const SizedBox(width: AppSize.md),
          Expanded(
            child: Text(author.name, style: AppTextStyle.bodyLarge),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded,
                color: AppColors.textSecondary, size: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.radiusMd),
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    const Icon(Icons.edit_rounded,
                        color: AppColors.primary, size: 18),
                    const SizedBox(width: AppSize.sm),
                    Text(loc.edit,
                        style: AppTextStyle.bodyMedium
                            .copyWith(color: AppColors.primary)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    const Icon(Icons.delete_outline_rounded,
                        color: AppColors.error, size: 18),
                    const SizedBox(width: AppSize.sm),
                    Text(loc.delete,
                        style: AppTextStyle.bodyMedium
                            .copyWith(color: AppColors.error)),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'delete') onDelete?.call();
              if (value == 'edit') onEdit?.call();
            },
          ),
        ],
      ),
    );
  }
}
