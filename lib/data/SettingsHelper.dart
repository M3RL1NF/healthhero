import 'package:sqflite/sqflite.dart';
import '../models/setting.dart';
import 'DatabaseHelper.dart';

class SettingHelper {
  static const String tableName = 'settings';

  static Future<List<Setting>> getSettings() async {
    final Database db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return Setting(
        categorySport: maps[i]['categorySport'] == 1,
        categoryNutrition: maps[i]['categoryNutrition'] == 1,
        userName: maps[i]['userName'],
        userDateOfBirth: DateTime.parse(maps[i]['userDateOfBirth']),
        userGender: maps[i]['userGender'],
        readAGB: maps[i]['readAGB'] == 1,
        readDSGVO: maps[i]['readDSGVO'] == 1,
        dailyQuizzes: maps[i]['dailyChallenges'],
        dailyChallenges: maps[i]['dailyChallenges'],
      );
    });
  }

  static Future<int> updateSetting(Setting setting) async {
    final Database db = await DatabaseHelper.database;
    return await db.update(
      tableName,
      setting.toMap(),
    );
  }
}
