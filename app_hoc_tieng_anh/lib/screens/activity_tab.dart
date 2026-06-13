import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class ActivityTab extends StatelessWidget {
  const ActivityTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lịch sử học tập',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildTabItem('Tất cả', true),
              const SizedBox(width: 24),
              _buildTabItem('Từ vựng', false),
              const SizedBox(width: 24),
              _buildTabItem('Quiz', false),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 3,
            width: 60,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.history_rounded,
                      size: 60,
                      color: AppColors.accent.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Bạn chưa có lịch sử học tập',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Hãy bắt đầu học từ vựng hoặc làm quiz ngay',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Bắt đầu học ngay'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, bool isActive) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? AppColors.textColor : AppColors.subtitleColor,
          ),
        ),
      ],
    );
  }
}