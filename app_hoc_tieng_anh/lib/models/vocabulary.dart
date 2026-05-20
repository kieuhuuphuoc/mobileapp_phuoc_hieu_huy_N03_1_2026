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
}
