import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../services/data_service.dart';
import '../utils/constants.dart';
import 'auth/login_screen.dart';
import 'lesson_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final firstTopic = DataService.topics.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Học tiếng Anh'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Đăng xuất',
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Xin chào, $userName',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Chọn một chủ đề để bắt đầu học từ vựng hôm nay.',
              style: TextStyle(fontSize: 16, color: AppColors.subtitleColor),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: Icons.menu_book_outlined,
                    label: 'Bài học',
                    color: AppColors.primary,
                    onTap: () => _openLesson(context, firstTopic),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.quiz_outlined,
                    label: 'Luyện quiz',
                    color: AppColors.accent,
                    onTap: () => _openQuiz(context, firstTopic),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Chủ đề',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 12),
            ...DataService.topics.map(
              (topic) => _TopicCard(
                topic: topic,
                onTap: () => _openLesson(context, topic),
                onQuizTap: () => _openQuiz(context, topic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openLesson(BuildContext context, Topic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LessonScreen(topic: topic)),
    );
  }

  void _openQuiz(BuildContext context, Topic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QuizScreen(topic: topic)),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 30),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({
    required this.topic,
    required this.onTap,
    required this.onQuizTap,
  });

  final Topic topic;
  final VoidCallback onTap;
  final VoidCallback onQuizTap;

  @override
  Widget build(BuildContext context) {
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
                      topic.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Làm quiz',
                icon: const Icon(Icons.quiz_outlined),
                color: topic.color,
                onPressed: onQuizTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
