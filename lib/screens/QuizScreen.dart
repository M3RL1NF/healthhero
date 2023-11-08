import 'package:flutter/material.dart';
import 'package:healthhero/data/QuizHelper.dart';
import 'package:healthhero/theme/custom_themes/color_theme.dart';
import '../models/quiz.dart';

  // List of month names
  final List<String> monthNames = [
    'Januar', 'Februar', 'März', 'April', 'Mai', 'Juni',
    'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'
  ];

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  late Future<Quiz?> dailyQuizFuture;
  DateTime currentDate = DateTime.now();
  String? result;

  Future<Quiz?> fetchDailyQuiz() async {
    final quiz = await QuizHelper.getDailyQuiz(currentDate);
    return quiz;
  }

  void updateQuizAnswer(int quizId, int answer, Quiz dailyQuiz) {
    QuizHelper.updateQuizAnswer(quizId, answer);
    String message = dailyQuiz.solution == answer
        ? 'Sehr gut! Das ist die richtige Antwort!'
        : 'Opps! Leider Falsch!';
    setState(() => result = message);
  }

  @override
  void initState() {
    super.initState();
    dailyQuizFuture = fetchDailyQuiz();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != currentDate) {
      setState(() {
        currentDate = picked;
        dailyQuizFuture = fetchDailyQuiz();
        result = null; // Reset result on date change
      });
    }
  }

  Widget _buildDateSlider(String monthName, VoidCallback onPreviousDay, VoidCallback onNextDay, VoidCallback onDateTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPreviousDay,
          icon: const Icon(Icons.arrow_back),
          color: lightPrimaryColor400,
        ),
        GestureDetector(
          onTap: onDateTap,
          child: Text(
            "${currentDate.day}. $monthName ${currentDate.year}",
            style: const TextStyle(fontSize: 20),
          ),
        ),
        IconButton(
          onPressed: onNextDay,
          icon: const Icon(Icons.arrow_forward),
          color: lightPrimaryColor400,
        ),
      ],
    );
  }

List<Widget> _buildOptionList(Quiz dailyQuiz, Function(int) onOptionSelected) {
  return List<Widget>.generate(4, (index) {
    final options = [dailyQuiz.optionA, dailyQuiz.optionB, dailyQuiz.optionC, dailyQuiz.optionD];
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: CheckboxListTile(
        title: Text(options[index]),
        value: dailyQuiz.answer == index + 1,
        onChanged: (bool? value) => onOptionSelected(index + 1),
        activeColor: lightPrimaryColor400,
        checkColor: Colors.white,
        checkboxShape: const CircleBorder(eccentricity: 1),
      ),
    );
  });
}

  Widget _buildResult() {
    if (result == null) return const SizedBox.shrink();
    bool isCorrect = result == 'Sehr gut! Das ist die richtige Antwort!';
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Text(
          result!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isCorrect ? Colors.green : const Color.fromARGB(255, 255, 42, 27),
      
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Quiz')),
      body: FutureBuilder<Quiz?>(
        future: dailyQuizFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          Quiz? dailyQuiz = snapshot.data;
          if (dailyQuiz == null) {
            return const Center(child: Text('No quiz available for today.'));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
            child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                _buildDateSlider(
                  monthNames[currentDate.month - 1],
                  () => setState(() {
                    currentDate = currentDate.subtract(const Duration(days: 1));
                    dailyQuizFuture = fetchDailyQuiz();
                    result = null;
                  }),
                  () => setState(() {
                    currentDate = currentDate.add(const Duration(days: 1));
                    dailyQuizFuture = fetchDailyQuiz();
                    result = null;
                  }),
                  () => _selectDate(context),
                ),
                const SizedBox(height: 20),
                Text(
                  dailyQuiz.question,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ..._buildOptionList(dailyQuiz, (int selectedOption) {
                  setState(() {
                    dailyQuiz.answer = selectedOption;
                  });
                }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (dailyQuiz.answer != null) {
                      updateQuizAnswer(dailyQuiz.id, dailyQuiz.answer!, dailyQuiz);
                    }
                  },
                  child: const Text('Bestätigen'),
                ),
                _buildResult(),
              ],
            ),
          );
        },
      ),
    );
  }
}