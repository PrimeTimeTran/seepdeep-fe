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
      itemCount: 20,
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
