import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

List<Topic> topicList = [
  Topic(name: "Python", avatar: "Topic.png"),
  Topic(name: "Dart", avatar: "Topic.png"),
  Topic(name: "SQL", avatar: "Topic.png"),
  Topic(name: "Postgres", avatar: "Topic.png"),
  Topic(name: "MongoDB", avatar: "Topic.png"),
  Topic(name: "C", avatar: "Topic.png"),
  Topic(name: "C++", avatar: "Topic.png"),
  Topic(name: "C#", avatar: "Topic.png"),
  Topic(name: "Go", avatar: "Topic.png"),
  Topic(name: "Mojo", avatar: "Topic.png"),
  Topic(name: "Ruby", avatar: "Topic.png"),
  Topic(name: "Typescript", avatar: "Topic.png"),
  Topic(name: "Javascript", avatar: "Topic.png"),
  Topic(name: "Flutter", avatar: "Topic.png"),
  Topic(name: "Vue", avatar: "Topic.png"),
  Topic(name: "React", avatar: "Topic.png"),
  Topic(name: "React Native", avatar: "Topic.png"),
  Topic(name: "Nuxt", avatar: "Topic.png"),
  Topic(name: "Next", avatar: "Topic.png"),
  Topic(name: "Ruby on Rails", avatar: "Topic.png"),
  Topic(name: "Django", avatar: "Topic.png"),
  Topic(name: ".Net", avatar: "Topic.png"),
  Topic(name: "NodeJS", avatar: "Topic.png"),
  Topic(name: "Flask", avatar: "Topic.png"),
  Topic(name: "Kubernetes", avatar: "Topic.png"),
  Topic(name: "Docker", avatar: "Topic.png"),
  Topic(name: "Data Analysis", avatar: "Topic.png"),
  Topic(name: "Data Analytics", avatar: "Topic.png"),
  Topic(name: "LLM", avatar: "Topic.png"),
  Topic(name: "AI", avatar: "Topic.png"),
  Topic(name: "Machine Learning", avatar: "Topic.png"),
  Topic(name: "Theresa", avatar: "Topic.png"),
  Topic(name: "Una", avatar: "Topic.png"),
  Topic(name: "Vanessa", avatar: "Topic.png"),
  Topic(name: "Victoria", avatar: "Topic.png"),
  Topic(name: "Wanda", avatar: "Topic.png"),
  Topic(name: "Wendy", avatar: "Topic.png"),
  Topic(name: "Yvonne", avatar: "Topic.png"),
  Topic(name: "Zoe", avatar: "Topic.png"),
];

class ProblemsScreen extends StatefulWidget {
  const ProblemsScreen({super.key});

  @override
  State<ProblemsScreen> createState() => _ProblemsScreenState();
}

class Topic {
  final String? name;
  final String? avatar;
  Topic({this.name, this.avatar});
}

class _ProblemsScreenState extends State<ProblemsScreen> {
  List<Topic>? selectedTopicList = topicList;
  bool toggleProblemTopics = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: SizedBox(
            height: getHeight() * 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLeft(),
                      const SizedBox(width: 10),
                      buildRight(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildCard(title, description) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: SizedBox(
          height: 100,
          width: 300,
          child: ListTile(
            leading: const Icon(Icons.abc),
            title: Text(title),
            subtitle: Text(description),
          ),
        ),
      ),
    );
  }

  buildLeft() {
    return Column(
      children: [
        buildStudyPlans(),
        const SizedBox(height: 4),
        buildProblemTopics(),
        const SizedBox(height: 4),
        buildGenericListView('Problem', 925, Colors.lightGreenAccent),
      ],
    );
  }

  buildProblemTopics() {
    if (toggleProblemTopics) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                label:
                    const Text("Topics", style: TextStyle(color: Colors.white)),
                icon: const Icon(Icons.arrow_circle_up_outlined,
                    color: Colors.white),
                onPressed: () =>
                    setState(() => toggleProblemTopics = !toggleProblemTopics),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 925,
            height: 400,
            child: FilterListWidget(
              listData: topicList,
              hideHeader: true,
              hideSelectedTextCount: true,
              selectedListData: selectedTopicList,
              choiceChipLabel: (item) => item!.name,
              themeData: FilterListThemeData(context),
              validateSelectedItem: (list, val) => list!.contains(val),
              controlButtons: const [
                ControlButtonType.All,
                ControlButtonType.Reset
              ],
              onItemSearch: (user, query) {
                return user.name!.toLowerCase().contains(query.toLowerCase());
              },
              onApplyButtonClick: (list) {
                setState(() {
                  selectedTopicList = List.from(list!);
                });
                Navigator.pop(context);
              },
              choiceChipBuilder: (context, item, isSelected) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
                  )),
                  child: Text(
                    item.name,
                    style: TextStyle(
                        color:
                            isSelected ? Colors.blue[300] : Colors.grey[500]),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return SizedBox(
        width: 925,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  label: const Text("Topics",
                      style: TextStyle(color: Colors.white)),
                  icon: const Icon(Icons.arrow_circle_down_outlined,
                      color: Colors.white),
                  onPressed: () => setState(
                      () => toggleProblemTopics = !toggleProblemTopics),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  buildRight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 400,
          height: 400,
          child: TableCalendar(
            focusedDay: DateTime.now(),
            lastDay: DateTime.utc(2030, 3, 14),
            firstDay: DateTime.utc(2010, 10, 16),
          ),
        ),
        buildGenericListView('Companies', 400, Colors.grey),
      ],
    );
  }

  buildStudyPlans() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Study Plan'),
        Row(
          children: [
            buildCard(
                'System Design', 'System Design for Interviews and Beyond'),
            const SizedBox(
              width: 10,
            ),
            buildCard(
                'Data Structures & Algorithms', 'Data Structures & Algorithms'),
            buildCard('SQL 50', 'Crack SQL interview in 50 Qs'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            buildCard('Intro To Pandas', 'Learn Basic Pandas in 15 Qs'),
            const SizedBox(
              width: 10,
            ),
            buildCard('30 Days of JS', 'Learn JS Basics with 30 Qs'),
            buildCard('Amazon Spring \'23 High Frequency',
                'Practice 25 Recently seen problems from Amazon'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            buildCard('Mastered', 'Review problems you\'ve mastered.'),
            const SizedBox(
              width: 10,
            ),
            buildCard('Focus', 'Focus on problems you\'re currently learning.'),
            buildCard('Repetition',
                'Spaced repetition for problems you\'re struggling on.'),
          ],
        ),
      ],
    );
  }
}
