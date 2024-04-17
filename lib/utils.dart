import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

buildGenericListView(
    [title = 'Item',
    width = 500,
    color = Colors.blue,
    direction = Axis.vertical]) {
  return Container(
    width: width,
    color: color,
    child: ListView.builder(
      itemCount: 30,
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

Future<bool> isUrlValid(String url) async {
  try {
    final response = await http.head(Uri.parse(url));
    return response.statusCode == 200;
  } on http.ClientException catch (e) {
    // Handle ClientException separately
    print('ClientException occurred while checking URL: $e');
    return false;
  } catch (e) {
    // Handle other exceptions
    print('Error occurred while checking URL: $e');
    return false;
  }
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
