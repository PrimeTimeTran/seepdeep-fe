import 'package:flutter/material.dart';

enum Calendar { day, week, month, year }

enum ContentLineType {
  twoLines,
  threeLines,
}

enum GiffyType {
  rive,
  image,
  lottie;

  Widget when({
    required Widget Function() image,
    required Widget Function() rive,
    required Widget Function() lottie,
  }) {
    switch (this) {
      case GiffyType.image:
        return image();
      case GiffyType.rive:
        return rive();
      case GiffyType.lottie:
        return lottie();
    }
  }
}

enum Language {
  python,
  ruby,
  js,
  ts,
  dart,
  java,
  go,
  cpp,
  sql;

  static Language fromName(String name) {
    switch (name.toLowerCase()) {
      case 'python':
        return Language.python;
      case 'ruby':
        return Language.ruby;
      case 'javascript':
        return Language.js;
      case 'typescript':
        return Language.ts;
      case 'dart':
        return Language.dart;
      case 'java':
        return Language.java;
      case 'go':
        return Language.go;
      case 'cpp':
        return Language.cpp;
      case 'sql':
        return Language.sql;
      default:
        throw ArgumentError('Unknown language: $name');
    }
  }
}

enum PainterType {
  circle,
  square,
  cross,
}

enum SampleItem { itemOne, itemTwo, itemThree }

enum Sizes { extraSmall, small, medium, large, extraLarge }

enum SolveLVL {
  encountered,
  novice,
  apprentice,
  proficient,
  intermediate,
  advanced,
  expert,
  mastered,
  guru,
  legend
}

enum SortOption { bubble, selection, insertion, merge }

enum Speeds { fast, faster, fastest }

enum ToastType { info }

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
