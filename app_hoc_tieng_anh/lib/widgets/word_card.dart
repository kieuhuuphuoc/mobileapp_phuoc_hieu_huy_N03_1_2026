import 'package:flutter/material.dart';
import '../models/vocabulary.dart';
import '../utils/constants.dart';
import '../services/data_service.dart';

class WordCard extends StatefulWidget {
  const WordCard({
    super.key,
    required this.vocabulary,
    this.onListen,
    this.onEdit,
    this.onDelete,
    this.onNote,
    this.onLevelChange,
  });

  final Vocabulary vocabulary;
  final VoidCallback? onListen;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onNote;
  final VoidCallback? onLevelChange;

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.vocabulary.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    final updatedWord = widget.vocabulary.copyWith(isFavorite: _isFavorite);
    DataService.updateVocabulary(updatedWord);
  }

  IconData _getLevelIcon(WordLevel level) {
    switch (level) {
      case WordLevel.easy: return Icons.sentiment_satisfied;
      case WordLevel.medium: return Icons.sentiment_neutral;
      case WordLevel.hard: return Icons.sentiment_dissatisfied;
    }
  }

  Color _getLevelColor(WordLevel level) {
    switch (level) {
      case WordLevel.easy: return Colors.green;
      case WordLevel.medium: return Colors.orange;
      case WordLevel.hard: return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.vocabulary.word,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: _toggleFavorite,
                ),
                if (widget.onListen != null)
                  IconButton(
                    icon: const Icon(Icons.volume_up, color: AppColors.primary),
                    onPressed: widget.onListen,
                  ),
                if (widget.onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit, color: AppColors.accent),
                    onPressed: widget.onEdit,
                  ),
                if (widget.onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.danger),
                    onPressed: widget.onDelete,
                  ),
                if (widget.onNote != null)
                  IconButton(
                    icon: const Icon(Icons.note_add, color: Colors.blue),
                    onPressed: widget.onNote,
                  ),
                if (widget.onLevelChange != null)
                  IconButton(
                    icon: Icon(
                      _getLevelIcon(widget.vocabulary.level),
                      color: _getLevelColor(widget.vocabulary.level),
                    ),
                    onPressed: widget.onLevelChange,
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.vocabulary.pronunciation,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.subtitleColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.vocabulary.meaning,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textColor,
              ),
            ),
            if (widget.vocabulary.note.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '📝 ${widget.vocabulary.note}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.blue,  // <-- Đã sửa từ shade800 thành blue
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
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
          ],
        ),
      ),
    );
  }
}