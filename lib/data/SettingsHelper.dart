import 'package:sqflite/sqflite.dart';
import '../models/setting.dart';
import 'DatabaseHelper.dart';

class SettingDBHelper {
  static const String tableName = 'settings';

  static Future<int> insertSetting(Setting setting) async {
    final Database db = await DatabaseHelper.database;
    return await db.insert(tableName, setting.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
