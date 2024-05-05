// ignore_for_file: must_be_immutable

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:gap/gap.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:provider/provider.dart';

import './mastery.helpers.dart';

class MasteryScreen extends StatefulWidget {
  const MasteryScreen({super.key});

  @override
  State<MasteryScreen> createState() => _MasteryScreenState();
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return Text('isAuthenticated: ${auth.user.email}',
                    style: TextStyle(
                        color:
                            auth.isAuthenticated ? Colors.green : Colors.red));
              },
            ),
            const Text('Progress'),
            const Text(
              'Topics covered',
            ),
            PrimerProgressBar(segments: segments2.toList()),
            ColoredCard(
              padding: 40,
              child: HeatMap(
                datasets: {
                  DateTime(2024, 1, 1): 30,
                  DateTime(2024, 2, 2): 30,
                  DateTime(2024, 3, 3): 30,
                  DateTime(2024, 4, 4): 30,
                },
                colorMode: ColorMode.opacity,
                showText: false,
                scrollable: true,
                colorsets: const {
                  1: Colors.red,
                  3: Colors.orange,
                  5: Colors.yellow,
                  7: Colors.green,
                  9: Colors.blue,
                  11: Colors.indigo,
                  13: Colors.purple,
                },
                onClick: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MasteryScreenState extends State<MasteryScreen> {
  late User user;
  Map<String, dynamic> mastery = {};
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Column(
          children: [
            const ProgressIndicator(),
            Row(
              children: [
                Expanded(child: Column(children: buildOverAllIndicators())),
                const Gap(10),
                const Expanded(child: Column(children: [])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildOverAllIndicators() {
    int idx = 0;
    List<Column> items = [];
    for (var topic in Topics.values) {
      final color = colors[idx % colors.length];
      idx += 1;
      items.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(25),
          Row(
            children: [
              Text(topicName(topic), style: const TextStyle(fontSize: 20)),
              const Spacer(),
              Text('${mastery[topic.name]['level']} / 10',
                  style: const TextStyle(fontSize: 20))
            ],
          ),
          LinearProgressIndicator(
            value: mastery[topic.name]['level'],
            color: color,
            minHeight: 15,
            semanticsValue: '40',
            semanticsLabel: 'Linear progress indicator',
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          const Gap(25),
        ],
      ));
    }
    return items.toList();
  }

  calculateMastery() {
    Topics.values;
    user.solved?.map((solved) {});
  }

  fetchSolves() async {
    final resp = await Api.get('solves');
    print(resp);
  }

  @override
  void initState() {
    super.initState();
    user = Provider.of<AuthProvider>(context, listen: false).user;
    print(user);
    Glob.logI(user.toJson().toString());
    mastery = buildMastery();
    setState(() {
      user = user;
      mastery = mastery;
    });
    fetchSolves();
  }
}
