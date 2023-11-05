import 'package:flutter/material.dart';
import 'package:healthhero/data/ChallengeHelper.dart';
import '../models/challenge.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  late Future<List<Challenge>> _dailyChallenges;
  DateTime currentDate = DateTime.now();

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: progress.entries.map((entry) {
                  return Text(
                    '${entry.value}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSlider() {
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
              _refreshChallenges();
            });
          },
          icon: const Icon(Icons.arrow_forward),
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
      appBar: AppBar(
        title: const Text('Tägliche Challenges'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
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
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: challenge.userProgress == challenge.progress.length
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    value: challenge.userProgress / challenge.progress.length,
                                    minHeight: 10,
                                  ),
                                  _getStepValues(challenge.progress),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(width: 0),
                                      IconButton(
                                        onPressed: () async {
                                          await ChallengeHelper.decreaseUserProgress(challenge.id);
                                          _refreshChallenges();
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () async {
                                          await ChallengeHelper.increaseUserProgress(challenge.id);
                                          _refreshChallenges();
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                      const SizedBox(width: 0),
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
