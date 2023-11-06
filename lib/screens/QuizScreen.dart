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
  bool isCorrect = false;
  bool isIncorrect = false;
  bool isQuizAnswered = false; // Track if the quiz is answered
  DateTime currentDate = DateTime.now();

  Future<Quiz?> _getDailyQuiz(DateTime date) async {
    Quiz? dailyQuiz = await QuizHelper.getDailyQuiz(date);
    return dailyQuiz;
  }

  void _onAnswerSelected(int? answer) {
    setState(() {
      if (selectedAnswer != answer) {
        selectedAnswer = answer;
        isCorrect = false;
        isIncorrect = false;
      }
    });
  }

  void _clearMessages() {
    setState(() {
      isCorrect = false;
      isIncorrect = false;
    });
  }

  void _onSubmit(int quizId, int userAnswer, int correctAnswer) {
    if (selectedAnswer != null) {
      _clearMessages();
      setState(() {
        isCorrect = userAnswer == correctAnswer;
        isIncorrect = userAnswer != correctAnswer;
        isQuizAnswered = true; // Quiz is answered, disable the button and checkboxes
      });
      QuizHelper.updateQuizAnswer(quizId, userAnswer);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != currentDate) {
      final Quiz? updatedQuiz = await _getDailyQuiz(picked);
      if (updatedQuiz != null) {
        setState(() {
          currentDate = picked;
          if (updatedQuiz.answer == null) {
            _clearMessages();
            selectedAnswer = null;
            isQuizAnswered = false; // Reset the quiz answered status
          }
        });
      }
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
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentDate = currentDate.subtract(const Duration(days: 1));
                        _clearMessages();
                        selectedAnswer = null;
                        isQuizAnswered = false; 
                      });
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  GestureDetector(
                    onTap: () {
                      _clearMessages();
                      _selectDate(context);
                    },
                    child: Text(
                      "${currentDate.toLocal()}".split(' ')[0],
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentDate = currentDate.add(const Duration(days: 1));
                        _clearMessages();
                        selectedAnswer = null;
                        isQuizAnswered = false; 
                      });
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              FutureBuilder<Quiz?>(
                future: _getDailyQuiz(currentDate),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    Quiz? quiz = snapshot.data;
                    if (quiz != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz.question,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.leading,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: Text(quiz.optionA),
                                value: selectedAnswer == 1,
                                onChanged: isQuizAnswered ? null : (_) => _onAnswerSelected(1),
                              ),
                              CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.leading,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                title: Text(quiz.optionB),
                                value: selectedAnswer == 2,
                                onChanged: isQuizAnswered ? null : (_) => _onAnswerSelected(2),
                              ),
                              CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.leading,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                title: Text(quiz.optionC),
                                value: selectedAnswer == 3,
                                onChanged: isQuizAnswered ? null : (_) => _onAnswerSelected(3),
                              ),
                              CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.leading,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                title: Text(quiz.optionD),
                                value: selectedAnswer == 4,
                                onChanged: isQuizAnswered ? null : (_) => _onAnswerSelected(4),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: isQuizAnswered
                                ? null
                                : () => _onSubmit(quiz.id, selectedAnswer!, quiz.solution),
                            child: const Text('Bestätigen'),
                          ),
                          if (isCorrect)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 164, 255, 167),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Sehr gut! Das ist die richtige Antwort.',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (isIncorrect)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 152, 145),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Oops! Das ist leider die falsche Antwort.',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
