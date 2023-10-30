import 'package:sqflite/sqflite.dart';
import '../models/challenge.dart';
import 'DatabaseHelper.dart';

class ChallengeDBHelper {
  static const String tableName = 'challenges';

  static Future<int> insertChallenge(Challenge challenge) async {
    final Database db = await DatabaseHelper.database;
    return await db.insert(tableName, challenge.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Add other CRUD operations for the Challenge model here
}
