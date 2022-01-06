import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_alarm_app/data.dart';

class StatisticScreen extends StatelessWidget {
  final String? payload;
  List<Color> colour = [
    Color(0xffffaf1a), Color(0xfff66500),
  ];

  StatisticScreen({
    Key? key,
    required this.payload
  }) : super(key: key);

  @override

  List<FlSpot> spot() {
    return List<FlSpot>.generate(openedAt.length, (index) =>
        FlSpot(index.toDouble(), openedAt[index].toDouble()));
  } // generating spots for chart based on a List

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Respond Time Chart'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, right: 20, bottom: 20),
        child: LineChart(
          LineChartData( //Chart
            backgroundColor: Color(0xFF0D162D),
            minY: 0,
            maxY: 60,
            titlesData: FlTitlesData(
              rightTitles: SideTitles(
                showTitles: false
              ),
              topTitles: SideTitles(
                showTitles: false
              ),
              bottomTitles: SideTitles(
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 2:
                      return 'Times';
                  }
                  return '';
                }
              )
            ),
            lineBarsData: [
              LineChartBarData(
                colors: colour,
                spots: spot(),
                isCurved: true,
                belowBarData: BarAreaData(
                  show: true,
                  colors: colour.map((color) =>
                      color.withOpacity(0.3)).toList()
                )
              ),
            ],
            borderData: FlBorderData(
              show: false
            )
          )
        ),
      ),
    );
  }
}
