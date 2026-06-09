import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../services/data_service.dart';
import '../utils/constants.dart';
import 'auth/login_screen.dart';
import 'lesson_screen.dart';
import 'quiz_screen.dart';
import 'topic_select_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userName});

  final String userName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _showAddTopicDialog() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    try {
      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Thêm chủ đề'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Tên chủ đề',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vui lòng nhập tên chủ đề';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Mô tả',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vui lòng nhập mô tả';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  DataService.addTopic(
                    name: nameController.text,
                    description: descriptionController.text,
                  );
                  Navigator.pop(context);
                  setState(() {});
                },
                child: const Text('Thêm'),
              ),
            ],
          );
        },
      );
    } finally {
      nameController.dispose();
      descriptionController.dispose();
    }
  }

  void _openTopicSelector(TopicSelectMode mode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TopicSelectScreen(
          mode: mode,
          onTopicSelected: (topic) {
            Navigator.pop(context);
            if (mode == TopicSelectMode.lesson) {
              _openLesson(topic);
            } else {
              _openQuiz(topic);
            }
          },
        ),
      ),
    );
  }

  void _openLesson(Topic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LessonScreen(topic: topic)),
    ).then((_) => setState(() {}));
  }

  void _openQuiz(Topic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QuizScreen(topic: topic)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topics = DataService.topics;

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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Thêm chủ đề'),
        onPressed: _showAddTopicDialog,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Xin chào, ${widget.userName}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Chọn chủ đề để học từ vựng hoặc làm quiz.',
              style: TextStyle(fontSize: 16, color: AppColors.subtitleColor),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: Icons.menu_book_outlined,
                    label: 'Chọn bài học',
                    color: AppColors.primary,
                    onTap: () => _openTopicSelector(TopicSelectMode.lesson),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.quiz_outlined,
                    label: 'Chọn quiz',
                    color: AppColors.accent,
                    onTap: () => _openTopicSelector(TopicSelectMode.quiz),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Chủ đề',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: _showAddTopicDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('Thêm'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...topics.map(
              (topic) => _TopicCard(
                topic: topic,
                onTap: () => _openLesson(topic),
                onQuizTap: () => _openQuiz(topic),
              ),
            ),
            const SizedBox(height: 76),
          ],
        ),
      ),
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
    final wordCount = DataService.getVocabulariesByTopic(topic.id).length;

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
                      '$wordCount từ - ${topic.description}',
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
