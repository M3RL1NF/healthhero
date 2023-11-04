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
      int maxId = existingChallenges.isNotEmpty
          ? existingChallenges
              .map((challenge) => challenge.id)
              .reduce((a, b) => a > b ? a : b)
          : 0;
      int id = maxId + 1;
      var existingTitles = todayChallenges.map((challenge) => challenge.title).toSet();
      int loopCounter = todayChallenges.length;
      for (int i = 0; loopCounter < dailyChallenges; i++) {
        Challenge existingChallenge = existingChallenges[loopCounter % existingChallenges.length];
        String uniqueTitle = existingChallenge.title;
        while (existingTitles.contains(uniqueTitle)) {
          loopCounter++;
          existingChallenge = existingChallenges[loopCounter % existingChallenges.length];
          uniqueTitle = existingChallenge.title;
        }
        existingTitles.add(uniqueTitle);
        Challenge newChallenge = Challenge(
          id: id,
          date: currentDate,
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
