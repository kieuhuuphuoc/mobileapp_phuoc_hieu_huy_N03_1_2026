import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../services/data_service.dart';
import '../utils/constants.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key, required this.topic});

  final Topic topic;

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  int _currentIndex = 0;
  bool _isFlipped = false;

  void _nextCard() {
    setState(() {
      _currentIndex++;
      _isFlipped = false;
    });
  }

  void _flipCard() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    final words = DataService.getVocabulariesByTopic(widget.topic.id);

    if (words.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Flashcard: ${widget.topic.name}'),
          backgroundColor: widget.topic.color,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.book, size: 80, color: AppColors.subtitleColor),
              const SizedBox(height: 16),
              const Text(
                'Chủ đề này chưa có từ vựng',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Hãy thêm từ vựng vào chủ đề này',
                style: TextStyle(color: AppColors.subtitleColor),
              ),
            ],
          ),
        ),
      );
    }

    if (_currentIndex >= words.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Flashcard: ${widget.topic.name}'),
          backgroundColor: widget.topic.color,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.celebration, size: 80, color: AppColors.success),
              const SizedBox(height: 16),
              const Text(
                '🎉 Hoàn thành!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Bạn đã học xong ${words.length} từ vựng',
                style: TextStyle(fontSize: 16, color: AppColors.subtitleColor),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.topic.color,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Quay lại'),
              ),
            ],
          ),
        ),
      );
    }

    final word = words[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard: ${widget.topic.name}'),
        backgroundColor: widget.topic.color,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${_currentIndex + 1}/${words.length}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _flipCard,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isFlipped
                        ? Container(
                            key: const ValueKey('back'),
                            padding: const EdgeInsets.all(24),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Nghĩa',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.subtitleColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    word.meaning,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      word.example,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.subtitleColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    '👆 Nhấn để quay lại',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.subtitleColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            key: const ValueKey('front'),
                            padding: const EdgeInsets.all(24),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Từ vựng',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.subtitleColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    word.word,
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    word.pronunciation,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: AppColors.subtitleColor,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  const Text(
                                    '👆 Nhấn để lật thẻ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.subtitleColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextCard,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.topic.color,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Tiếp theo'),
            ),
          ],
        ),
      ),
    );
  }
}