import 'package:flutter/material.dart';
import '../services/study_service.dart';
import '../utils/constants.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Thống kê học tập'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.bar_chart,
                size: 80,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              const Text(
                'Tính năng đang phát triển',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sẽ sớm ra mắt trong phiên bản tiếp theo',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.subtitleColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}