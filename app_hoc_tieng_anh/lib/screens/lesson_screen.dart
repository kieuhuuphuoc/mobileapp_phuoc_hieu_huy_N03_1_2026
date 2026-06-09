import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../models/vocabulary.dart';
import '../services/data_service.dart';
import '../utils/constants.dart';
import '../widgets/word_card.dart';
import 'quiz_screen.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key, required this.topic});

  final Topic topic;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  void _listenWord(Vocabulary vocabulary) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Phát âm: ${vocabulary.word}')),
    );
  }

  Future<void> _showVocabularyDialog({Vocabulary? vocabulary}) async {
    final isEditing = vocabulary != null;
    final formKey = GlobalKey<FormState>();
    final wordController = TextEditingController(text: vocabulary?.word ?? '');
    final meaningController =
        TextEditingController(text: vocabulary?.meaning ?? '');
    final pronunciationController =
        TextEditingController(text: vocabulary?.pronunciation ?? '');
    final exampleController =
        TextEditingController(text: vocabulary?.example ?? '');

    try {
      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(isEditing ? 'Sửa từ vựng' : 'Thêm từ vựng'),
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDialogTextField(
                      controller: wordController,
                      label: 'Từ tiếng Anh',
                      validatorMessage: 'Vui lòng nhập từ tiếng Anh',
                    ),
                    _buildDialogTextField(
                      controller: meaningController,
                      label: 'Nghĩa tiếng Việt',
                      validatorMessage: 'Vui lòng nhập nghĩa',
                    ),
                    _buildDialogTextField(
                      controller: pronunciationController,
                      label: 'Phiên âm',
                      validatorMessage: null,
                    ),
                    _buildDialogTextField(
                      controller: exampleController,
                      label: 'Ví dụ',
                      validatorMessage: null,
                      maxLines: 2,
                    ),
                  ],
                ),
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

                  final pronunciation = pronunciationController.text.trim();
                  if (isEditing) {
                    DataService.updateVocabulary(
                      vocabulary.copyWith(
                        word: wordController.text.trim(),
                        meaning: meaningController.text.trim(),
                        pronunciation: pronunciation.isEmpty
                            ? '/${wordController.text.trim()}/'
                            : pronunciation,
                        example: exampleController.text.trim(),
                      ),
                    );
                  } else {
                    DataService.addVocabulary(
                      topicId: widget.topic.id,
                      word: wordController.text,
                      meaning: meaningController.text,
                      pronunciation: pronunciation.isEmpty
                          ? '/${wordController.text.trim()}/'
                          : pronunciation,
                      example: exampleController.text,
                    );
                  }

                  Navigator.pop(context);
                  setState(() {});
                },
                child: Text(isEditing ? 'Lưu' : 'Thêm'),
              ),
            ],
          );
        },
      );
    } finally {
      wordController.dispose();
      meaningController.dispose();
      pronunciationController.dispose();
      exampleController.dispose();
    }
  }

  Widget _buildDialogTextField({
    required TextEditingController controller,
    required String label,
    required String? validatorMessage,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: validatorMessage == null
            ? null
            : (value) {
                if (value == null || value.trim().isEmpty) {
                  return validatorMessage;
                }
                return null;
              },
      ),
    );
  }

  Future<void> _confirmDelete(Vocabulary vocabulary) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xóa từ vựng'),
          content: Text('Bạn có chắc muốn xóa "${vocabulary.word}" không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;
    DataService.deleteVocabulary(vocabulary.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final words = DataService.getVocabulariesByTopic(widget.topic.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.topic.name),
        backgroundColor: widget.topic.color,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: widget.topic.color,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Thêm từ'),
        onPressed: () => _showVocabularyDialog(),
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
                    color: widget.topic.color.withAlpha(31),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(widget.topic.icon,
                      color: widget.topic.color, size: 30),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.topic.name,
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
              widget.topic.description,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.subtitleColor,
              ),
            ),
            const SizedBox(height: 20),
            if (words.isEmpty)
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black12),
                ),
                child: const Text(
                  'Chủ đề này chưa có từ vựng. Bấm "Thêm từ" để tạo từ mới.',
                  style: TextStyle(color: AppColors.subtitleColor),
                ),
              )
            else
              ...words.map(
                (word) => WordCard(
                  vocabulary: word,
                  onListen: () => _listenWord(word),
                  onEdit: () => _showVocabularyDialog(vocabulary: word),
                  onDelete: () => _confirmDelete(word),
                ),
              ),
            const SizedBox(height: 8),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: words.isEmpty
                    ? null
                    : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizScreen(topic: widget.topic),
                          ),
                        ),
                icon: const Icon(Icons.quiz_outlined),
                label: const Text('Làm quiz chủ đề này'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.topic.color,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 76),
          ],
        ),
      ),
    );
  }
}
