import 'package:sqflite/sqflite.dart';
import '../models/challenge.dart';
import 'DatabaseHelper.dart';
import '../controllers/ChallengeController.dart';
import 'package:healthhero/data/SettingsHelper.dart';
import 'package:healthhero/models/setting.dart';

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
        progress: Challenge.stringToProgressMap(maps[i]['progress']),
        userProgress: maps[i]['userProgress'],
      );
    });
  }

  static Future<List<Challenge>> getUniqueChallenges() async {
    final Database db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('challenges', distinct: true, groupBy: 'title');
    return List.generate(maps.length, (i) {
      return Challenge(
        id: maps[i]['id'],
        date: DateTime.parse(maps[i]['date']),
        title: maps[i]['title'],
        description: maps[i]['description'],
        explanation: maps[i]['explanation'],
        category: maps[i]['category'],
        progress: Challenge.stringToProgressMap(maps[i]['progress']),
        userProgress: maps[i]['userProgress'],
      );
    });
  }

  static Future<void> increaseUserProgress(int id) async {
    final Database db = await DatabaseHelper.database;
    List<Challenge> challenges = await getChallenges();
    Challenge currentChallenge =
        challenges.firstWhere((challenge) => challenge.id == id);
    if (currentChallenge.userProgress < currentChallenge.progress.length) {
      await db.rawUpdate('''
        UPDATE challenges 
        SET userProgress = userProgress + 1 
        WHERE id = ?
      ''', [id]);
    }
  }

  static Future<void> decreaseUserProgress(int id) async {
    final Database db = await DatabaseHelper.database;
    List<Challenge> challenges = await getChallenges();
    Challenge currentChallenge =
        challenges.firstWhere((challenge) => challenge.id == id);
    if (currentChallenge.userProgress > 0) {
      await db.rawUpdate('''
        UPDATE challenges 
        SET userProgress = userProgress - 1 
        WHERE id = ?
      ''', [id]);
    }
  }

  static Future<List<Challenge>> getDailyChallenges(
      DateTime currentDate) async {
    List<Challenge> existingChallenges = await getChallenges();
    List<Setting> settings = await SettingHelper.getSettings();
    Setting setting = settings[0];
    int dailyChallenges = setting.dailyChallenges;
    List<Challenge> todayChallenges = existingChallenges
        .where((challenge) =>
            challenge.date.year == currentDate.year &&
            challenge.date.month == currentDate.month &&
            challenge.date.day == currentDate.day)
        .toList();
    while (todayChallenges.length < dailyChallenges) {
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
