import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

List<User> userList = [
  User(name: "Python", avatar: "user.png"),
  User(name: "Dart", avatar: "user.png"),
  User(name: "SQL", avatar: "user.png"),
  User(name: "Postgres", avatar: "user.png"),
  User(name: "MongoDB", avatar: "user.png"),
  User(name: "C", avatar: "user.png"),
  User(name: "C++", avatar: "user.png"),
  User(name: "C#", avatar: "user.png"),
  User(name: "Go", avatar: "user.png"),
  User(name: "Mojo", avatar: "user.png"),
  User(name: "Ruby", avatar: "user.png"),
  User(name: "Typescript", avatar: "user.png"),
  User(name: "Javascript", avatar: "user.png"),
  User(name: "Flutter", avatar: "user.png"),
  User(name: "Vue", avatar: "user.png"),
  User(name: "React", avatar: "user.png"),
  User(name: "React Native", avatar: "user.png"),
  User(name: "Nuxt", avatar: "user.png"),
  User(name: "Next", avatar: "user.png"),
  User(name: "Ruby on Rails", avatar: "user.png"),
  User(name: "Django", avatar: "user.png"),
  User(name: ".Net", avatar: "user.png"),
  User(name: "NodeJS", avatar: "user.png"),
  User(name: "Flask", avatar: "user.png"),
  User(name: "Kubernetes", avatar: "user.png"),
  User(name: "Docker", avatar: "user.png"),
  User(name: "Data Analysis", avatar: "user.png"),
  User(name: "Data Analytics", avatar: "user.png"),
  User(name: "LLM", avatar: "user.png"),
  User(name: "AI", avatar: "user.png"),
  User(name: "Machine Learning", avatar: "user.png"),
  User(name: "Theresa", avatar: "user.png"),
  User(name: "Una", avatar: "user.png"),
  User(name: "Vanessa", avatar: "user.png"),
  User(name: "Victoria", avatar: "user.png"),
  User(name: "Wanda", avatar: "user.png"),
  User(name: "Wendy", avatar: "user.png"),
  User(name: "Yvonne", avatar: "user.png"),
  User(name: "Zoe", avatar: "user.png"),
];

class ProblemsScreen extends StatefulWidget {
  const ProblemsScreen({super.key});

  @override
  State<ProblemsScreen> createState() => _ProblemsScreenState();
}

class User {
  final String? name;
  final String? avatar;
  User({this.name, this.avatar});
}

class _ProblemsScreenState extends State<ProblemsScreen> {
  List<User>? selectedUserList = userList;
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
                onPressed: () => setState(() {
                  toggleProblemTopics = !toggleProblemTopics;
                }),
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
              listData: userList,
              hideHeader: true,
              hideSelectedTextCount: true,
              selectedListData: selectedUserList,
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
                  selectedUserList = List.from(list!);
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
                  onPressed: () => setState(() {
                    toggleProblemTopics = !toggleProblemTopics;
                  }),
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
