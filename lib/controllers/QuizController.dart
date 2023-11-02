import 'dart:math';
import 'package:healthhero/models/quiz.dart';
import 'package:healthhero/data/QuizHelper.dart';

class QuizController {
  static Future<void> generateDailyQuiz(DateTime currentDate) async {
    List<Quiz> existingQuizzes = await QuizHelper.getQuizzes();
    List<Quiz> uniqueQuizzes = [];

    int maxId = existingQuizzes.isNotEmpty
        ? existingQuizzes.map((quiz) => quiz.id).reduce((a, b) => a > b ? a : b)
        : 0;

    int id = maxId + 1;

    if (existingQuizzes.isNotEmpty) {
      final random = Random();
      int randomIndex = random.nextInt(existingQuizzes.length);
      Quiz existingQuiz = existingQuizzes[randomIndex];
      Quiz newQuiz = Quiz(
        id: id,
        date: currentDate,
        question: existingQuiz.question,
        optionA: existingQuiz.optionA,
        optionB: existingQuiz.optionB,
        optionC: existingQuiz.optionC,
        optionD: existingQuiz.optionD,
        solution: existingQuiz.solution,
        answer: null,
      );
      uniqueQuizzes.add(newQuiz);
    }

    for (var quiz in uniqueQuizzes) {
      await QuizHelper.createQuiz(quiz);
    }
  }
}
