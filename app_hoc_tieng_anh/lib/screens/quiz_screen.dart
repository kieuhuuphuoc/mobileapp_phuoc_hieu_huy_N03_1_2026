import 'package:flutter/material.dart';

import '../models/question.dart';
import '../models/topic.dart';
import '../services/data_service.dart';
import '../services/study_service.dart';
import '../utils/constants.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.topic});

  final Topic topic;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _studyService = StudyService();
  late final List<Question> _questions;
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _isFinished = false;
  bool _savedResult = false;

  @override
  void initState() {
    super.initState();
    _questions = DataService.getQuestionsByTopic(widget.topic.id);
  }

  void _selectAnswer(int index) {
    if (_selectedIndex != null) return;

    setState(() {
      _selectedIndex = index;
      if (index == _questions[_currentIndex].correctIndex) {
        _score++;
      }
    });
  }

  Future<void> _finishQuiz() async {
    if (!_savedResult) {
      await _studyService.addQuizResult(
        score: _score,
        total: _questions.length,
      );
      _savedResult = true;
    }
    if (mounted) setState(() => _isFinished = true);
  }

  void _nextQuestion() {
    if (_currentIndex == _questions.length - 1) {
      _finishQuiz();
      return;
    }

    setState(() {
      _currentIndex++;
      _selectedIndex = null;
    });
  }

  void _restart() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _selectedIndex = null;
      _isFinished = false;
      _savedResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Quiz: ${widget.topic.name}'),
        backgroundColor: widget.topic.color,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: _questions.isEmpty
            ? _buildEmptyState()
            : _isFinished
                ? _buildResult()
                : _buildQuestion(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.quiz_outlined, size: 72, color: widget.topic.color),
            const SizedBox(height: 16),
            const Text(
              'Chưa có câu hỏi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Hãy thêm từ vựng vào chủ đề này trước khi làm quiz.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.subtitleColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion() {
    final question = _questions[_currentIndex];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Câu ${_currentIndex + 1}/${_questions.length}',
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.subtitleColor,
          ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: (_currentIndex + 1) / _questions.length,
          backgroundColor: Colors.white,
          color: widget.topic.color,
          minHeight: 8,
          borderRadius: BorderRadius.circular(8),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            question.questionText,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
        ),
        const SizedBox(height: 18),
        ...List.generate(
          question.options.length,
          (index) => _AnswerButton(
            text: question.options[index],
            index: index,
            selectedIndex: _selectedIndex,
            correctIndex: question.correctIndex,
            color: widget.topic.color,
            onTap: () => _selectAnswer(index),
          ),
        ),
        const SizedBox(height: 12),
        if (_selectedIndex != null)
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.topic.color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _currentIndex == _questions.length - 1
                    ? 'Xem kết quả'
                    : 'Câu tiếp theo',
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildResult() {
    final percent = ((_score / _questions.length) * 100).round();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 82,
              color: widget.topic.color,
            ),
            const SizedBox(height: 16),
            const Text(
              'Hoàn thành quiz',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Bạn đúng $_score/${_questions.length} câu - $percent%',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.subtitleColor,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _restart,
                icon: const Icon(Icons.refresh),
                label: const Text('Làm lại'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.topic.color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Quay lại'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.text,
    required this.index,
    required this.selectedIndex,
    required this.correctIndex,
    required this.color,
    required this.onTap,
  });

  final String text;
  final int index;
  final int? selectedIndex;
  final int correctIndex;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isAnswered = selectedIndex != null;
    final isSelected = selectedIndex == index;
    final isCorrect = correctIndex == index;

    Color borderColor = AppColors.border;
    Color backgroundColor = Colors.white;
    IconData? trailingIcon;

    if (isAnswered && isCorrect) {
      borderColor = AppColors.success;
      backgroundColor = AppColors.success.withAlpha(26);
      trailingIcon = Icons.check_circle;
    } else if (isAnswered && isSelected) {
      borderColor = AppColors.danger;
      backgroundColor = AppColors.danger.withAlpha(26);
      trailingIcon = Icons.cancel;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: isAnswered ? null : onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color.withAlpha(31),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                if (trailingIcon != null)
                  Icon(
                    trailingIcon,
                    color: isCorrect ? AppColors.success : AppColors.danger,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
