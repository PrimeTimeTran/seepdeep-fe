import 'dart:math';

import 'package:flutter/material.dart';

buildGenericListView(
    [title = 'Item',
    width = 500,
    color = Colors.blue,
    direction = Axis.vertical]) {
  return Container(
    width: width,
    color: color,
    child: ListView.builder(
      itemCount: 15,
      shrinkWrap: true,
      scrollDirection: direction,
      itemBuilder: (BuildContext context, int idx) {
        return SizedBox(
          height: 40,
          width: 40,
          child: ListTile(
            title: Text('$title $idx'),
          ),
        );
      },
    ),
  );
}

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
