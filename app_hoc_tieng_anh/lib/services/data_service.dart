import 'package:flutter/material.dart';
import '../models/question.dart';
import '../models/topic.dart';
import '../models/vocabulary.dart';
import '../utils/constants.dart';

class DataService {
  static final List<Topic> _topics = [
    const Topic(
      id: 1,
      name: 'Gia đình',
      description: 'Từ vựng về các thành viên trong gia đình',
      icon: Icons.family_restroom,
      color: AppColors.primary,
    ),
    const Topic(
      id: 2,
      name: 'Trường học',
      description: 'Từ vựng thường gặp trong lớp học',
      icon: Icons.school_outlined,
      color: AppColors.accent,
    ),
    const Topic(
      id: 3,
      name: 'Đồ ăn',
      description: 'Từ vựng về món ăn và đồ uống',
      icon: Icons.restaurant_outlined,
      color: AppColors.success,
    ),
    const Topic(
      id: 4,
      name: 'Động vật',
      description: 'Từ vựng về các loài động vật',
      icon: Icons.pets,
      color: Colors.orange,
    ),
    const Topic(
      id: 5,
      name: 'Màu sắc',
      description: 'Từ vựng về màu sắc',
      icon: Icons.palette,
      color: Colors.pink,
    ),
    const Topic(
      id: 6,
      name: 'Thời tiết',
      description: 'Từ vựng về thời tiết và mùa',
      icon: Icons.wb_sunny,
      color: Colors.cyan,
    ),
  ];

