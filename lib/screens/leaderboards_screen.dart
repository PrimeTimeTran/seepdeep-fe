import 'package:flutter/material.dart';

import 'charts/bar/bar_charts.dart';
import 'charts/line/line_chart_sample1.dart';
import 'charts/line/line_chart_sample10.dart';
import 'charts/line/line_chart_sample2.dart';
import 'charts/line/line_chart_sample3.dart';
import 'charts/line/line_chart_sample4.dart';
import 'charts/line/line_chart_sample5.dart';
import 'charts/line/line_chart_sample6.dart';
import 'charts/line/line_chart_sample7.dart';
import 'charts/line/line_chart_sample8.dart';
import 'charts/line/line_chart_sample9.dart';

class LeaderboardsScreen extends StatefulWidget {
  const LeaderboardsScreen({super.key});

  @override
  State<LeaderboardsScreen> createState() => _LeaderboardsScreenState();
}

class _LeaderboardsScreenState extends State<LeaderboardsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(
                        width: 600, height: 300, child: LineChartSample1()),
                    const SizedBox(height: 25),
                    const SizedBox(
                        width: 600, height: 300, child: LineChartSample2()),
                    const SizedBox(height: 25),
                    SizedBox(
                        width: 600, height: 600, child: LineChartSample3()),
                    const SizedBox(height: 25),
                    SizedBox(
                        width: 600, height: 300, child: LineChartSample4()),
                    const SizedBox(height: 25),
                    const SizedBox(
                        width: 600, height: 300, child: LineChartSample5()),
                    const SizedBox(height: 25),
                    SizedBox(
                        width: 600, height: 300, child: LineChartSample6()),
                    const SizedBox(height: 25),
                    SizedBox(
                        width: 600, height: 300, child: LineChartSample7()),
                    const SizedBox(height: 25),
                    const SizedBox(
                        width: 600, height: 300, child: LineChartSample8()),
                    const SizedBox(height: 25),
                    SizedBox(
                        width: 600, height: 300, child: LineChartSample9()),
                    const SizedBox(height: 25),
                    const SizedBox(
                        width: 600, height: 600, child: LineChartSample10()),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(width: 600, height: 300, child: BarChartSample2()),
                    const SizedBox(height: 25),
                    const SizedBox(
                        width: 600, height: 300, child: BarChartSample3()),
                    const SizedBox(height: 25),
                    SizedBox(width: 600, height: 300, child: BarChartSample4()),
                    const SizedBox(height: 25),
                    const SizedBox(
                        width: 600, height: 300, child: BarChartSample5()),
                    const SizedBox(height: 25),
                    const SizedBox(
                        width: 600, height: 500, child: BarChartSample6()),
                    const SizedBox(height: 25),
                    SizedBox(width: 600, height: 300, child: BarChartSample7()),
                    const SizedBox(height: 25),
                    SizedBox(width: 600, height: 300, child: BarChartSample8()),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
