import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'your_database_name.db'),
      onCreate: (db, version) async {
        // Create tables
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
            solution TEXT,
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
      },
      version: 1,
    );
  }
}
