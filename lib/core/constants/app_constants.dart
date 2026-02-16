import 'package:flutter/material.dart';

/// App color palette
class AppColors {
  AppColors._();

  // Primary accent colors
  static const Color accentPrimary = Color(0xFF0D6E6E);
  static const Color accentSecondary = Color(0xFFE07B54);

  // Background colors
  static const Color bgPrimary = Color(0xFFFAFAFA);
  static const Color bgSurface = Color(0xFFFFFFFF);
  static const Color bgMuted = Color(0xFFF8F8F8);

  // Text colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color(0xFF888888);

  // Border and utility colors
  static const Color borderPrimary = Color(0xFFE5E5E5);
  static const Color positive = Color(0xFF3D6B4F);
}

/// App corner radius values
class AppRadius {
  AppRadius._();

  static const double cardRadius = 12.0;
  static const double bubbleRadius = 12.0;
  static const double inputRadius = 12.0;
  static const double tabBarRadius = 32.0;
}

/// App content limits
class AppLimits {
  AppLimits._();

  static const int maxFeelingLength = 1000;
  static const int maxReplyLength = 500;
}
