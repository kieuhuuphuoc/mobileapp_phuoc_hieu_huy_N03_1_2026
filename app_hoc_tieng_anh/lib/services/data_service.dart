import 'package:flutter/material.dart';

import '../models/question.dart';
import '../models/topic.dart';
import '../models/vocabulary.dart';
import '../utils/constants.dart';

class DataService {
  static final List<Topic> _topics = [
    Topic(
      id: 1,
      name: 'Gia đình',
      description: 'Từ vựng về các thành viên trong gia đình',
      icon: Icons.family_restroom,
      color: AppColors.primary,
    ),
    Topic(
      id: 2,
      name: 'Trường học',
      description: 'Từ vựng thường gặp trong lớp học',
      icon: Icons.school_outlined,
      color: AppColors.accent,
    ),
    Topic(
      id: 3,
      name: 'Đồ ăn',
      description: 'Từ vựng về món ăn và đồ uống',
      icon: Icons.restaurant_outlined,
      color: Colors.green,
    ),
  ];

  static List<Topic> get topics => List.unmodifiable(_topics);

  static final List<Vocabulary> _vocabularies = [
    const Vocabulary(
      id: 1,
      topicId: 1,
      word: 'Father',
      meaning: 'Bố',
      pronunciation: '/father/',
      example: 'My father is a teacher.',
    ),
    const Vocabulary(
      id: 2,
      topicId: 1,
      word: 'Mother',
      meaning: 'Mẹ',
      pronunciation: '/mother/',
      example: 'My mother cooks dinner.',
    ),
    const Vocabulary(
      id: 3,
      topicId: 1,
      word: 'Brother',
      meaning: 'Anh/em trai',
      pronunciation: '/brother/',
      example: 'My brother likes football.',
    ),
    const Vocabulary(
      id: 4,
      topicId: 1,
      word: 'Sister',
      meaning: 'Chị/em gái',
      pronunciation: '/sister/',
      example: 'My sister is kind.',
    ),
    const Vocabulary(
      id: 5,
      topicId: 2,
      word: 'Teacher',
      meaning: 'Giáo viên',
      pronunciation: '/teacher/',
      example: 'The teacher explains the lesson.',
    ),
    const Vocabulary(
      id: 6,
      topicId: 2,
      word: 'Student',
      meaning: 'Học sinh',
      pronunciation: '/student/',
      example: 'The student reads a book.',
    ),
    const Vocabulary(
      id: 7,
      topicId: 2,
      word: 'Book',
      meaning: 'Quyển sách',
      pronunciation: '/book/',
      example: 'This book is interesting.',
    ),
    const Vocabulary(
      id: 8,
      topicId: 2,
      word: 'Classroom',
      meaning: 'Lớp học',
      pronunciation: '/classroom/',
      example: 'The classroom is clean.',
    ),
    const Vocabulary(
      id: 9,
      topicId: 3,
      word: 'Rice',
      meaning: 'Cơm/gạo',
      pronunciation: '/rice/',
      example: 'I eat rice every day.',
    ),
    const Vocabulary(
      id: 10,
      topicId: 3,
      word: 'Bread',
      meaning: 'Bánh mì',
      pronunciation: '/bread/',
      example: 'She buys bread for breakfast.',
    ),
    const Vocabulary(
      id: 11,
      topicId: 3,
      word: 'Milk',
      meaning: 'Sữa',
      pronunciation: '/milk/',
      example: 'He drinks milk in the morning.',
    ),
    const Vocabulary(
      id: 12,
      topicId: 3,
      word: 'Water',
      meaning: 'Nước',
      pronunciation: '/water/',
      example: 'Please drink more water.',
    ),
  ];

  static List<Vocabulary> get vocabularies => List.unmodifiable(_vocabularies);

  static Topic addTopic({
    required String name,
    required String description,
    IconData icon = Icons.topic_outlined,
    Color color = AppColors.primary,
  }) {
    final nextId = _topics.isEmpty
        ? 1
        : _topics.map((item) => item.id).reduce((a, b) => a > b ? a : b) + 1;

    final topic = Topic(
      id: nextId,
      name: name.trim(),
      description: description.trim(),
      icon: icon,
      color: color,
    );
    _topics.add(topic);
    return topic;
  }

  static List<Vocabulary> getVocabulariesByTopic(int topicId) {
    return _vocabularies.where((word) => word.topicId == topicId).toList();
  }

  static Vocabulary addVocabulary({
    required int topicId,
    required String word,
    required String meaning,
    required String pronunciation,
    required String example,
  }) {
    final nextId = _vocabularies.isEmpty
        ? 1
        : _vocabularies.map((item) => item.id).reduce((a, b) => a > b ? a : b) +
            1;

    final vocabulary = Vocabulary(
      id: nextId,
      topicId: topicId,
      word: word.trim(),
      meaning: meaning.trim(),
      pronunciation: pronunciation.trim(),
      example: example.trim(),
    );
    _vocabularies.add(vocabulary);
    return vocabulary;
  }

  static void updateVocabulary(Vocabulary vocabulary) {
    final index = _vocabularies.indexWhere((item) => item.id == vocabulary.id);
    if (index == -1) return;
    _vocabularies[index] = vocabulary;
  }

  static void deleteVocabulary(int id) {
    _vocabularies.removeWhere((item) => item.id == id);
  }

  static List<Question> getQuestionsByTopic(int topicId) {
    final words = getVocabulariesByTopic(topicId);
    return words.map((word) {
      final wrongOptions = _vocabularies
          .where((item) => item.id != word.id)
          .take(3)
          .map((item) => item.meaning)
          .toList();
      final options = [word.meaning, ...wrongOptions];
      final correctIndex = word.id % options.length;
      final correctAnswer = options.removeAt(0);
      options.insert(correctIndex, correctAnswer);

      return Question(
        questionText: 'Từ "${word.word}" có nghĩa là gì?',
        options: options,
        correctIndex: correctIndex,
      );
    }).toList();
  }
}
