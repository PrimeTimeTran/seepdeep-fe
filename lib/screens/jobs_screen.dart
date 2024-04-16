import 'package:flutter/material.dart';

import '../utils.dart';
import '../widgets/loading_list.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: getWidth() / 2, child: const LoadingList()),
      ],
    );
  }
}
