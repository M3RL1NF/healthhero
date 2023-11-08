import 'package:flutter/material.dart';
import 'package:healthhero/data/ChallengeHelper.dart';
import '../models/challenge.dart';
import '../theme/custom_themes/color_theme.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  late Future<List<Challenge>> _dailyChallenges;
  DateTime currentDate = DateTime.now();

  // Create a list of month names
  final List<String> monthNames = [
    'Januar',
    'Februar',
    'März',
    'April',
    'Mai',
    'Juni',
    'Juli',
    'August',
    'September',
    'Oktober',
    'November',
    'Dezember'
  ];

  @override
  void initState() {
    super.initState();
    _refreshChallenges();
  }

  Future<void> _refreshChallenges() async {
    setState(() {
      _dailyChallenges = _getDailyChallenges();
    });
  }

  Future<List<Challenge>> _getDailyChallenges() async {
    List<Challenge> dailyChallenges =
        await ChallengeHelper.getDailyChallenges(currentDate);
    return dailyChallenges;
  }

  Widget _getCategoryIconWidget(String category) {
    if (category == 'Sport') {
      return const Icon(Icons.sports_handball);
    } else if (category == 'Nutrition') {
      return const Icon(Icons.restaurant);
    } else {
      return const Icon(Icons.category);
    }
  }

  Widget _getStepValues(Map<int, String> progress) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: progress.length == 1
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (progress.length == 1)
                    const Text(
                      '0',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ...progress.entries.map((entry) {
                    return Text(
                      entry.value,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSlider() {
    // Use the monthNames list to convert the month number to a string
    String monthName = monthNames[currentDate.month - 1];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              currentDate = currentDate.subtract(const Duration(days: 1));
              _refreshChallenges();
            });
          },
          icon: const Icon(Icons.arrow_back),
          color: lightPrimaryColor400,
        ),
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Text(
            // Update the display to use the month name
            "${currentDate.day}. $monthName ${currentDate.year}",
            style: const TextStyle(fontSize: 20),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              currentDate = currentDate.add(const Duration(days: 1));
              _refreshChallenges();
            });
          },
          icon: const Icon(Icons.arrow_forward),
          color: lightPrimaryColor400,
        ),
      ],
    );
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
        _refreshChallenges();
      });
    }
  }

  Widget _buildChallengeTitle(String title) {
    return Flexible(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tägliche Challenges')),
      body: Column(
        children: [
          const SizedBox(height: 40),
          _buildDateSlider(),
          Expanded(
            child: Center(
              child: FutureBuilder<List<Challenge>>(
                future: _dailyChallenges,
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 0),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: challenge.userProgress ==
                                        challenge.progress.length
                                    ? lightPrimaryColor400
                                    : Colors.grey,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 10.0),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildChallengeTitle(challenge.title),
                                  _getCategoryIconWidget(challenge.category),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  LinearProgressIndicator(
                                    value: challenge.userProgress /
                                        challenge.progress.length,
                                        color: lightPrimaryColor400,
                                    minHeight: 10,
                                  ),
                                  _getStepValues(challenge.progress),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          await ChallengeHelper
                                              .decreaseUserProgress(
                                                  challenge.id);
                                          _refreshChallenges();
                                        },
                                        icon: const Icon(Icons.remove),
                                        color: lightPrimaryColor400,
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () async {
                                          await ChallengeHelper
                                              .increaseUserProgress(
                                                  challenge.id);
                                          _refreshChallenges();
                                        },
                                        icon: const Icon(Icons.add),
                                        color: lightPrimaryColor400,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
          ),
        ],
      ),
    );
  }
}
