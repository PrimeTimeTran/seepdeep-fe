import 'dart:async';

import 'package:app/all.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
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
  Future<List<Problem>> problems = Future.value([]);
  Future<List<Solve>> solves = Future.value([]);
  List<CSTopic>? selectedTopicList = topicList;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Set<DateTime> _doneDays = {};
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              // buildStudyPlans(),
              // const Gap(5),
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
    final style = Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(child: Text("Status", style: style)),
            const Gap(10),
            Expanded(flex: 4, child: Text("Title", style: style)),
            const Gap(50),
            // SizedBox(child: Text("Solution", style: style)),
            // const Gap(50),
            SizedBox(child: Text("Acceptance", style: style)),
            const Gap(50),
            SizedBox(child: Text("Difficulty", style: style)),
            // const Gap(60),
            // SizedBox(child: Text("Frequency", style: style)),
          ]),
    );
  }

  GestureDetector buildListItem(
      Problem item, idx, BuildContext context, solvesList) {
    idx -= 1;
    bool odd = idx % 2 == 0;
    Color colorLight = odd ? Colors.blue.shade100 : Colors.blue.shade200;

    Color colorDark = odd ? Colors.blueGrey.shade800 : Colors.blueGrey.shade900;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color rowColor = isDark ? colorDark : colorLight;

    Color difficultyColor = item.difficulty == 'Hard'
        ? Colors.red
        : item.difficulty == 'Medium'
            ? Colors.yellow
            : Colors.green;
    final isSolved = solvesList.any((solve) => solve.problemId == item.id);
    final icon = isSolved ? Icons.check_circle : Icons.circle_outlined;
    final iconColor = isSolved ? Colors.green : Colors.grey;
    return GestureDetector(
      onTap: () {
        Provider.of<ProblemProvider>(context, listen: false)
            .setFocusedProblem(item);
        GoRouter.of(context).go(
          '${AppScreens.dsa.path}/${item.title?.replaceAll(' ', '-').toLowerCase()}',
        );
      },
      child: Container(
        color: rowColor,
        child: ListTile(
          iconColor: Colors.grey,
          leading: Icon(icon, color: iconColor),
          title: Row(
            children: [
              Expanded(
                flex: 10,
                child: AppText(
                  text: '${item.numLC}. ${item.title}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              // const Spacer(),
              // SizedBox(width: 60, child: Icon(icon, color: iconColor)),
              const Spacer(),
              SizedBox(
                width: 60,
                child: AppText(text: '${item.acceptanceRate}'),
              ),
              const Spacer(),
              SizedBox(
                width: 70,
                child: Center(
                  child: Text(
                    '${item.difficulty}',
                    style: TextStyle(
                      color: difficultyColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              )
              // const Spacer(),
              // SizedBox(width: 60, child: Text('${item.frequency}')),
            ],
          ),
        ),
      ),
    );
  }

  buildProblemList() {
    return FutureBuilder<List<Solve>>(
      future: solves,
      builder: (context, solvesSnapshot) {
        final problems = context.watch<ProblemsProvider>().problems;
        final solvesList = solvesSnapshot.data ?? [];
        return ListView.builder(
          shrinkWrap: true,
          itemCount: problems.length,
          itemBuilder: (BuildContext context, int idx) {
            final problem = problems[idx];
            if (idx == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildListHeader(),
                  buildListItem(problem, idx, context, solvesList),
                ],
              );
            }
            return buildListItem(problem, idx, context, solvesList);
          },
        );
      },
    );
  }

  buildProblemTopics() {
    final topics = context.watch<TopicProvider>().topics;
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
                onPressed: () {
                  setState(
                    () => toggleProblemTopics = !toggleProblemTopics,
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                ),
              ),
            ],
          ),
          buildTopicFilter(),
        ],
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          TextButton.icon(
            label: const Text('Reset', style: TextStyle(color: Colors.black)),
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              final problemsProvider = context.read<ProblemsProvider>();
              problemsProvider.resetProblems(topics.first);
            },
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size.zero,
            ),
          ),
          for (final topic in topics)
            TextButton.icon(
              label: Text('${topic.name} (${topic.numProblems})',
                  style: const TextStyle(color: Colors.black)),
              icon: const Icon(Icons.arrow_circle_up_outlined,
                  color: Colors.white),
              onPressed: () {
                final problemsProvider = context.read<ProblemsProvider>();
                problemsProvider.fetchProblemsByTopic(topic);
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size.zero,
              ),
            ),
        ],
      ),
    );
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
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              // calendarFormat: _calendarFormat,
              // selectedDayPredicate: (day) => _isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;

                  // Toggle "done" status
                  final alreadyDone =
                      _doneDays.any((d) => _isSameDay(d, selectedDay));
                  if (alreadyDone) {
                    _doneDays.removeWhere((d) => _isSameDay(d, selectedDay));
                  } else {
                    _doneDays.add(selectedDay);
                  }
                });
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final isDone = _doneDays.any((d) => _isSameDay(d, day));
                  return Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: isDone ? Colors.greenAccent : null,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text('${day.day}'),
                  );
                },
              ),
            ),
          ),
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
          style: Style.of(context, 'titleL'),
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

  fetchSolved() async {
    try {
      final json = await Api.get('solves');
      setSolves(json);
    } catch (e) {
      Glob.logE('Error fetching Solves: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSolved();
  }

  setSolves(List<dynamic> data) {
    try {
      List<Solve> res = data.map((i) => Solve.fromJson(i)).toList();
      setState(() {
        solves = Future.value(res);
      });
    } catch (e) {
      Glob.logE('Error setting solves: $e');
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
