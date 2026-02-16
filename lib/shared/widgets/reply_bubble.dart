import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../data/models/reply.dart';

/// A bubble widget for displaying reply content with time offset.
class ReplyBubble extends StatelessWidget {
  final Reply reply;
  final bool isLeftAligned;

  const ReplyBubble({
    super.key,
    required this.reply,
    this.isLeftAligned = true,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isLeftAligned ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.bgSurface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppRadius.bubbleRadius),
            topRight: const Radius.circular(AppRadius.bubbleRadius),
            bottomLeft: isLeftAligned
                ? Radius.zero
                : const Radius.circular(AppRadius.bubbleRadius),
            bottomRight: isLeftAligned
                ? const Radius.circular(AppRadius.bubbleRadius)
                : Radius.zero,
          ),
          border: Border.all(
            color: AppColors.borderPrimary,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              reply.content,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              reply.timeOffset,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontFamily: 'JetBrains Mono',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
