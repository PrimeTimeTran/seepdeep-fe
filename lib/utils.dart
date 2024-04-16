import 'dart:math';

import 'package:flutter/material.dart';

String capitalize(String input) {
  if (input.isEmpty) return input;
  return input.substring(0, 1).toUpperCase() + input.substring(1);
}

getHeight() {
  // ignore: deprecated_member_use
  return MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
}

getWidth() {
  // ignore: deprecated_member_use
  return MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
}

List<int> sample(int limit, int sampleSize) {
  var random = Random();
  var sample = <int>{};
  while (sample.length < sampleSize) {
    var randomNumber = random.nextInt(limit) + 1;
    if (randomNumber != 0) {
      sample.add(randomNumber);
    }
  }

  return sample.toList();
}

List<List<T>> zipLists<T>(List<T> list1, List<T> list2) {
  if (list1.length != list2.length) {
    throw ArgumentError('Lists must have the same length');
  }

  List<List<T>> zippedList = [];
  for (int i = 0; i < list1.length; i++) {
    zippedList.add([list1[i], list2[i]]);
  }
  return zippedList;
}
