import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../services/data_service.dart';
import '../utils/constants.dart';

enum TopicSelectMode { lesson, quiz }

class TopicSelectScreen extends StatelessWidget {
  const TopicSelectScreen({
    super.key,
    required this.mode,
    required this.onTopicSelected,
  });

  final TopicSelectMode mode;
  final ValueChanged<Topic> onTopicSelected;

  @override
  Widget build(BuildContext context) {
    final topics = DataService.topics;
    final title = mode == TopicSelectMode.lesson
        ? 'Chọn chủ đề bài học'
        : 'Chọn chủ đề quiz';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Hãy chọn một chủ đề trước khi bắt đầu.',
              style: TextStyle(fontSize: 16, color: AppColors.subtitleColor),
            ),
            const SizedBox(height: 16),
            ...topics.map(
              (topic) => _SelectableTopicCard(
                topic: topic,
                mode: mode,
                onTap: () => onTopicSelected(topic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectableTopicCard extends StatelessWidget {
  const _SelectableTopicCard({
    required this.topic,
    required this.mode,
    required this.onTap,
  });

  final Topic topic;
  final TopicSelectMode mode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final count = DataService.getVocabulariesByTopic(topic.id).length;
    final actionLabel =
        mode == TopicSelectMode.lesson ? 'Học chủ đề này' : 'Làm quiz';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: topic.color.withAlpha(31),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(topic.icon, color: topic.color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$count từ vựng - $actionLabel',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                mode == TopicSelectMode.lesson
                    ? Icons.menu_book_outlined
                    : Icons.quiz_outlined,
                color: topic.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
