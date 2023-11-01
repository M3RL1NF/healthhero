import 'package:sqflite/sqflite.dart';
import '../models/challenge.dart';
import 'DatabaseHelper.dart';
import 'package:healthhero/controllers/ChallengeController.dart';

class ChallengeHelper {
  static const String tableName = 'challenges';

  static Future<List<Challenge>> getChallenges() async {
    final Database db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('challenges');

    return List.generate(maps.length, (i) {
      return Challenge(
        id: maps[i]['id'],
        date: DateTime.parse(maps[i]['date']),
        title: maps[i]['title'],
        description: maps[i]['description'],
        explanation: maps[i]['explanation'],
        category: maps[i]['category'],
        progress: maps[i]['progress'],
        userProgress: maps[i]['userProgress'],
      );
    });
  }

  static Future<void> updateUserProgress(int id) async {
    final Database db = await DatabaseHelper.database;
    await db.rawUpdate('''
      UPDATE challenges 
      SET userProgress = userProgress + 1 
      WHERE id = ?
    ''', [id]);
  }

  static Future<List<Challenge>> getDailyChallenges(DateTime currentDate) async {
    List<Challenge> existingChallenges = await getChallenges();
    List<Challenge> todayChallenges = existingChallenges
        .where((challenge) =>
            challenge.date.year == currentDate.year &&
            challenge.date.month == currentDate.month &&
            challenge.date.day == currentDate.day)
        .toList();

    if (todayChallenges.isEmpty) {
      await ChallengeController.generateDailyChallenges(currentDate);
      existingChallenges = await getChallenges();
      todayChallenges = existingChallenges
          .where((challenge) =>
              challenge.date.year == currentDate.year &&
              challenge.date.month == currentDate.month &&
              challenge.date.day == currentDate.day)
          .toList();
    }

    return todayChallenges;
  }

  static Future<void> createChallenge(Challenge challenge) async {
    final Database db = await DatabaseHelper.database;
    await db.insert(
      tableName,
      challenge.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
