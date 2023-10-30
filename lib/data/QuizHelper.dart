import 'package:sqflite/sqflite.dart';
import '../models/quiz.dart';
import 'DatabaseHelper.dart';

class QuizDBHelper {
  static const String tableName = 'quizzes';

  static Future<int> insertQuiz(Quiz quiz) async {
    final Database db = await DatabaseHelper.database;
    return await db.insert(tableName, quiz.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Add other CRUD operations for the Quiz model here
}
