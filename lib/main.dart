import 'package:flutter/material.dart';
import 'screens/LearnScreen.dart';
import 'screens/ChallengeScreen.dart';
import 'screens/QuizScreen.dart';
import 'screens/SettingScreen.dart';
import 'screens/AchievementScreen.dart';
import 'package:healthhero/data/DatabaseHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await DatabaseHelper.initDatabase();
  await DatabaseHelper.seedDatabase(database);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Hero',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(255, 33, 243, 191),
        primarySwatch: const MaterialColor(0xFF21F3BF, {
          50: Color(0xFFE0F7F2),
          100: Color(0xFFB3F0E4),
          200: Color(0xFF80E9D4),
          300: Color(0xFF4DE2C5),
          400: Color(0xFF26DDB9),
          500: Color(0xFF21F3BF),
          600: Color(0xFF0FC29A),
          700: Color(0xFF0A9B7A),
          800: Color(0xFF07735A),
          900: Color(0xFF055D46),
        }),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(const Color.fromARGB(255, 33, 243, 191)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color?>(const Color.fromARGB(255, 33, 243, 191)),
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MyBottomNavigationBar(),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  MyBottomNavigationBarState createState() => MyBottomNavigationBarState();
}

class MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const LearnScreen(key: Key('learn')),
    const QuizScreen(key: Key('quiz')),
    const ChallengeScreen(key: Key('challenge')),
    const AchievementScreen(key: Key('achievement')),
    const SettingScreen(key: Key('setting')),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ?? Colors.white,
        title: const Text('HEALTH HERO'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Lernzentrum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Challenges',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Achievements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
