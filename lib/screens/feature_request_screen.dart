import 'package:flutter/material.dart';

class FeatureRequestScreen extends StatefulWidget {
  const FeatureRequestScreen({super.key});

  @override
  State<FeatureRequestScreen> createState() => _FeatureRequestScreenState();
}

class _FeatureRequestScreenState extends State<FeatureRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Feature Requests'),
    );
  }
}
