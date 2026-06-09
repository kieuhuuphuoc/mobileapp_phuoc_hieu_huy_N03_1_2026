import 'package:flutter/material.dart';

import '../models/vocabulary.dart';
import '../utils/constants.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    super.key,
    required this.vocabulary,
    required this.onListen,
    required this.onEdit,
    required this.onDelete,
  });

  final Vocabulary vocabulary;
  final VoidCallback onListen;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vocabulary.word,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vocabulary.pronunciation,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.subtitleColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                spacing: 2,
                children: [
                  IconButton(
                    tooltip: 'Nghe',
                    icon: const Icon(Icons.volume_up_outlined),
                    color: AppColors.primary,
                    onPressed: onListen,
                  ),
                  IconButton(
                    tooltip: 'Sửa',
                    icon: const Icon(Icons.edit_outlined),
                    color: AppColors.accent,
                    onPressed: onEdit,
                  ),
                  IconButton(
                    tooltip: 'Xóa',
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red,
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            vocabulary.meaning,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            vocabulary.example.isEmpty
                ? 'Chưa có ví dụ'
                : vocabulary.example,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
