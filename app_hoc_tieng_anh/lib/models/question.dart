class Question {
  const Question({
    required this.questionText,
    required this.options,
    required this.correctIndex,
  });

  final String questionText;
  final List<String> options;
  final int correctIndex;
}
