import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color background = Color(0xFFF0F4F8);
  static const Color cardBackground = Colors.white;
  static const Color accent = Color(0xFFFF9800);

  static const Color textColor = Color(0xFF222222);
  static const Color subtitleColor = Color(0xFF666666);
}

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 24,
    color: AppColors.subtitleColor,
  );

  static const TextStyle label = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );
}
