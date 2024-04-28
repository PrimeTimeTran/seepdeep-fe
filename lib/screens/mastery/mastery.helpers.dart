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
  'Array',
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
  'Math',
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

enum Topics {
  sorting,
  string,
  stack,
  queue,
  array,
  twoPointers,
  binarySearch,
  slidingWindow,
  linkedList,
  trees,
  backTracking,
  heap,
  graph,
  unionFind,
  dp,
  interval,
  greedy,
  advancedGraph,
  dp2,
  binary,
  math
}
