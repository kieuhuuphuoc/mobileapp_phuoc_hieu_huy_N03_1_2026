import 'package:flutter/material.dart';

import '../models/question.dart';
import '../models/topic.dart';
import '../models/vocabulary.dart';
import '../utils/constants.dart';

class DataService {
  static const List<Topic> topics = [
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

  static const List<Vocabulary> vocabularies = [
    Vocabulary(
      id: 1,
      topicId: 1,
      word: 'Father',
      meaning: 'Bố',
      pronunciation: '/ˈfɑːðər/',
      example: 'My father is a teacher.',
    ),
    Vocabulary(
      id: 2,
      topicId: 1,
      word: 'Mother',
      meaning: 'Mẹ',
      pronunciation: '/ˈmʌðər/',
      example: 'My mother cooks dinner.',
    ),
    Vocabulary(
      id: 3,
      topicId: 1,
      word: 'Brother',
      meaning: 'Anh/em trai',
      pronunciation: '/ˈbrʌðər/',
      example: 'My brother likes football.',
    ),
    Vocabulary(
      id: 4,
      topicId: 1,
      word: 'Sister',
      meaning: 'Chị/em gái',
      pronunciation: '/ˈsɪstər/',
      example: 'My sister is kind.',
    ),
    Vocabulary(
      id: 5,
      topicId: 2,
      word: 'Teacher',
      meaning: 'Giáo viên',
      pronunciation: '/ˈtiːtʃər/',
      example: 'The teacher explains the lesson.',
    ),
    Vocabulary(
      id: 6,
      topicId: 2,
      word: 'Student',
      meaning: 'Học sinh',
      pronunciation: '/ˈstuːdənt/',
      example: 'The student reads a book.',
    ),
    Vocabulary(
      id: 7,
      topicId: 2,
      word: 'Book',
      meaning: 'Quyển sách',
      pronunciation: '/bʊk/',
      example: 'This book is interesting.',
    ),
    Vocabulary(
      id: 8,
      topicId: 2,
      word: 'Classroom',
      meaning: 'Lớp học',
      pronunciation: '/ˈklæsruːm/',
      example: 'The classroom is clean.',
    ),
    Vocabulary(
      id: 9,
      topicId: 3,
      word: 'Rice',
      meaning: 'Cơm/gạo',
      pronunciation: '/raɪs/',
      example: 'I eat rice every day.',
    ),
    Vocabulary(
      id: 10,
      topicId: 3,
      word: 'Bread',
      meaning: 'Bánh mì',
      pronunciation: '/bred/',
      example: 'She buys bread for breakfast.',
    ),
    Vocabulary(
      id: 11,
      topicId: 3,
      word: 'Milk',
      meaning: 'Sữa',
      pronunciation: '/mɪlk/',
      example: 'He drinks milk in the morning.',
    ),
    Vocabulary(
      id: 12,
      topicId: 3,
      word: 'Water',
      meaning: 'Nước',
      pronunciation: '/ˈwɔːtər/',
      example: 'Please drink more water.',
    ),
  ];

  static List<Vocabulary> getVocabulariesByTopic(int topicId) {
    return vocabularies.where((word) => word.topicId == topicId).toList();
  }

  static List<Question> getQuestionsByTopic(int topicId) {
    final words = getVocabulariesByTopic(topicId);
    return words.map((word) {
      final wrongOptions = vocabularies
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
