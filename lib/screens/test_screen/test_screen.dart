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
            child: Column(
              children: [
                const Text('Top'),
                const Spacer(),
                const Text('Bottom'),
                Container(
                  color: Colors.blue,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 100,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return const Row(
                          children: [Text('sosso      ')],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
