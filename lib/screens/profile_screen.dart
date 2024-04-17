import 'package:app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';

import '../widgets/all.dart';
import 'charts/charts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ColoredCard(
                          height: getHeight() * 1.75,
                          child: Column(
                            children: [
                              ColoredCard(color: Colors.red),
                              const Divider(),
                              ColoredCard(color: Colors.blue),
                              const Divider(),
                              ColoredCard(color: Colors.blue),
                              const Divider(),
                              ColoredCard(color: Colors.blue),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        ColoredCard(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const LineChartSample1(),
                              BarChartSample3()
                            ],
                          ),
                        ),
                        ColoredCard(
                          child: Row(
                            children: [
                              Expanded(
                                child: ColoredCard(
                                  color: Colors.red,
                                  child: const Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text('sososo'),
                                          GFAvatar(
                                            backgroundImage: NetworkImage(
                                              "https://i.pravatar.cc/150?img=3",
                                            ),
                                          ),
                                          RotatedBox(
                                            quarterTurns: -3,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(5),
                              Expanded(
                                child: ColoredCard(
                                  color: Colors.blue,
                                  child: Row(
                                    children: [
                                      const Text('ososo'),
                                      BarChartSample3(rotate: true)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ColoredCard(
                          padding: 40,
                          child: HeatMap(
                            datasets: {
                              DateTime(2024, 1, 1): 30,
                              DateTime(2024, 2, 2): 30,
                              DateTime(2024, 3, 3): 30,
                              DateTime(2024, 4, 4): 30,
                            },
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
                            onClick: (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(value.toString())));
                            },
                          ),
                        ),
                        ColoredCard(
                          height: getHeight() * .5,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return ListTile(title: Text('item $index'));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
