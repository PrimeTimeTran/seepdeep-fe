import 'package:flutter/material.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';

const colors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.lightBlue,
  Colors.lightBlueAccent,
  Colors.lightGreen,
  Colors.lightGreenAccent,
  Colors.teal,
  Colors.cyan,
  Colors.cyanAccent,
  Colors.indigo,
  Colors.indigoAccent,
  Colors.purple,
  Colors.deepPurple,
  Colors.deepPurpleAccent,
  Colors.blueGrey,
  Colors.blueAccent,
];

const topics = [
  'Sorting',
  'Strings',
  'Stack',
  'Queue',
  'Array',
  'Two Pointers',
  'Binary Search',
  'Sliding Window',
  'Linked List',
  'Trees',
  'Backtracking',
  'Heap',
  'Graph',
  'Union Find',
  'DP',
  'Interval',
  'Greedy',
  'Advanced Graph',
  '2DP',
  'Binary',
];
int idx = 0;
final segments2 = topics.map((element) {
  final color = colors[idx % colors.length];
  idx += 1;
  return Segment(
    value: 24,
    color: color,
    label: Text(element),
    valueLabel: const Text('24%'),
  );
});

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
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            // color: Colors.red,
            ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Progress'),
            const Text(
              'Topics covered',
            ),
            PrimerProgressBar(segments: segments2.toList())
          ],
        ),
      ),
    );
  }
}

class _MasteryScreenState extends State<MasteryScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [ProgressIndicator()],
        ),
      ),
    );
  }
}
