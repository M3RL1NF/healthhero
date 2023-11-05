import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:healthhero/models/challenge.dart';
import '../data/ChallengeHelper.dart';
import 'package:pie_chart/pie_chart.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({Key? key}) : super(key: key);

  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  late Future<List<Challenge>> _challengesFuture;
  bool _isTableVisible = true;
  int _sortColumnIndex = 0;
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _challengesFuture = ChallengeHelper.getChallenges();
  }

  void _sort<T>(
      Comparable<T> Function(Challenge challenge) getField, int columnIndex, bool isAscending) {
    _challengesFuture.then((challenges) {
      challenges.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return isAscending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
      });
      setState(() {
        _sortColumnIndex = columnIndex;
        _isAscending = isAscending;
      });
    });
  }

  Widget _buildTable(List<Challenge> challenges) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DataTable(
            headingRowHeight: 60,
            dataRowHeight: 50,
            columnSpacing: 10,
            horizontalMargin: 10,
            sortAscending: _isAscending,
            sortColumnIndex: _sortColumnIndex,
            columns: <DataColumn>[
              DataColumn(
                label: const Expanded(
                  child: Text('Date'),
                ),
                onSort: (columnIndex, _) {
                  _sort((Challenge challenge) => challenge.date, columnIndex, !_isAscending);
                },
              ),
              DataColumn(
                label: const Expanded(
                  flex: 2,
                  child: Text('Title'),
                ),
                onSort: (columnIndex, _) {
                  _sort((Challenge challenge) => challenge.title, columnIndex, !_isAscending);
                },
              ),
              DataColumn(
                label: const Expanded(
                  child: Text('Category'),
                ),
                onSort: (columnIndex, _) {
                  _sort((Challenge challenge) => challenge.category, columnIndex, !_isAscending);
                },
              ),
              DataColumn(
                label: const Expanded(
                  flex: 1,
                  child: Text('Fortschritt'),
                ),
                onSort: (columnIndex, _) {
                  _sort((Challenge challenge) => challenge.userProgress, columnIndex, !_isAscending);
                },
              ),
            ],
            rows: List<DataRow>.generate(
              challenges.length,
              (index) {
                final Challenge challenge = challenges[index];
                final formattedDate = DateFormat('yyyy-MM-dd').format(challenge.date);
                return DataRow(
                  cells: [
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(formattedDate),
                      ),
                    ),
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(challenge.title),
                      ),
                    ),
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(challenge.category),
                      ),
                    ),
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('${challenge.userProgress}/${challenge.progress.length}'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPieChartCompletion(int completedChallenges, int incompletedChallenges) {
    Map<String, double> dataMap = {
      "Abgeschlossene Challenges": completedChallenges.toDouble(),
      "Offene Challenges": incompletedChallenges.toDouble(),
    };

    List<Color> colorList = [
      Theme.of(context).primaryColor,
      const Color.fromARGB(255, 135, 135, 135),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: PieChart(
        dataMap: dataMap,
        colorList: colorList,
        chartType: ChartType.ring,
        chartRadius: MediaQuery.of(context).size.width / 2.7,
        legendOptions: const LegendOptions(
          showLegendsInRow: true,
          legendPosition: LegendPosition.bottom,
          showLegends: true,
          legendTextStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildPieChartCategory(int sportChallenges, int nutritionChallenges) {
    Map<String, double> dataMap = {
      "Sport": sportChallenges.toDouble(),
      "Ernährung": nutritionChallenges.toDouble(),
    };

    List<Color> colorList = [
      Theme.of(context).primaryColor,
      const Color.fromARGB(255, 135, 135, 135),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: PieChart(
        dataMap: dataMap,
        colorList: colorList,
        chartType: ChartType.ring,
        chartRadius: MediaQuery.of(context).size.width / 2.7,
        legendOptions: const LegendOptions(
          showLegendsInRow: true,
          legendPosition: LegendPosition.bottom,
          showLegends: true,
          legendTextStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildAlternativeView(List<Challenge> challenges) {
    int completedChallenges = challenges.where((challenge) => challenge.userProgress == challenge.progress.length).length;
    int incompletedChallenges = challenges.where((challenge) => challenge.userProgress < challenge.progress.length).length;

    int sportChallenges = challenges.where((challenge) => challenge.category == 'Sport').length;
    int nutritionChallenges = challenges.where((challenge) => challenge.category == 'Nutrition').length;

    return Column(
      children: [
        _buildPieChartCompletion(completedChallenges, incompletedChallenges),
        const SizedBox(height: 20),
        _buildPieChartCategory(sportChallenges, nutritionChallenges),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Errungenschaften'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 0), // Increased the top padding to 40
              child: Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isTableVisible = true;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: _isTableVisible ? Colors.transparent : null,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: _isTableVisible ? Theme.of(context).primaryColor : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Text(
                          'Tabelle',
                          style: TextStyle(
                            color: _isTableVisible
                                ? Theme.of(context).textTheme.bodyLarge!.color
                                : Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isTableVisible = false;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: !_isTableVisible ? Colors.transparent : null,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: !_isTableVisible ? Theme.of(context).primaryColor : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Text(
                          'Graph',
                          style: TextStyle(
                            color: !_isTableVisible
                                ? Theme.of(context).textTheme.bodyLarge!.color
                                : Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _isTableVisible
                ? FutureBuilder<List<Challenge>>(
                    future: _challengesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _buildTable(snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                : FutureBuilder<List<Challenge>>(
                    future: _challengesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _buildAlternativeView(snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
