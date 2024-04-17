import 'dart:convert';

import 'package:app/models/all.dart';
import 'package:app/providers/problem_provider.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants.dart';
import '../utils.dart';

class ProblemsScreen extends StatefulWidget {
  const ProblemsScreen({super.key});

  @override
  State<ProblemsScreen> createState() => _ProblemsScreenState();
}

class _ProblemsScreenState extends State<ProblemsScreen> {
  bool toggleProblemTopics = false;
  List<CSTopic>? selectedTopicList = topicList;
  List<Problem>? problems = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLeft(),
              const SizedBox(width: 10),
              buildRight(),
            ],
          ),
        ],
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
        SizedBox(
          width: 1000,
          child: ListView.builder(
            itemCount: problems!.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int idx) {
              var item = problems![idx];
              return GestureDetector(
                onTap: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Provider.of<ProblemProvider>(context, listen: false)
                        .setFocusedProblem(item);
                    GoRouter.of(context).go('/problem');
                  });
                },
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: ListTile(
                    title: Text('${item.numLC}. ${item.title}'),
                  ),
                ),
              );
            },
          ),
        ),
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
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
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

  // Future<List<Article>> fetchProblems() async {
  Future<List<Problem>> fetchProblems() async {
    try {
      // String url = "https://api";
      // final response = await http.get(Uri.parse(url));
      if (false) {
        // Error();
        // final Map<String, dynamic> data = json.decode(response.body);
        // setProblems(data);
      } else {
        final localJson = await rootBundle.loadString("json/problems.json");
        final Map<String, dynamic> data = json.decode(localJson);
        setProblems(data);
      }

      return [];
    } catch (e) {
      print('Error: $e');
      final localJson = await rootBundle.loadString("json/problems.json");
      final Map<String, dynamic> data = json.decode(localJson);
      setProblems(data);
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchProblems();
    });
  }

  setProblems(Map<String, dynamic> data) {
    final List<dynamic> fetchedArticles = data['data'];
    List<Problem> res =
        fetchedArticles.map((item) => Problem.fromJson(item)).toList();
    setState(() {
      problems = res;
    });
  }
}
