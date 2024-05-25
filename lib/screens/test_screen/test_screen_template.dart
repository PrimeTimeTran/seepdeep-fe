import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        return SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Test Screen'),
              ],
            ),
          ),
        );
      },
    );
  }
}
