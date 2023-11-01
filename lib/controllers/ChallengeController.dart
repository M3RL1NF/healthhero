import 'package:healthhero/data/ChallengeHelper.dart';
import 'package:healthhero/data/SettingsHelper.dart';
import 'package:healthhero/models/setting.dart';
import 'package:healthhero/models/challenge.dart';

class ChallengeController {
  static Future<void> generateDailyChallenges(DateTime currentDate) async {
    List<Challenge> existingChallenges = await ChallengeHelper.getChallenges();
    List<Setting> settings = await SettingHelper.getSettings();

    if (settings.isNotEmpty) {
      Setting setting = settings[0];

      int dailyChallenges = setting.dailyChallenges;
      List<Challenge> uniqueChallenges = [];

      int maxId = existingChallenges.isNotEmpty
          ? existingChallenges.map((challenge) => challenge.id).reduce((a, b) => a > b ? a : b)
          : 0;

      int id = maxId + 1;

      var titles = <String>{};

      for (int i = 0; i < dailyChallenges; i++) {
        Challenge existingChallenge = existingChallenges[i % existingChallenges.length];
        String uniqueTitle = '${existingChallenge.title} $i';
        while (titles.contains(uniqueTitle)) {
          i++;
          uniqueTitle = '${existingChallenge.title} $i';
        }
        titles.add(uniqueTitle);

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
      }

      for (var challenge in uniqueChallenges) {
        await ChallengeHelper.createChallenge(challenge);
      }
    }
  }
}
