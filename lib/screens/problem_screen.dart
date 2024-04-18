import 'package:app/all.dart';
import 'package:flutter/material.dart';

class ProblemScreen extends StatefulWidget {
  const ProblemScreen({super.key});

  @override
  State<ProblemScreen> createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {
  @override
  Widget build(BuildContext context) {
    // We have to sequester the UI for Problem Solving Screen this way
    // Because of how we implement Python code runner. It's inside of a WebView
    // so that we can evaluate it client side.
    return const Solver();
  }
}
