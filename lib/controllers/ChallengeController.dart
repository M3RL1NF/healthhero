import 'dart:math';
import 'package:healthhero/data/ChallengeHelper.dart';
import 'package:healthhero/data/SettingsHelper.dart';
import 'package:healthhero/models/setting.dart';
import 'package:healthhero/models/challenge.dart';

class ChallengeController {
  static Future<void> generateDailyChallenges(DateTime currentDate) async {
    List<Challenge> existingChallenges = await ChallengeHelper.getChallenges();
    List<Setting> settings = await SettingHelper.getSettings();
    List<Challenge> todayChallenges = existingChallenges
        .where((challenge) =>
            challenge.date.year == currentDate.year &&
            challenge.date.month == currentDate.month &&
            challenge.date.day == currentDate.day)
        .toList();
    if (settings.isNotEmpty) {
      Setting setting = settings[0];
      int dailyChallenges = setting.dailyChallenges;
      List<Challenge> uniqueChallenges = [];
      var existingTitles =
          todayChallenges.map((challenge) => challenge.title).toSet();
      Set<String> existingDates =
          todayChallenges.map((challenge) => challenge.date.toString()).toSet();
      int maxId = existingChallenges.isNotEmpty
          ? existingChallenges
              .map((challenge) => challenge.id)
              .reduce((a, b) => a > b ? a : b)
          : 0;
      int id = maxId + 1;
      int loopCounter = todayChallenges.length;
      var random = Random();
      for (int i = 0; loopCounter < dailyChallenges; i++) {
        int randomIndex = random.nextInt(existingChallenges.length);
        Challenge existingChallenge = existingChallenges[randomIndex];
        String uniqueTitle = existingChallenge.title;
        String uniqueDate = currentDate.toString();
        int attemptCounter = 0;
        while (existingTitles.contains(uniqueTitle)) {
          loopCounter++;
          randomIndex = random.nextInt(existingChallenges.length);
          existingChallenge = existingChallenges[randomIndex];
          uniqueTitle = existingChallenge.title;
          if (currentDate.isBefore(DateTime.now())) {
            uniqueDate =
                currentDate.subtract(Duration(days: attemptCounter)).toString();
          } else {
            uniqueDate = currentDate.toString();
          }
          attemptCounter++;
        }
        existingTitles.add(uniqueTitle);
        existingDates.add(uniqueDate);
        Challenge newChallenge = Challenge(
          id: id,
          date: DateTime.parse(uniqueDate),
          title: uniqueTitle,
          description: existingChallenge.description,
          explanation: existingChallenge.explanation,
          category: existingChallenge.category,
          progress: existingChallenge.progress,
          userProgress: 0,
        );
        uniqueChallenges.add(newChallenge);
        id++;
        loopCounter++;
      }
      for (var challenge in uniqueChallenges) {
        await ChallengeHelper.createChallenge(challenge);
      }
    }
  }
}
