import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// widget that displays a card visualizing the time spent using line charts.
class TimeSpentCard extends StatefulWidget {
  const TimeSpentCard({super.key});

  @override
  State<TimeSpentCard> createState() => _TimeSpentCardState();
}

class _TimeSpentCardState extends State<TimeSpentCard> {
  // Gradient colors for line chart
  List<Color> gradientColors = [Colors.white, Colors.amber.shade900];
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Time Spent',
              style: TextStyle(
                color: theme.colorScheme.secondary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              // Main line chart display
              AspectRatio(
                aspectRatio: 1.60,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 18,
                    left: 12,
                    top: 24,
                    bottom: 12,
                  ),
                  child: LineChart(
                    showAvg ? avgData() : mainData(),
                  ),
                ),
              ),
              // Button to toggle average data view
              Positioned(
                right: 16,
                top: -10,
                child: SizedBox(
                  width: 60,
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        showAvg = !showAvg;
                      });
                    },
                    child: Text(
                      'Average',
                      style: TextStyle(
                        fontSize: 12,
                        color: showAvg
                            ? theme.colorScheme.secondary.withOpacity(0.5)
                            : theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // generate the main line chart data
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('JAN', style: style);
        break;
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 4:
        text = const Text('MAY', style: style);
        break;
      case 6:
        text = const Text('JUL', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      case 10:
        text = const Text('NOV', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0hr';
        break;
      case 1:
        text = '2hr';
        break;
      case 2:
        text = '4hr';
        break;
      case 3:
        text = '6hr';
        break;
      case 4:
        text = '8hr';
        break;
      case 5:
        text = '10hr';
        break;
      case 6:
        text = '12hr';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    final theme = Theme.of(context);
    return LineChartData(
      gridData: FlGridData(
        show: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: theme.colorScheme.onBackground.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: theme.colorScheme.onBackground.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border:
            Border.all(color: theme.colorScheme.onBackground.withOpacity(0.2)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.2))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  // generate the average line chart data
  LineChartData avgData() {
    final theme = Theme.of(context);
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: theme.colorScheme.onBackground.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: theme.colorScheme.onBackground.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border:
            Border.all(color: theme.colorScheme.onBackground.withOpacity(0.2)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(1, 3.48),
            FlSpot(2, 3.46),
            FlSpot(3, 3.40),
            FlSpot(4, 3.42),
            FlSpot(5, 3.50),
            FlSpot(6, 3.47),
            FlSpot(7, 3.45),
            FlSpot(8, 3.43),
            FlSpot(9, 3.41),
            FlSpot(10, 3.46),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.2))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
