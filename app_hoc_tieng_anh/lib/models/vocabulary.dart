class Vocabulary {
  const Vocabulary({
    required this.id,
    required this.topicId,
    required this.word,
    required this.meaning,
    required this.pronunciation,
    required this.example,
    this.isFavorite = false,
    this.note = '',
    this.level = WordLevel.easy,
  });

  final int id;
  final int topicId;
  final String word;
  final String meaning;
  final String pronunciation;
  final String example;
  final bool isFavorite;
  final String note;
  final WordLevel level;

  Vocabulary copyWith({
    int? id,
    int? topicId,
    String? word,
    String? meaning,
    String? pronunciation,
    String? example,
    bool? isFavorite,
    String? note,
    WordLevel? level,
  }) {
    return Vocabulary(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      word: word ?? this.word,
      meaning: meaning ?? this.meaning,
      pronunciation: pronunciation ?? this.pronunciation,
      example: example ?? this.example,
      isFavorite: isFavorite ?? this.isFavorite,
      note: note ?? this.note,
      level: level ?? this.level,
    );
  }
}

enum WordLevel { easy, medium, hard }
