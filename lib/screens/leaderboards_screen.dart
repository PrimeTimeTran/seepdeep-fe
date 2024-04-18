import 'package:app/all.dart';
import 'package:flutter/material.dart';

class LeaderboardsScreen extends StatefulWidget {
  const LeaderboardsScreen({super.key});

  @override
  State<LeaderboardsScreen> createState() => _LeaderboardsScreenState();
}

class _LeaderboardsScreenState extends State<LeaderboardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const Text('Bar Charts'),
                SizedBox(width: 600, child: BarChartSample2()),
                const SizedBox(height: 25),
                SizedBox(width: 600, child: BarChartSample3()),
                const SizedBox(height: 25),
                SizedBox(width: 600, child: BarChartSample4()),
                const SizedBox(height: 25),
                const SizedBox(width: 600, child: BarChartSample5()),
                const SizedBox(height: 25),
                const SizedBox(
                    width: 600, height: 100, child: BarChartSample6()),
                const SizedBox(height: 25),
                SizedBox(width: 600, child: BarChartSample7()),
                const SizedBox(height: 25),
                SizedBox(width: 600, child: BarChartSample8()),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const Text('Line Charts'),
                const SizedBox(width: 600, child: LineChartSample1()),
                const SizedBox(height: 25),
                const SizedBox(width: 600, child: LineChartSample2()),
                const SizedBox(height: 25),
                SizedBox(width: 600, child: LineChartSample3()),
                const SizedBox(height: 25),
                SizedBox(width: 600, child: LineChartSample4()),
                const SizedBox(height: 25),
                const SizedBox(width: 600, child: LineChartSample5()),
                const SizedBox(height: 25),
                SizedBox(width: 600, child: LineChartSample6()),
                const SizedBox(height: 25),
                SizedBox(width: 600, child: LineChartSample7()),
                const SizedBox(height: 25),
                const SizedBox(width: 600, child: LineChartSample8()),
                const SizedBox(height: 25),
                SizedBox(width: 600, child: LineChartSample9()),
                const SizedBox(height: 25),
                const SizedBox(width: 600, child: LineChartSample10()),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                Text('Pie Charts'),
                SizedBox(width: 600, height: 300, child: PieChartSample1()),
                SizedBox(height: 25),
                SizedBox(width: 600, height: 300, child: PieChartSample2()),
                SizedBox(height: 25),
                SizedBox(width: 600, height: 300, child: PieChartSample3()),
                SizedBox(height: 25),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const Text('Radar Charts'),
                SizedBox(width: 2000, height: 200, child: RadarChartSample1()),
                const SizedBox(height: 25),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const Text('Scatter Charts'),
                SizedBox(width: 600, height: 600, child: ScatterChartSample1()),
                const SizedBox(height: 25),
                const SizedBox(
                    width: 600, height: 600, child: ScatterChartSample2()),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
