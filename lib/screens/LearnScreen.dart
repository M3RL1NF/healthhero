import 'package:flutter/material.dart';
import 'package:healthhero/data/ChallengeHelper.dart';
import 'package:healthhero/models/challenge.dart';
import '../theme/custom_themes/color_theme.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  late List<Challenge> challenges = [];
  late String selectedCategory;
  final Map<String, String> categoryDisplayNames = {
    'Sport': 'Sport',
    'Nutrition': 'Ernährung',
  };

  @override
  void initState() {
    super.initState();
    selectedCategory =
        "Sport"; // The initial category must match one of the keys in the mapping
    fetchChallenges();
  }

  Future<void> fetchChallenges() async {
    challenges = await ChallengeHelper.getUniqueChallenges();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPrimaryColor400,
      appBar: AppBar(
        title: const Text('Lernzentrum'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: lightAppBarTextColor,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                child: DropdownButton<String>(
                  value: selectedCategory,
                  items: categoryDisplayNames.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      if (newValue != null) {
                        selectedCategory = newValue;
                        fetchChallenges();
                      }
                    });
                  },
                  underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down,
                      color: lightPrimaryColor400),
                  dropdownColor: lightAppBarTextColor,
                  style: const TextStyle(
                      color: lightPrimaryTextColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: challenges.length,
              itemBuilder: (context, index) {
                final challenge = challenges[index];
                if (challenge.category == selectedCategory) {
                  return Card(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(12.0), // Padding inside the card
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Align text to the start of the cardS
                        children: [
                          Text(
                            challenge.title,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(
                              height:
                                  8.0), // Space between title and description
                          Text(
                            challenge.description,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
