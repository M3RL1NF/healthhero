import 'package:sqflite/sqflite.dart';
import '../models/quiz.dart';
import 'DatabaseHelper.dart';
import '../controllers/QuizController.dart';

class QuizHelper {
  static const String tableName = 'quizzes';

  static Future<List<Quiz>> getQuizzes() async {
    final Database db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return Quiz(
        id: maps[i]['id'],
        date: DateTime.parse(maps[i]['date']),
        question: maps[i]['question'],
        optionA: maps[i]['optionA'],
        optionB: maps[i]['optionB'],
        optionC: maps[i]['optionC'],
        optionD: maps[i]['optionD'],
        solution: maps[i]['solution'],
        answer: maps[i]['answer'] != null ? int.parse(maps[i]['answer']) : null,
      );
    });
  }

  static Future<Quiz?> getDailyQuiz(DateTime currentDate) async {
    List<Quiz> existingQuiz = await getQuizzes();
    List<Quiz> todayQuizzes = existingQuiz
        .where((quiz) =>
            quiz.date.year == currentDate.year &&
            quiz.date.month == currentDate.month &&
            quiz.date.day == currentDate.day)
        .toList();

    if (todayQuizzes.isEmpty) {
      await QuizController.generateDailyQuiz(currentDate);
      existingQuiz = await getQuizzes();
      todayQuizzes = existingQuiz
          .where((quiz) =>
              quiz.date.year == currentDate.year &&
              quiz.date.month == currentDate.month &&
              quiz.date.day == currentDate.day)
          .toList();
    }

    return todayQuizzes.isNotEmpty ? todayQuizzes[0] : null;
  }

  static Future<void> createQuiz(Quiz quiz) async {
    final Database db = await DatabaseHelper.database;
    await db.insert(
      tableName,
      quiz.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateQuizAnswer(int id, int answer) async {
    final db = await DatabaseHelper.database;
    await db.update(
      tableName,
      {'answer': answer},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
