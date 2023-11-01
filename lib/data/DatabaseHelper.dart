import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:healthhero/utils/challenge_seeds.dart';
import 'package:healthhero/utils/quiz_seeds.dart';
import 'package:healthhero/utils/setting_seeds.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'your_database_name.db');
    return openDatabase(databasePath, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE challenges(
            id INTEGER PRIMARY KEY,
            date TEXT,
            title TEXT,
            description TEXT,
            explanation TEXT,
            category TEXT,
            progress TEXT,
            userProgress INTEGER
          )
        ''');
      await db.execute('''
          CREATE TABLE quizzes(
            id INTEGER PRIMARY KEY,
            date TEXT,
            question TEXT,
            optionA TEXT,
            optionB TEXT,
            optionC TEXT,
            optionD TEXT,
            solution INTEGER,
            answer TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE settings(
            id INTEGER PRIMARY KEY,
            categorySport INTEGER,
            categoryNutrition INTEGER,
            userName TEXT,
            userDateOfBirth TEXT,
            userGender TEXT,
            readAGB INTEGER,
            readDSGVO INTEGER
          )
        ''');
      await seedDatabase(db);
    });
  }

  static Future<void> seedDatabase(Database db) async {
  for (var challengeSeed in challengeSeeds) {
    await db.insert('challenges', challengeSeed);
  }

  for (var quizSeed in quizSeeds) {
    await db.insert('quizzes', quizSeed);
  }

  for (var settingSeed in settingSeeds) {
    await db.insert('settings', settingSeed);
  }
}
}

void main() async {
  final database = await DatabaseHelper.initDatabase();
  await DatabaseHelper.seedDatabase(database);
}
