import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../domain/entities/author.dart';

class AuthorListItem extends StatelessWidget {
  final Author author;
  final int index;
  final VoidCallback? onDelete;

  const AuthorListItem({
    super.key,
    required this.author,
    required this.index,
    this.onDelete,
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
          // Number
          SizedBox(
            width: 28,
            child: Text(
              '${index + 1}',
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: AppSize.sm),
          // Avatar: image or colored initial
          _buildAvatar(),
          const SizedBox(width: AppSize.md),
          // Author name
          Expanded(
            child: Text(
              author.name,
              style: AppTextStyle.bodyLarge,
            ),
          ),
          // Options menu
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
