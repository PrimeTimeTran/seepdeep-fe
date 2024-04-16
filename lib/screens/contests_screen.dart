import 'package:flutter/material.dart';

import '../utils.dart';
import '../widgets/loading_list.dart';

class ContestsScreen extends StatefulWidget {
  const ContestsScreen({super.key});

  @override
  State<ContestsScreen> createState() => _ContestsScreenState();
}

class _ContestsScreenState extends State<ContestsScreen> {
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
