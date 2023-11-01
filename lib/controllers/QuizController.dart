import 'package:healthhero/models/quiz.dart';
import 'package:healthhero/models/setting.dart';
import 'package:healthhero/data/QuizHelper.dart';
import 'package:healthhero/data/SettingsHelper.dart';

class QuizController {
  static Future<void> generateDailyQuiz(DateTime currentDate) async {
    List<Quiz> existingQuizzes = await QuizHelper.getQuizzes();
    List<Setting> settings = await SettingHelper.getSettings();

    if (settings.isNotEmpty) {
      Setting setting = settings[0];

      int dailyQuizzes = setting.dailyQuizzes;
      List<Quiz> uniqueQuizzes = [];

      int maxId = existingQuizzes.isNotEmpty
          ? existingQuizzes.map((quiz) => quiz.id).reduce((a, b) => a > b ? a : b)
          : 0;

      int id = maxId + 1;

      for (int i = 0; i < dailyQuizzes; i++) {
        Quiz existingQuiz = existingQuizzes[i % existingQuizzes.length];
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
        id++;
      }

      for (var quiz in uniqueQuizzes) {
        await QuizHelper.createQuiz(quiz);
      }
    }
  }
}
