import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryDark = Color(0xFF4338CA);

  static const Color accent = Color(0xFFF59E0B);

  static const Color success = Color(0xFF22C55E);

  static const Color danger = Color(0xFFEF4444);

  static const Color background = Color(0xFFF1F5F9);
  
  static const Color cardBackground = Colors.white;

  static const Color textColor = Color(0xFF0F172A);

  static const Color subtitleColor = Color(0xFF64748B);

  static const Color border = Color(0xFFE2E8F0);
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
