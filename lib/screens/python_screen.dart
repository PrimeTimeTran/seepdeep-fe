// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';

import '../widgets/python/all.dart';

class PythonScreen extends StatefulWidget {
  const PythonScreen({super.key});

  @override
  State<PythonScreen> createState() => _PythonScreenState();
}

class _PythonScreenState extends State<PythonScreen> {
  @override
  Widget build(BuildContext context) {
    return const Python();
  }
}
