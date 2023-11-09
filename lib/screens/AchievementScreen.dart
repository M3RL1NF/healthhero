import 'package:flutter/material.dart';
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
  int _sortColumnIndex = 0;
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _challengesFuture = ChallengeHelper.getChallenges();
  }

  void _sort<T>(Comparable<T> Function(Challenge challenge) getField,
      int columnIndex, bool isAscending) {
    _challengesFuture.then((challenges) {
      challenges.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return isAscending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
      setState(() {
        _sortColumnIndex = columnIndex;
        _isAscending = isAscending;
      });
    });
  }

  Widget _buildTable(List<Challenge> challenges) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          headingRowHeight: 60,
          columnSpacing: 10,
          horizontalMargin: 10,
          dataRowMaxHeight: 85,
          sortAscending: _isAscending,
          sortColumnIndex: _sortColumnIndex,
          columns: <DataColumn>[
            DataColumn(
              label: const Expanded(
                flex: 2,
                child: Text('Challenge'),
              ),
              onSort: (columnIndex, _) {
                _sort((Challenge challenge) => challenge.title, columnIndex,
                    !_isAscending);
              },
            ),
            DataColumn(
              label: const Expanded(
                child: Text('Kategorie'),
              ),
              onSort: (columnIndex, _) {
                _sort((Challenge challenge) => challenge.category,
                    columnIndex, !_isAscending);
              },
            ),
            DataColumn(
              label: const Expanded(
                flex: 1,
                child: Text('Fortschritt'),
              ),
              onSort: (columnIndex, _) {
                _sort((Challenge challenge) => challenge.userProgress,
                    columnIndex, !_isAscending);
              },
            ),
          ],
          rows: List<DataRow>.generate(
            challenges.length,
            (index) {
              final Challenge challenge = challenges[index];
              return DataRow(
                cells: [
                  DataCell(
                    Text(challenge.title),
                  ),
                  DataCell(
                    Text(challenge.category),
                  ),
                  DataCell(
                    Text(
                        '${challenge.userProgress}/${challenge.progress.length}'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPieChartCompletion(
      int completedChallenges, int incompletedChallenges) {
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

    return PieChart(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Errungenschaften'),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(
                text: 'Tabelle',
              ),
              Tab(
                text: 'Diagramm'
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<Challenge>>(
                    future: _challengesFuture,
                    builder: (context, snapshot) {
                      // Your existing FutureBuilder logic here
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No challenges found.'));
                      }
                      return _buildTable(snapshot
                          .data!); // Replace this with your actual table building code
                    },
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<Challenge>>(
                      future: _challengesFuture,
                      builder: (context, snapshot) {
                        // Re-use the FutureBuilder logic for pie charts
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No challenges found.'));
                        }
            
                        int completedChallenges = snapshot.data!
                            .where((challenge) =>
                                challenge.userProgress ==
                                challenge.progress.length)
                            .length;
                        int incompletedChallenges =
                            snapshot.data!.length - completedChallenges;
                        int sportChallenges = snapshot.data!
                            .where((challenge) => challenge.category == 'Sport')
                            .length;
                        int nutritionChallenges = snapshot.data!
                            .where(
                                (challenge) => challenge.category == 'Nutrition')
                            .length;
            
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildPieChartCompletion(
                                completedChallenges, incompletedChallenges),
                            _buildPieChartCategory(
                                sportChallenges, nutritionChallenges),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
