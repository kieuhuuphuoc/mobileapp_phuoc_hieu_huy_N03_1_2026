import 'package:flutter/material.dart';

import '../models/vocabulary.dart';
import '../utils/constants.dart';

class WordCard extends StatelessWidget {
  const WordCard({super.key, required this.vocabulary});

  final Vocabulary vocabulary;

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
            children: [
              Expanded(
                child: Text(
                  vocabulary.word,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ),
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
            vocabulary.example,
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
