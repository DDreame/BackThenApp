import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_constants.dart';
import '../../data/models/feeling.dart';

class FeelingCard extends StatelessWidget {
  final Feeling feeling;
  final VoidCallback? onTap;

  const FeelingCard({
    super.key,
    required this.feeling,
    this.onTap,
  });

  String _formatDate(DateTime date) {
    final dateFormat = DateFormat('M月d日 E · HH:mm', 'zh_CN');
    return dateFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgSurface,
          borderRadius: BorderRadius.circular(AppRadius.cardRadius),
          border: Border.all(color: AppColors.borderPrimary),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(feeling.createdAt),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontFamily: 'JetBrains Mono',
                        color: AppColors.textSecondary,
                      ),
                ),
                if (feeling.replyCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentPrimary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${feeling.replyCount}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              feeling.content,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
