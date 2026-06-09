class Vocabulary {
  const Vocabulary({
    required this.id,
    required this.topicId,
    required this.word,
    required this.meaning,
    required this.pronunciation,
    required this.example,
  });

  final int id;
  final int topicId;
  final String word;
  final String meaning;
  final String pronunciation;
  final String example;

  Vocabulary copyWith({
    int? id,
    int? topicId,
    String? word,
    String? meaning,
    String? pronunciation,
    String? example,
  }) {
    return Vocabulary(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      word: word ?? this.word,
      meaning: meaning ?? this.meaning,
      pronunciation: pronunciation ?? this.pronunciation,
      example: example ?? this.example,
    );
  }
}
