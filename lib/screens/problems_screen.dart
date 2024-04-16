import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

class ProblemsScreen extends StatefulWidget {
  const ProblemsScreen({super.key});

  @override
  State<ProblemsScreen> createState() => _ProblemsScreenState();
}

class _ProblemsScreenState extends State<ProblemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: SizedBox(
            height: getHeight() * 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLeft(),
                      const SizedBox(width: 10),
                      buildRight(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildCard(title, description) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: SizedBox(
          height: 100,
          width: 300,
          child: ListTile(
            leading: const Icon(Icons.abc),
            title: Text(title),
            subtitle: Text(description),
          ),
        ),
      ),
    );
  }

  buildLeft() {
    return Column(
      children: [
        const Text('Study Plan'),
        Row(
          children: [
            buildCard(
                'System Design', 'System Design for Interviews and Beyond'),
            const SizedBox(
              width: 10,
            ),
            buildCard(
                'Data Structures & Algorithms', 'Data Structures & Algorithms'),
            buildCard('SQL 50', 'Crack SQL interview in 50 Qs'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            buildCard('Intro To Pandas', 'Learn Basic Pandas in 15 Qs'),
            const SizedBox(
              width: 10,
            ),
            buildCard('30 Days of JS', 'Learn JS Basics with 30 Qs'),
            buildCard('Amazon Spring \'23 High Frequency',
                'Practice 25 Recently seen problems from Amazon'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            buildCard('Mastered', 'Review problems you\'ve mastered.'),
            const SizedBox(
              width: 10,
            ),
            buildCard('Focus', 'Focus on problems you\'re currently learning.'),
            buildCard('Repetition',
                'Spaced repetition for problems you\'re struggling on.'),
          ],
        ),
        const SizedBox(height: 4),
        buildGenericListView('Problem', 925, Colors.lightGreenAccent),
      ],
    );
  }

  buildRight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 400,
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
          ),
        ),
        buildGenericListView('Companies', 400, Colors.grey),
      ],
    );
  }
}
