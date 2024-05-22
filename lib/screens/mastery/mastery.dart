// ignore_for_file: must_be_immutable

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:gap/gap.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:provider/provider.dart';

import './mastery.helpers.dart';

final subjectsS = {
  'Calculus': {
    "Limits": [
      'Tangent Lines & Rates of Change',
      'The Limit',
      'One-Sided Limits',
      'Limit Properties',
      'Computing Limits',
      'Infinite Limits',
      'Limits at Infinity, Part I',
      'Limits at Infinity, Part II',
      'Continuity',
      'The Definition of the Limit',
    ],
    "Derivatives": [
      'The Definition of the Derivative',
      'Interpretation of the Derivative Differentiation Formulas',
      'Product and Quotient Rule',
      'Derivatives of Trig Functions',
      'Derivatives of Exponential and Logarithm Functions',
      'Derivatives of Inverse Trig Functions',
      'Derivatives of Hyperbolic Functions',
      'Chain Rule',
      'Implicit Differentiation',
      'Related Rates',
      'Higher Order Derivatives',
      'Logarithmic Differentiation',
    ],
    "Application of Derivatives": [
      'Rates of Change',
      'Critical Points',
      'Minimum & Maximum Values',
      'Finding Absolute Extrema',
      'The Shape of a Graph, Part I',
      'The Shape of a Graph, Part II',
      'The Mean Value Theorem',
      'Optimization Problems',
      'More Optimization Problems',
      "L’Hospital’s Rule and Indeterminate Forms",
      'Linear Approximations',
      'Differentials',
      "Newton's Method",
      'Business Applications',
    ],
    "Integrals": [
      'Indefinite Integrals',
      'Computing Indefinite Integrals',
      'Substitution Rule for Indefinite Integrals',
      'More Substitution Rule',
      'Area Problem',
      'Definition of the Definite Integral',
      'Computing Definite Integrals',
      'Substitution Rule for Definite Integrals',
    ],
    "Application of Integrals": [
      "Average Function Value",
      'Area Between Curves',
      'Volumes of Solids of Revolution / Method of Rings',
      'Volumes of Solids of Revolution / Method of Cylinders',
      'More Volume Problems',
    ]
  },
  'Computer Science': {
    'algorithms': ['Data Structures & Algorithms']
  },
};

class MasteryScreen extends StatefulWidget {
  const MasteryScreen({super.key});

  @override
  State<MasteryScreen> createState() => _MasteryScreenState();
}

class ProgressIndicator extends StatefulWidget {
  const ProgressIndicator({super.key});

  @override
  State<ProgressIndicator> createState() => _ProgressIndicatorState();
}

class _MasteryScreenState extends State<MasteryScreen> {
  late User user;
  Map<String, dynamic> mastery = {};
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      listBuilder('Limits', 'Calculus', 'Limits'),
                      listBuilder('Derivatives', 'Calculus', 'Derivatives'),
                      listBuilder('Applications of Derivatives', 'Calculus',
                          'Application of Derivatives'),
                      listBuilder('Integrals', 'Calculus', 'Integrals'),
                      listBuilder('Applications of Intgrals', 'Calculus',
                          'Application of Integrals'),
                      listBuilder(
                          'Computer Science', 'Computer Science', 'algorithms')
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildOverAllIndicators() {
    int idx = 0;
    List<Column> items = [];
    for (var topic in Topics.values) {
      final color = colors[idx % colors.length];
      idx += 1;
      items.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(25),
          Row(
            children: [
              Text(topicName(topic), style: const TextStyle(fontSize: 20)),
              const Spacer(),
              Text('${mastery[topic.name]?['level'] ?? 0} / 10',
                  style: const TextStyle(fontSize: 20))
            ],
          ),
          Consumer<AuthProvider>(
            builder: (context, auth, child) {
              if (auth.isAuthenticated) {
                return Text(
                  'isAuthenticated: ${auth.user.email}',
                  style: TextStyle(
                    color: auth.isAuthenticated ? Colors.green : Colors.red,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          LinearProgressIndicator(
            color: color,
            minHeight: 15,
            semanticsValue: '40',
            value: mastery[topic.name]?['level'] ?? 0,
            semanticsLabel: 'Linear progress indicator',
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          const Gap(25),
        ],
      ));
    }
    return items.toList();
  }

  calculateMastery() {
    user.solved?.map((solved) {});
  }

  fetchSolves() async {
    final resp = await Api.get('solves');
    print(resp);
  }

  @override
  void initState() {
    setup();
    super.initState();
  }

  listBuilder(section, subject, String? topic) {
    var topics = subjectsS[subject]?[topic];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section,
            style: Style.of(context, 'displayL'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: getWidth(),
                    maxWidth: getWidth(),
                    minHeight: 300,
                    maxHeight: 300,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topics?.length,
                    itemExtentBuilder: (index, dimensions) => 400,
                    itemBuilder: (BuildContext context, int idx) {
                      final name = topics?[idx];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.elliptical(20, 20),
                            ),
                          ),
                          child: Column(
                            children: [
                              // SvgPicture.asset(
                              //   'assets/icons/the-limit.svg',
                              //   height: 100,
                              //   width: 100,
                              //   color: Colors.red,
                              // ),
                              // SvgPicture.asset(
                              //   'assets/icons/tangent-line.svg',
                              //   height: 100,
                              //   width: 100,
                              //   color: Colors.blue,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  name ?? '',
                                  style: Style.of(
                                    context,
                                    'titleL',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Gap(30)
        ],
      ),
    );
  }

  setup() {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    if (auth.isAuthenticated) {
      user = auth.user;
      Glob.logI(user.toJson().toString());
      mastery = buildMastery();
      setState(() {
        user = user;
        mastery = mastery;
      });
      fetchSolves();
    }
  }
}

class _ProgressIndicatorState extends State<ProgressIndicator> {
  Map<DateTime, int> dataset = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
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
            PrimerProgressBar(segments: segments2.toList()),
            Padding(
              padding: const EdgeInsets.all(50),
              child: Consumer<AuthProvider>(
                builder: (context, auth, child) {
                  Map<DateTime, int>? vals = {};
                  if (auth.isAuthenticated) {
                    vals = auth.getStreakDates();
                  }
                  return HeatMap(
                    defaultColor: Colors.green.shade100,
                    datasets: vals,
                    colorMode: ColorMode.opacity,
                    showText: false,
                    scrollable: true,
                    colorsets: const {
                      1: Colors.red,
                      3: Colors.orange,
                      5: Colors.yellow,
                      7: Colors.green,
                      9: Colors.blue,
                      11: Colors.indigo,
                      13: Colors.purple,
                    },
                    onClick: (value) {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
