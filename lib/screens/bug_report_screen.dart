import 'package:flutter/material.dart';

class BugReportScreen extends StatefulWidget {
  const BugReportScreen({super.key});

  @override
  State<BugReportScreen> createState() => _BugReportScreenState();
}

class _BugReportScreenState extends State<BugReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Bug Reports'),
    );
  }
}
