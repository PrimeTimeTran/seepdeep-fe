// ignore_for_file: must_be_immutable

import 'package:app/extensions/extensions.dart';
import 'package:flutter/material.dart';

final gradients = {
  "green": [Colors.green, Colors.green.shade900],
  "blue": [Colors.blue, Colors.blue.shade900],
  "orange": [Colors.orange, Colors.orangeAccent],
  "yellow": [Colors.yellow, Colors.yellowAccent],
  "teal": [Colors.teal, Colors.teal.shade900],
};

final List<String> imageList = [
  "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
  "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
];

class ColoredCard extends StatelessWidget {
  double? height;
  double padding;
  double? width;
  Widget? child;
  Color? color;
  ColoredCard({
    super.key,
    this.child,
    this.height = 300,
    this.padding = 8.0,
    this.width = double.infinity,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color!.lighten(50),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: child,
        ),
      ),
    );
  }
}

class GradientCard extends StatelessWidget {
  Widget child;
  Color? from;
  Color? to;
  String? title;
  String? color;
  String? description;
  IconData? icon = Icons.import_contacts_outlined;
  GradientCard({
    super.key,
    required this.child,
    required this.title,
    required this.description,
    this.icon,
    this.color = 'blue',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: SizedBox(
        height: 100,
        width: 350,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              colors: gradients[color]!,
            ),
          ),
          child: ListTile(
            leading: const Icon(Icons.abc),
            title: Text(
              title!,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              description!,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
