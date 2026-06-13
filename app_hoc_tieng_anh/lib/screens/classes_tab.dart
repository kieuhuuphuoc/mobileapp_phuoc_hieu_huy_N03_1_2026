import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class ClassesTab extends StatelessWidget {
  const ClassesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Khóa học của tôi',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Đăng ký khóa học mới'),
            ),
          ),
          const SizedBox(height: 16),
          
          // Danh sách khóa học
          _buildCourseCard(
            name: 'Tiếng Anh cơ bản',
            description: 'Dành cho người mới bắt đầu',
            level: 'Beginner',
            progress: 0.8,
            color: Colors.blue.shade100,
            icon: Icons.abc,
          ),
          const SizedBox(height: 12),
          _buildCourseCard(
            name: 'Tiếng Anh giao tiếp',
            description: 'Luyện nói và phản xạ',
            level: 'Intermediate',
            progress: 0.4,
            color: Colors.green.shade100,
            icon: Icons.translate,
          ),
          const SizedBox(height: 12),
          _buildCourseCard(
            name: 'Từ vựng chuyên sâu',
            description: 'Mở rộng vốn từ vựng theo chủ đề',
            level: 'Advanced',
            progress: 0.1,
            color: Colors.purple.shade100,
            icon: Icons.book,
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard({
    required String name,
    required String description,
    required String level,
    required double progress,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: level == 'Beginner'
                      ? Colors.green.shade100
                      : level == 'Intermediate'
                          ? Colors.orange.shade100
                          : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  level,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: level == 'Beginner'
                        ? Colors.green.shade700
                        : level == 'Intermediate'
                            ? Colors.orange.shade700
                            : Colors.red.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              color: AppColors.primary,
              backgroundColor: Colors.grey.shade200,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${(progress * 100).toInt()}% hoàn thành',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}