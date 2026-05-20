import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../services/data_service.dart';
import '../utils/constants.dart';
import '../widgets/word_card.dart';
import 'quiz_screen.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key, required this.topic});

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    final words = DataService.getVocabulariesByTopic(topic.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(topic.name),
        backgroundColor: topic.color,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: topic.color.withAlpha(31),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(topic.icon, color: topic.color, size: 30),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${words.length} từ vựng',
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.subtitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              topic.description,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.subtitleColor,
              ),
            ),
            const SizedBox(height: 20),
            ...words.map((word) => WordCard(vocabulary: word)),
            const SizedBox(height: 8),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => QuizScreen(topic: topic)),
                ),
                icon: const Icon(Icons.quiz_outlined),
                label: const Text('Làm quiz chủ đề này'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: topic.color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
