import 'package:app/all.dart';
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

buildMastery() {
  Map<String, dynamic> resp = {};
  for (var topic in Topics.values) {
    resp[topic.name] = {};
    resp[topic.name]['level'] = .2;
  }
  return resp;
}

topicName(value) {
  switch (value) {
    case Topics.sorting:
      return 'Sorting';
    case Topics.string:
      return 'String';
    case Topics.stack:
      return 'Stack';
    case Topics.queue:
      return 'Queue';
    case Topics.array:
      return 'Array';
    case Topics.twoPointers:
      return 'Two Pointers';
    case Topics.binarySearch:
      return 'Binary Search';
    case Topics.slidingWindow:
      return 'Sliding Window';
    case Topics.linkedList:
      return 'Linked List';
    case Topics.trees:
      return 'Trees';
    case Topics.backTracking:
      return 'Back Tracking';
    case Topics.heap:
      return 'Heap';
    case Topics.graph:
      return 'Graph';
    case Topics.unionFind:
      return 'Union Find';
    case Topics.dp:
      return 'Dynamic Programming';
    case Topics.interval:
      return 'Interval';
    case Topics.greedy:
      return 'Greedy';
    case Topics.advancedGraph:
      return 'Advanced Graph';
    case Topics.dp2:
      return 'Dynamic Programming 2';
    case Topics.binary:
      return 'Binary';
    case Topics.math:
      return 'Math';
    default:
      return "Math";
  }
}
