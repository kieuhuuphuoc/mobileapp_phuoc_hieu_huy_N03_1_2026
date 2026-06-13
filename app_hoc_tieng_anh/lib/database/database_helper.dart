import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(
      path,
      version: 4,
      onCreate: _createDB,
      onOpen: _ensureTables,
      onUpgrade: (db, oldVersion, newVersion) => _ensureTables(db),
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await _ensureTables(db);
  }

  Future<void> _ensureTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS study_days (
        date TEXT PRIMARY KEY,
        lessons INTEGER NOT NULL DEFAULT 0,
        quizzes INTEGER NOT NULL DEFAULT 0,
        score INTEGER NOT NULL DEFAULT 0,
        total INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // === THÊM BẢNG MỚI ===
    await db.execute('''
      CREATE TABLE IF NOT EXISTS learned_words (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        topic_id INTEGER NOT NULL,
        count INTEGER NOT NULL DEFAULT 0,
        last_learned TEXT NOT NULL,
        UNIQUE(topic_id)
      )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<Map<String, dynamic>?> findUserByEmail(String email) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return result.first;
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return result.first;
  }

  String _dateKey(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  Future<void> markTodayStudied() async {
    final db = await instance.database;
    final today = _dateKey(DateTime.now());
    await db.insert(
      'study_days',
      {'date': today},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> addLessonStudy() async {
    final db = await instance.database;
    final today = _dateKey(DateTime.now());
    await markTodayStudied();
    await db.rawUpdate(
      'UPDATE study_days SET lessons = lessons + 1 WHERE date = ?',
      [today],
    );
  }

  Future<void> addQuizResult({required int score, required int total}) async {
    final db = await instance.database;
    final today = _dateKey(DateTime.now());
    await markTodayStudied();
    await db.rawUpdate(
      '''
      UPDATE study_days
      SET quizzes = quizzes + 1,
          score = score + ?,
          total = total + ?
      WHERE date = ?
      ''',
      [score, total, today],
    );
  }

  Future<List<Map<String, dynamic>>> getRecentStudyDays({int limit = 7}) async {
    final db = await instance.database;
    return db.query(
      'study_days',
      orderBy: 'date DESC',
      limit: limit,
    );
  }

  Future<Map<String, dynamic>> getStudySummary() async {
    final db = await instance.database;
    final rows = await db.query('study_days', orderBy: 'date DESC');

    final studiedDates = rows.map((row) => row['date'] as String).toSet();
    final today = DateTime.now();
    var streak = 0;
    for (var i = 0; i < 365; i++) {
      final key = _dateKey(today.subtract(Duration(days: i)));
      if (!studiedDates.contains(key)) break;
      streak++;
    }

    final totals = await db.rawQuery('''
      SELECT
        COALESCE(SUM(lessons), 0) AS lessons,
        COALESCE(SUM(quizzes), 0) AS quizzes,
        COALESCE(SUM(score), 0) AS score,
        COALESCE(SUM(total), 0) AS total,
        COUNT(*) AS days
      FROM study_days
    ''');

    final totalRow = totals.first;
    return {
      'streak': streak,
      'days': totalRow['days'] as int,
      'lessons': totalRow['lessons'] as int,
      'quizzes': totalRow['quizzes'] as int,
      'score': totalRow['score'] as int,
      'total': totalRow['total'] as int,
      'recentDays': rows.take(7).toList(),
    };
  }

  // === HÀM MỚI ===
  Future<void> saveLearnedWords(int topicId, int count) async {
    final db = await instance.database;
    final now = DateTime.now().toIso8601String();
    await db.insert(
      'learned_words',
      {
        'topic_id': topicId,
        'count': count,
        'last_learned': now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> getLearnedWords(int topicId) async {
    final db = await instance.database;
    final result = await db.query(
      'learned_words',
      where: 'topic_id = ?',
      whereArgs: [topicId],
    );
    if (result.isEmpty) return 0;
    return result.first['count'] as int;
  }
}
