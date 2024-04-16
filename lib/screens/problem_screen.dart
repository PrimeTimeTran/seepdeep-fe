// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';

import '../widgets/problem/all.dart';

class ProblemScreen extends StatefulWidget {
  const ProblemScreen({super.key});

  @override
  State<ProblemScreen> createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {
  @override
  Widget build(BuildContext context) {
    return const Problem();
  }
}
