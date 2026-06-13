import '../database/database_helper.dart';

class StudyService {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<void> markTodayStudied() {
    return _databaseHelper.markTodayStudied();
  }

  Future<void> addLessonStudy() {
    return _databaseHelper.addLessonStudy();
  }

  Future<void> addQuizResult({
    required int score,
    required int total,
  }) {
    return _databaseHelper.addQuizResult(score: score, total: total);
  }

  Future<Map<String, dynamic>> getSummary() {
    return _databaseHelper.getStudySummary();
  }
  Future<void> saveLearnedWords(int topicId, int count) async {
    await _databaseHelper.saveLearnedWords(topicId, count);
  }

  Future<int> getLearnedWords(int topicId) async {
    return await _databaseHelper.getLearnedWords(topicId);
  }
}
