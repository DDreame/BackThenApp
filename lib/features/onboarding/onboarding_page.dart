import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
import '../../data/models/feeling.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static const String _onboardingKey = 'onboarding_completed';

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
    if (context.mounted) {
      context.go('/timeline');
    }
  }

  void _skipOnboarding(BuildContext context) {
    context.go('/timeline');
  }

  @override
  Widget build(BuildContext context) {
    // Static example feeling for illustration
    final exampleFeeling = Feeling(
      id: 'example-1',
      content: '今天阳光很好一个人在公园散步感觉特别放松和平静',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      replyCount: 2,
    );

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              // Title
              Text(
                '记录你的心情',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 12),
              // Subtitle
              Text(
                '在这里，你可以记录当下的感受，\n并用未来的视角回顾它们。',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
              ),
              const SizedBox(height: 40),
              // Example Card Label
              Text(
                '示例',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textTertiary,
                    ),
              ),
              const SizedBox(height: 12),
              // Example Feeling Card
              _ExampleFeelingCard(feeling: exampleFeeling),
              const Spacer(),
              // Bottom Buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => _skipOnboarding(context),
                      child: const Text('跳过'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () => _completeOnboarding(context),
                      child: const Text('完成'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// Static example card for onboarding illustration
class _ExampleFeelingCard extends StatelessWidget {
  final Feeling feeling;

  const _ExampleFeelingCard({required this.feeling});

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return '今天';
    } else if (difference.inDays == 1) {
      return '昨天';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks周前';
    } else {
      final months = (difference.inDays / 30).floor();
      return '$months个月前';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
