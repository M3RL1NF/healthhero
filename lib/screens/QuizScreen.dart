import 'package:flutter/material.dart';
import 'package:healthhero/data/QuizHelper.dart';
import '../models/quiz.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  late Future<void> dailyQuizFuture;
  Quiz? dailyQuiz;
  int? selectedOption;
  DateTime currentDate = DateTime.now();
  String? result;

  Future<void> fetchDailyQuiz() async {
    final quiz = await QuizHelper.getDailyQuiz(currentDate);
    setState(() {
      dailyQuiz = quiz;
      selectedOption = dailyQuiz?.answer;
      result = null;
    });
  }

  void updateQuizAnswer(int quizId, int answer) {
    QuizHelper.updateQuizAnswer(quizId, answer);
    if (dailyQuiz != null && dailyQuiz!.solution == answer) {
      setState(() {
        result = 'Sehr gut! Das ist die richtige Antwort!';
      });
    } else {
      setState(() {
        result = 'Opps! Das ist leider nicht die richtige Antwort!';
      });
    }
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
        fetchDailyQuiz();
      });
    }
  }

  Widget _buildDateSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              currentDate = currentDate.subtract(const Duration(days: 1));
              fetchDailyQuiz();
            });
          },
          icon: const Icon(Icons.arrow_back),
        ),
        GestureDetector(
          onTap: () {
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
              fetchDailyQuiz();
            });
          },
          icon: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Quiz'),
      ),
      body: FutureBuilder<void>(
        future: dailyQuizFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (dailyQuiz == null) {
              return const Center(child: Text('No quiz available for today.'));
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDateSlider(),
                    Text(
                      dailyQuiz!.question,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    CheckboxListTile(
                      title: Text(dailyQuiz!.optionA),
                      value: selectedOption == 1,
                      onChanged: (bool? value) {
                        setState(() {
                          selectedOption = value! ? 1 : null;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(dailyQuiz!.optionB),
                      value: selectedOption == 2,
                      onChanged: (bool? value) {
                        setState(() {
                          selectedOption = value! ? 2 : null;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(dailyQuiz!.optionC),
                      value: selectedOption == 3,
                      onChanged: (bool? value) {
                        setState(() {
                          selectedOption = value! ? 3 : null;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(dailyQuiz!.optionD),
                      value: selectedOption == 4,
                      onChanged: (bool? value) {
                        setState(() {
                          selectedOption = value! ? 4 : null;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedOption != null) {
                          updateQuizAnswer(dailyQuiz!.id, selectedOption!);
                        }
                      },
                      child: const Text('Bestätigen'),
                    ),
                    if (result != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              result!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: result ==
                                        'Sehr gut! Das ist die richtige Antwort!'
                                    ? Colors.green
                                    : const Color.fromARGB(255, 255, 42, 27),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
