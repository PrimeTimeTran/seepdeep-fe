// ignore_for_file: must_be_immutable

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:provider/provider.dart';

import './mastery.helpers.dart';

class MasteryScreen extends StatefulWidget {
  const MasteryScreen({super.key});

  @override
  State<MasteryScreen> createState() => _MasteryScreenState();
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            // color: Colors.red,
            ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Progress'),
            const Text(
              'Topics covered',
            ),
            PrimerProgressBar(segments: segments2.toList())
          ],
        ),
      ),
    );
  }
}

class _MasteryScreenState extends State<MasteryScreen> {
  Map<String, dynamic> mastery = {};
  late User user;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50),
        child: Column(
          children: [
            Text(user.email!),
            const ProgressIndicator(),
            Column(children: buildOverAllIndicators())
          ],
        ),
      ),
    );
  }

  buildOverAllIndicators() {
    int idx = 0;
    return topics.map((e) {
      final color = colors[idx % colors.length];
      idx += 1;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(5),
          Text(e),
          LinearProgressIndicator(
            value: 0.4,
            color: color,
            minHeight: 15,
            semanticsValue: '40',
            semanticsLabel: 'Linear progress indicator',
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          const Gap(5),
        ],
      );
    }).toList();
  }

  calculateMastery() {
    Topics.values;
    user.solved?.map((solved) {});
  }

  @override
  void initState() {
    super.initState();
    user = Provider.of<AuthProvider>(context, listen: false).user;
    setState(() {
      user = user;
    });
  }
}
