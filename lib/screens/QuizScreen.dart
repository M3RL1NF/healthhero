import 'package:flutter/material.dart';
import 'package:healthhero/data/QuizHelper.dart';
import '../models/quiz.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  int? selectedAnswer;
  bool isSubmitting = false;

  Future<Quiz?> _getDailyQuiz() async {
    DateTime yesterdayDate = DateTime.now();
    Quiz? dailyQuiz = await QuizHelper.getDailyQuiz(yesterdayDate);
    return dailyQuiz;
  }

  void _onAnswerSelected(int? answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  void _onSubmit(int quizId, int userAnswer) {
    if (selectedAnswer != null) {
      setState(() {
        isSubmitting = true;
      });
      QuizHelper.updateQuizAnswer(quizId, userAnswer.toInt());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tägliches Quiz'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: FutureBuilder<Quiz?>(
          future: _getDailyQuiz(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              Quiz? quiz = snapshot.data;
              if (quiz != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text(quiz.question),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxListTile(
                            title: Text(quiz.optionA),
                            value: selectedAnswer == 1,
                            onChanged: (_) => _onAnswerSelected(1),
                          ),
                          CheckboxListTile(
                            title: Text(quiz.optionB),
                            value: selectedAnswer == 2,
                            onChanged: (_) => _onAnswerSelected(2),
                          ),
                          CheckboxListTile(
                            title: Text(quiz.optionC),
                            value: selectedAnswer == 3,
                            onChanged: (_) => _onAnswerSelected(3),
                          ),
                          CheckboxListTile(
                            title: Text(quiz.optionD),
                            value: selectedAnswer == 4,
                            onChanged: (_) => _onAnswerSelected(4),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: isSubmitting ? null : () => _onSubmit(quiz.id, selectedAnswer!),
                      child: const Text('Submit'),
                    ),
                  ],
                );
              } else {
                return const Text('No quiz found for today.');
              }
            } else {
              return const Text('No data found');
            }
          },
        ),
      ),
    );
  }
}