  static final List<Vocabulary> _vocabularies = [
    // === CHỦ ĐỀ 1: Gia đình (10 từ) ===
    const Vocabulary(
      id: 1,
      topicId: 1,
      word: 'Father',
      meaning: 'Bố',
      pronunciation: '/ˈfɑːðər/',
      example: 'My father is a teacher.',
    ),
    const Vocabulary(
      id: 2,
      topicId: 1,
      word: 'Mother',
      meaning: 'Mẹ',
      pronunciation: '/ˈmʌðər/',
      example: 'My mother cooks dinner.',
    ),
    const Vocabulary(
      id: 3,
      topicId: 1,
      word: 'Brother',
      meaning: 'Anh/em trai',
      pronunciation: '/ˈbrʌðər/',
      example: 'My brother likes football.',
    ),
    const Vocabulary(
      id: 4,
      topicId: 1,
      word: 'Sister',
      meaning: 'Chị/em gái',
      pronunciation: '/ˈsɪstər/',
      example: 'My sister is kind.',
    ),
    const Vocabulary(
      id: 5,
      topicId: 1,
      word: 'Grandfather',
      meaning: 'Ông',
      pronunciation: '/ˈɡrænfɑːðər/',
      example: 'My grandfather tells stories.',
    ),
    const Vocabulary(
      id: 6,
      topicId: 1,
      word: 'Grandmother',
      meaning: 'Bà',
      pronunciation: '/ˈɡrænmʌðər/',
      example: 'My grandmother makes cookies.',
    ),
    const Vocabulary(
      id: 7,
      topicId: 1,
      word: 'Uncle',
      meaning: 'Chú/cậu',
      pronunciation: '/ˈʌŋkl/',
      example: 'My uncle lives in Hanoi.',
    ),
    const Vocabulary(
      id: 8,
      topicId: 1,
      word: 'Aunt',
      meaning: 'Cô/dì',
      pronunciation: '/ɑːnt/',
      example: 'My aunt is a nurse.',
    ),
    const Vocabulary(
      id: 9,
      topicId: 1,
      word: 'Cousin',
      meaning: 'Anh/chị em họ',
      pronunciation: '/ˈkʌzn/',
      example: 'My cousin and I play together.',
    ),
    const Vocabulary(
      id: 10,
      topicId: 1,
      word: 'Parent',
      meaning: 'Cha mẹ',
      pronunciation: '/ˈpeərənt/',
      example: 'My parents love me.',
    ),

    // === CHỦ ĐỀ 2: Trường học (10 từ) ===
    const Vocabulary(
      id: 11,
      topicId: 2,
      word: 'Teacher',
      meaning: 'Giáo viên',
      pronunciation: '/ˈtiːtʃər/',
      example: 'The teacher explains the lesson.',
    ),
    const Vocabulary(
      id: 12,
      topicId: 2,
      word: 'Student',
      meaning: 'Học sinh',
      pronunciation: '/ˈstjuːdnt/',
      example: 'The student reads a book.',
    ),
    const Vocabulary(
      id: 13,
      topicId: 2,
      word: 'Book',
      meaning: 'Quyển sách',
      pronunciation: '/bʊk/',
      example: 'This book is interesting.',
    ),
    const Vocabulary(
      id: 14,
      topicId: 2,
      word: 'Classroom',
      meaning: 'Lớp học',
      pronunciation: '/ˈklɑːsruːm/',
      example: 'The classroom is clean.',
    ),
    const Vocabulary(
      id: 15,
      topicId: 2,
      word: 'Homework',
      meaning: 'Bài tập về nhà',
      pronunciation: '/ˈhəʊmwɜːk/',
      example: 'I do my homework every day.',
    ),
    const Vocabulary(
      id: 16,
      topicId: 2,
      word: 'Exam',
      meaning: 'Kỳ thi',
      pronunciation: '/ɪɡˈzæm/',
      example: 'The exam is difficult.',
    ),
    const Vocabulary(
      id: 17,
      topicId: 2,
      word: 'Friend',
      meaning: 'Bạn bè',
      pronunciation: '/frend/',
      example: 'My friend helps me study.',
    ),
    const Vocabulary(
      id: 18,
      topicId: 2,
      word: 'Library',
      meaning: 'Thư viện',
      pronunciation: '/ˈlaɪbrəri/',
      example: 'I go to the library to read.',
    ),
    const Vocabulary(
      id: 19,
      topicId: 2,
      word: 'Pen',
      meaning: 'Bút',
      pronunciation: '/pen/',
      example: 'I write with a pen.',
    ),
    const Vocabulary(
      id: 20,
      topicId: 2,
      word: 'Ruler',
      meaning: 'Thước kẻ',
      pronunciation: '/ˈruːlər/',
      example: 'I use a ruler to draw lines.',
    ),

    // === CHỦ ĐỀ 3: Đồ ăn (10 từ) ===
    const Vocabulary(
      id: 21,
      topicId: 3,
      word: 'Rice',
      meaning: 'Cơm/gạo',
      pronunciation: '/raɪs/',
      example: 'I eat rice every day.',
    ),
    const Vocabulary(
      id: 22,
      topicId: 3,
      word: 'Bread',
      meaning: 'Bánh mì',
      pronunciation: '/bred/',
      example: 'She buys bread for breakfast.',
    ),
    const Vocabulary(
      id: 23,
      topicId: 3,
      word: 'Milk',
      meaning: 'Sữa',
      pronunciation: '/mɪlk/',
      example: 'He drinks milk in the morning.',
    ),
    const Vocabulary(
      id: 24,
      topicId: 3,
      word: 'Water',
      meaning: 'Nước',
      pronunciation: '/ˈwɔːtər/',
      example: 'Please drink more water.',
    ),
    const Vocabulary(
      id: 25,
      topicId: 3,
      word: 'Egg',
      meaning: 'Trứng',
      pronunciation: '/eɡ/',
      example: 'I eat an egg for breakfast.',
    ),
    const Vocabulary(
      id: 26,
      topicId: 3,
      word: 'Meat',
      meaning: 'Thịt',
      pronunciation: '/miːt/',
      example: 'She cooks meat for dinner.',
    ),
    const Vocabulary(
      id: 27,
      topicId: 3,
      word: 'Fish',
      meaning: 'Cá',
      pronunciation: '/fɪʃ/',
      example: 'My father likes to eat fish.',
    ),
    const Vocabulary(
      id: 28,
      topicId: 3,
      word: 'Fruit',
      meaning: 'Trái cây',
      pronunciation: '/fruːt/',
      example: 'I eat fruit every day.',
    ),
    const Vocabulary(
      id: 29,
      topicId: 3,
      word: 'Vegetable',
      meaning: 'Rau củ',
      pronunciation: '/ˈvedʒtəbl/',
      example: 'Vegetables are good for health.',
    ),
    const Vocabulary(
      id: 30,
      topicId: 3,
      word: 'Juice',
      meaning: 'Nước ép',
      pronunciation: '/dʒuːs/',
      example: 'I drink orange juice.',
    ),

    // === CHỦ ĐỀ 4: Động vật (10 từ) ===
    const Vocabulary(
      id: 31,
      topicId: 4,
      word: 'Dog',
      meaning: 'Chó',
      pronunciation: '/dɒɡ/',
      example: 'My dog is very friendly.',
    ),
    const Vocabulary(
      id: 32,
      topicId: 4,
      word: 'Cat',
      meaning: 'Mèo',
      pronunciation: '/kæt/',
      example: 'The cat sleeps all day.',
    ),
    const Vocabulary(
      id: 33,
      topicId: 4,
      word: 'Bird',
      meaning: 'Chim',
      pronunciation: '/bɜːd/',
      example: 'The bird sings beautifully.',
    ),
    const Vocabulary(
      id: 34,
      topicId: 4,
      word: 'Fish',
      meaning: 'Cá',
      pronunciation: '/fɪʃ/',
      example: 'The fish swims in the water.',
    ),
    const Vocabulary(
      id: 35,
      topicId: 4,
      word: 'Horse',
      meaning: 'Ngựa',
      pronunciation: '/hɔːs/',
      example: 'He rides a horse.',
    ),
    const Vocabulary(
      id: 36,
      topicId: 4,
      word: 'Elephant',
      meaning: 'Voi',
      pronunciation: '/ˈelɪfənt/',
      example: 'The elephant is very big.',
    ),
    const Vocabulary(
      id: 37,
      topicId: 4,
      word: 'Tiger',
      meaning: 'Hổ',
      pronunciation: '/ˈtaɪɡər/',
      example: 'The tiger runs fast.',
    ),
    const Vocabulary(
      id: 38,
      topicId: 4,
      word: 'Lion',
      meaning: 'Sư tử',
      pronunciation: '/ˈlaɪən/',
      example: 'The lion is the king of the jungle.',
    ),
    const Vocabulary(
      id: 39,
      topicId: 4,
      word: 'Monkey',
      meaning: 'Khỉ',
      pronunciation: '/ˈmʌŋki/',
      example: 'The monkey climbs the tree.',
    ),
    const Vocabulary(
      id: 40,
      topicId: 4,
      word: 'Bear',
      meaning: 'Gấu',
      pronunciation: '/beər/',
      example: 'The bear sleeps in winter.',
    ),

    // === CHỦ ĐỀ 5: Màu sắc (10 từ) ===
    const Vocabulary(
      id: 41,
      topicId: 5,
      word: 'Red',
      meaning: 'Màu đỏ',
      pronunciation: '/red/',
      example: 'The apple is red.',
    ),
    const Vocabulary(
      id: 42,
      topicId: 5,
      word: 'Blue',
      meaning: 'Màu xanh dương',
      pronunciation: '/bluː/',
      example: 'The sky is blue.',
    ),
    const Vocabulary(
      id: 43,
      topicId: 5,
      word: 'Green',
      meaning: 'Màu xanh lá',
      pronunciation: '/ɡriːn/',
      example: 'The grass is green.',
    ),
    const Vocabulary(
      id: 44,
      topicId: 5,
      word: 'Yellow',
      meaning: 'Màu vàng',
      pronunciation: '/ˈjeləʊ/',
      example: 'The sun is yellow.',
    ),
    const Vocabulary(
      id: 45,
      topicId: 5,
      word: 'White',
      meaning: 'Màu trắng',
      pronunciation: '/waɪt/',
      example: 'The snow is white.',
    ),
    const Vocabulary(
      id: 46,
      topicId: 5,
      word: 'Black',
      meaning: 'Màu đen',
      pronunciation: '/blæk/',
      example: 'The night is black.',
    ),
    const Vocabulary(
      id: 47,
      topicId: 5,
      word: 'Pink',
      meaning: 'Màu hồng',
      pronunciation: '/pɪŋk/',
      example: 'The flower is pink.',
    ),
    const Vocabulary(
      id: 48,
      topicId: 5,
      word: 'Orange',
      meaning: 'Màu cam',
      pronunciation: '/ˈɒrɪndʒ/',
      example: 'The orange is orange.',
    ),
    const Vocabulary(
      id: 49,
      topicId: 5,
      word: 'Purple',
      meaning: 'Màu tím',
      pronunciation: '/ˈpɜːpl/',
      example: 'The grape is purple.',
    ),
    const Vocabulary(
      id: 50,
      topicId: 5,
      word: 'Brown',
      meaning: 'Màu nâu',
      pronunciation: '/braʊn/',
      example: 'The chocolate is brown.',
    ),

    // === CHỦ ĐỀ 6: Thời tiết (10 từ) ===
    const Vocabulary(
      id: 51,
      topicId: 6,
      word: 'Sunny',
      meaning: 'Nắng',
      pronunciation: '/ˈsʌni/',
      example: 'Today is sunny.',
    ),
    const Vocabulary(
      id: 52,
      topicId: 6,
      word: 'Rainy',
      meaning: 'Mưa',
      pronunciation: '/ˈreɪni/',
      example: 'It is rainy today.',
    ),
    const Vocabulary(
      id: 53,
      topicId: 6,
      word: 'Cloudy',
      meaning: 'Mây',
      pronunciation: '/ˈklaʊdi/',
      example: 'The sky is cloudy.',
    ),
    const Vocabulary(
      id: 54,
      topicId: 6,
      word: 'Windy',
      meaning: 'Gió',
      pronunciation: '/ˈwɪndi/',
      example: 'It is very windy.',
    ),
    const Vocabulary(
      id: 55,
      topicId: 6,
      word: 'Cold',
      meaning: 'Lạnh',
      pronunciation: '/kəʊld/',
      example: 'The winter is cold.',
    ),
    const Vocabulary(
      id: 56,
      topicId: 6,
      word: 'Hot',
      meaning: 'Nóng',
      pronunciation: '/hɒt/',
      example: 'The summer is hot.',
    ),
    const Vocabulary(
      id: 57,
      topicId: 6,
      word: 'Warm',
      meaning: 'Ấm áp',
      pronunciation: '/wɔːm/',
      example: 'The spring is warm.',
    ),
    const Vocabulary(
      id: 58,
      topicId: 6,
      word: 'Cool',
      meaning: 'Mát mẻ',
      pronunciation: '/kuːl/',
      example: 'The autumn is cool.',
    ),
    const Vocabulary(
      id: 59,
      topicId: 6,
      word: 'Snowy',
      meaning: 'Có tuyết',
      pronunciation: '/ˈsnəʊi/',
      example: 'It is snowy in December.',
    ),
    const Vocabulary(
      id: 60,
      topicId: 6,
      word: 'Stormy',
      meaning: 'Bão',
      pronunciation: '/ˈstɔːmi/',
      example: 'The stormy weather is dangerous.',
    ),
  ];

  static List<Topic> get topics => List.unmodifiable(_topics);
  static List<Vocabulary> get vocabularies => List.unmodifiable(_vocabularies);

  static Topic addTopic({
    required String name,
    required String description,
    IconData icon = Icons.topic_outlined,
    Color color = AppColors.primary,
  }) {
    final nextId = _nextTopicId();
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

  static int _nextTopicId() {
    if (_topics.isEmpty) return 1;
    return _topics.map((item) => item.id).reduce((a, b) => a > b ? a : b) + 1;
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
    final nextId = _nextVocabularyId();
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

  static int _nextVocabularyId() {
    if (_vocabularies.isEmpty) return 1;
    return _vocabularies
            .map((item) => item.id)
            .reduce((a, b) => a > b ? a : b) +
        1;
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

      while (wrongOptions.length < 3) {
        wrongOptions.add('Chưa có đáp án');
      }

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