import 'dart:math';

import 'package:flutter/material.dart';

getHeight() {
  return MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
}

getWidth() {
  return MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
}

bool isArray(dynamic data) {
  return data is List;
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
