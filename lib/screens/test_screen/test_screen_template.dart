import 'package:flutter/material.dart';

class TestScreenTemplate extends StatefulWidget {
  const TestScreenTemplate({super.key});

  @override
  State<TestScreenTemplate> createState() => _TestScreenTemplateState();
}

class _TestScreenTemplateState extends State<TestScreenTemplate> {
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
              children: [Text('Test Screen')],
            ),
          ),
        );
      },
    );
  }
}
