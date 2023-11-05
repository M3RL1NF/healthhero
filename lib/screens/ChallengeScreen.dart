import 'package:flutter/material.dart';
import 'package:healthhero/data/ChallengeHelper.dart';
import '../models/challenge.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  Future<List<Challenge>> _getDailyChallenges() async {
    DateTime yesterdayDate = DateTime.now();
    List<Challenge> yesterdayChallenges = await ChallengeHelper.getDailyChallenges(yesterdayDate);
    return yesterdayChallenges;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tägliche Challenges'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Challenge>>(
          future: _getDailyChallenges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<Challenge> challenges = snapshot.data!;
              return ListView.builder(
                itemCount: challenges.length,
                itemBuilder: (context, index) {
                  Challenge challenge = challenges[index];
                  return ListTile(
                    title: Text(challenge.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: ${challenge.description}'),
                        Text('Explanation: ${challenge.explanation}'),
                        Text('Category: ${challenge.category}'),
                        Text('User Progress: ${challenge.userProgress}'),
                        Text('Date: ${challenge.date.toString()}'),
                        Text('Progress: ${challenge.progress.toString()}'),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                ChallengeHelper.increaseUserProgress(challenge.id);
                              },
                              child: const Text('Increase Progress'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                ChallengeHelper.decreaseUserProgress(challenge.id);
                              },
                              child: const Text('Decrease Progress'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Text('No data found');
            }
          },
        ),
      ),
    );
  }
}
