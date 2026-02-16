import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

/// A custom tab bar with three navigation tabs.
///
/// Displays 时间线 (Timeline), 回顾 (Retrospect), and 我 (Profile) tabs
/// with icons and labels. Uses [onTap] callback to report tab changes.
class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  /// Currently selected tab index (0-2).
  final int selectedIndex;

  /// Called when a tab is tapped, passing the tab index.
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.tabBarRadius),
          topRight: Radius.circular(AppRadius.tabBarRadius),
        ),
        border: Border(
          top: BorderSide(color: AppColors.borderPrimary, width: 1),
          left: BorderSide(color: AppColors.borderPrimary, width: 1),
          right: BorderSide(color: AppColors.borderPrimary, width: 1),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _TabItem(
                icon: Icons.view_timeline_rounded,
                label: '时间线',
                isSelected: selectedIndex == 0,
                onTap: () => onTap(0),
              ),
              _TabItem(
                icon: Icons.bar_chart_rounded,
                label: '回顾',
                isSelected: selectedIndex == 1,
                onTap: () => onTap(1),
              ),
              _TabItem(
                icon: Icons.person_rounded,
                label: '我',
                isSelected: selectedIndex == 2,
                onTap: () => onTap(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.accentPrimary : AppColors.textSecondary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
