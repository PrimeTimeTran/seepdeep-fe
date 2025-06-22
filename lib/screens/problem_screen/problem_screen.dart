import 'package:app/all.dart';
import 'package:flutter/material.dart';

class ProblemScreen extends StatefulWidget {
  const ProblemScreen({super.key});

  @override
  State<ProblemScreen> createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {
  VoidCallback? _onFabPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Composer(
        provideFabCallback: (callback) {
          _onFabPressed = callback;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onFabPressed?.call();
        },
        child: const Icon(Icons.question_mark_rounded),
      ),
    );
  }
}
