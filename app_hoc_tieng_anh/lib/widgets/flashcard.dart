import 'package:flutter/material.dart';
import '../models/vocabulary.dart';
import '../utils/constants.dart';

class Flashcard extends StatefulWidget {
  const Flashcard({
    super.key,
    required this.vocabulary,
    this.onSwiped,
  });

  final Vocabulary vocabulary;
  final VoidCallback? onSwiped;

  @override
  State<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  bool _isFlipped = false;

  void _flipCard() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: Container(
        height: 300,
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
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: _isFlipped
              ? _buildBack()
              : _buildFront(),
        ),
      ),
    );
  }

  Widget _buildFront() {
    return Container(
      key: const ValueKey('front'),
      padding: const EdgeInsets.all(24),
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
            widget.vocabulary.word,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.vocabulary.pronunciation,
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
    );
  }

  Widget _buildBack() {
    return Container(
      key: const ValueKey('back'),
      padding: const EdgeInsets.all(24),
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
            widget.vocabulary.meaning,
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
              widget.vocabulary.example,
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
    );
  }
}