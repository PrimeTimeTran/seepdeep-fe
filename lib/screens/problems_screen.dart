import 'dart:async';
import 'dart:convert';

import 'package:app/all.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ProblemsScreen extends StatefulWidget {
  const ProblemsScreen({super.key});

  @override
  State<ProblemsScreen> createState() => _ProblemsScreenState();
}

class _ProblemsScreenState extends State<ProblemsScreen> {
  bool toggleProblemTopics = false;
  Future<List<Problem>>? problems;
  List<CSTopic>? selectedTopicList = topicList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildLeft(),
          const Gap(10),
          buildRight(),
        ],
      ),
    );
  }

  buildCard(title, description, idx) {
    String color = 'orange';
    switch (idx) {
      case 0:
        color = 'blue';
        break;
      case 1:
        color = 'green';
        break;
      case 2:
        color = 'teal';
        break;
      default:
        color = 'yellow';
    }
    return GradientCard(
      color: color,
      title: title ?? '',
      description: description,
      child: const Text(''),
    );
  }

  buildLeft() {
    return Expanded(
      flex: 2,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildStudyPlans(),
              const Gap(5),
              buildProblemTopics(),
              const Gap(5),
              buildProblemList()
            ],
          ),
        ),
      ),
    );
  }

  Padding buildListHeader() {
    return const Padding(
      padding: EdgeInsets.only(),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
                child: Text("Status",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Gap(10),
            Expanded(
                flex: 4,
                child: Text("Title",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(
                width: 95,
                child: Text("Solution",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(
                width: 110,
                child: Text("Acceptance",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(
                width: 110,
                child: Text("Difficulty",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(
                width: 100,
                child: Text("Frequency",
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ]),
    );
  }

  GestureDetector buildListItem(item, idx, BuildContext context) {
    idx -= 1;
    bool odd = idx % 2 == 0;
    Color color = odd ? Colors.grey.shade500 : Colors.grey.shade600;
    Color difficultyColor = item.difficulty == 'Hard'
        ? Colors.red
        : item.difficulty == 'Medium'
            ? Colors.yellow
            : Colors.green;
    return GestureDetector(
      onTap: () {
        Provider.of<ProblemProvider>(context, listen: false)
            .setFocusedProblem(item);
        GoRouter.of(context).go(
            '${AppScreens.problem.path}/${item.title.replaceAll(' ', '-').toLowerCase()}');
      },
      child: Container(
        color: odd ? color : null,
        child: ListTile(
          iconColor: Colors.white,
          leading: const Icon(Icons.abc),
          textColor: Colors.white,
          title: Row(
            children: [
              Expanded(flex: 10, child: Text('${item.numLC}. ${item.title}')),
              const Spacer(),
              const SizedBox(width: 60, child: Icon(Icons.abc)),
              const Spacer(),
              SizedBox(width: 60, child: Text('${item.acceptanceRate}')),
              const Spacer(),
              SizedBox(
                width: 70,
                child: Text(
                  '${item.difficulty}',
                  style: TextStyle(
                      color: difficultyColor, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              SizedBox(width: 60, child: Text('${item.frequency}')),
            ],
          ),
        ),
      ),
    );
  }

  buildProblemList() {
    return FutureBuilder<List<Problem>>(
      future: problems,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int idx) {
              if (idx == 0) {
                return buildListHeader();
              }
              return buildListItem(snapshot.data?[idx], idx, context);
            },
          );
        } else if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ],
          );
        } else {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ],
          );
        }
      },
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
          buildTopicFilter(),
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
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
    );
  }

  buildStudyPlans() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Study Plan',
          style: Style.titleL,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCard(
                'System Design', 'System Design for Interviews and Beyond', 0),
            const Gap(10),
            buildCard('Data Structures & Algorithms',
                'Data Structures & Algorithms', 1),
            const Gap(10),
            buildCard('SQL 50', 'Crack SQL interview in 50 Qs', 2),
          ],
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCard('Intro To Pandas', 'Learn Basic Pandas in 15 Qs', 0),
            const Gap(10),
            buildCard('30 Days of JS', 'Learn JS Basics with 30 Qs', 1),
            const Gap(10),
            buildCard('Amazon Spring \'23 High Frequency',
                'Practice 25 Recently seen problems from Amazon', 2),
          ],
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCard('Mastered', 'Review problems you\'ve mastered.', 0),
            const Gap(10),
            buildCard(
                'Focus', 'Focus on problems you\'re currently learning.', 1),
            const Gap(10),
            buildCard('Repetition',
                'Spaced repetition for problems you\'re struggling on.', 2),
          ],
        ),
      ],
    );
  }

  SizedBox buildTopicFilter() {
    return SizedBox(
      width: 925,
      height: 300,
      child: FilterListWidget(
        listData: topicList,
        hideHeader: true,
        hideSelectedTextCount: true,
        selectedListData: selectedTopicList,
        choiceChipLabel: (item) => item!.name,
        themeData: FilterListThemeData(context),
        validateSelectedItem: (list, val) => list!.contains(val),
        controlButtons: const [ControlButtonType.All, ControlButtonType.Reset],
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: Text(
              item.name,
              style: TextStyle(
                  color: isSelected ? Colors.blue[300] : Colors.grey[500]),
            ),
          );
        },
      ),
    );
  }

  fetchProblems() async {
    try {
      final json = await Api.get('problems');
      final Map<String, dynamic> data = jsonDecode(json);
      setProblems(data);
    } catch (e) {
      Glob.logE('Fetching Problems');
      final json = await rootBundle.loadString("json/problems.json");
      final Map<String, dynamic> data = jsonDecode(json);
      setProblems(data);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProblems();
  }

  setProblems(Map<String, dynamic> data) {
    final List<dynamic> fetchedProblems = data['data'];
    List<Problem> res =
        fetchedProblems.map((item) => Problem.fromJson(item)).toList();
    setState(() {
      problems = Future.value(res);
    });
  }
}
