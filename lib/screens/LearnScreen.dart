import 'package:flutter/material.dart';
import 'package:healthhero/data/ChallengeHelper.dart';
import 'package:healthhero/models/challenge.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  late List<Challenge> challenges = [];
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    fetchChallenges();
    selectedCategory = "Sport";
  }

  Future<void> fetchChallenges() async {
    challenges = await ChallengeHelper.getUniqueChallenges();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lernzentrum'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedCategory,
            items: <String>['Sport', 'Nutrition'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
          ),
          Expanded(
            child: ListView(
              children: challenges
                  .where((challenge) => challenge.category == selectedCategory)
                  .map((challenge) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        challenge.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          challenge.description,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                );

              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
