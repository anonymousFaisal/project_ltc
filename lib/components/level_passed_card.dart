import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// A widget to visualize levels passed by users using a pie chart.
class LevelPassedCard extends StatefulWidget {
  const LevelPassedCard({Key? key}) : super(key: key);

  @override
  _LevelPassedCardState createState() => _LevelPassedCardState();
}

class _LevelPassedCardState extends State<LevelPassedCard> {

  // Some static values for testing
  int totalBeginner = 10;
  int completedBeginner = 5;

  int totalIntermediate = 10;
  int completedIntermediate = 4;

  int totalAdvanced = 10;
  int completedAdvanced = 9;

  late int totalLevels;

  @override
  void initState() {
    super.initState();
    // Calculating total levels
    totalLevels = totalBeginner + totalIntermediate + totalAdvanced;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Calculating percentage of completion for each category.
    double percentBeginner = (completedBeginner / totalLevels) * 100;
    double percentIntermediate = (completedIntermediate / totalLevels) * 100;
    double percentAdvanced = (completedAdvanced / totalLevels) * 100;
    double percentUncompleted =
        100 - (percentBeginner + percentIntermediate + percentAdvanced);

    return Container(
      height: 350,
      width: double.infinity,
      child: Card(
        color: theme.cardTheme.color,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Levels Passed",
                  style: TextStyle(
                    color: theme.colorScheme.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 16.0),
              Expanded(
                child: Row(
                  children: [
                    // The pie chart visualization.
                    Expanded(
                      flex: 2,
                      child: PieChart(
                        PieChartData(
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 0,
                          centerSpaceRadius: 50,
                          sections: _showingSections(
                            percentBeginner,
                            percentIntermediate,
                            percentAdvanced,
                            percentUncompleted,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildIndicators(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Generates data for each section in the pie chart.
  List<PieChartSectionData> _showingSections(double beginner,
      double intermediate, double advanced, double uncompleted) {
    const double fontSize = 14;
    const double radius = 60;

    return [
      PieChartSectionData(
        color: Colors.blue,
        value: beginner,
        title: '${beginner.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.yellow,
        value: intermediate,
        title: '${intermediate.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.grey,
        value: advanced,
        title: '${advanced.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: uncompleted,
        title: '${uncompleted.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    ];
  }

  List<Widget> _buildIndicators() {
    return [
      _Indicator(color: Colors.blue, text: 'Beginner'),
      _Indicator(color: Colors.yellow, text: 'Intermediate'),
      _Indicator(color: Colors.grey, text: 'Advanced'),
      _Indicator(color: Colors.red, text: 'Uncompleted'),
    ];
  }
}

// indicator class
class _Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const _Indicator({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(width: 16, height: 16, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
