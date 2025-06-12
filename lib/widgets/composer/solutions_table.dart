// ignore_for_file: must_be_immutable

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlighter/themes/atelier-cave-dark.dart';
import 'package:gap/gap.dart';
import 'package:highlight/languages/python.dart';
import 'package:intl/intl.dart';

// Todo:
// - Add a search bar to filter solutions by tags or keywords.
// - Implement pagination or infinite scrolling for large datasets.
// - Allow users to sort solutions by date, votes, or comments.

class SolutionsTable extends StatefulWidget {
  Problem problem;
  SolutionsTable({super.key, required this.problem});

  @override
  State<SolutionsTable> createState() => _SolutionsTableState();
}

class _SolutionsTableState extends State<SolutionsTable> {
  late Future<List<Submission>> _solutionsFuture;
  bool solutionSelected = false;
  late Submission selectedSolution;
  List<String> solutions = [];
  @override
  Widget build(BuildContext context) {
    final codeStyle = Style.currentTheme(context) == Brightness.light
        ? vsTheme
        : atelierCaveDarkTheme;
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!solutionSelected)
              TextField(
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Search',
                  suffixText: 'Votes',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      print('Suffix tap');
                    },
                    child: const Icon(Icons.sort),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                ),
              ),
            if (!solutionSelected && false)
              SizedBox(
                height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TextButton(
                        onPressed: () {},
                        child: const Text('Python'),
                      );
                    },
                  ),
                ),
              ),
            FutureBuilder<List<Submission>>(
              future: _solutionsFuture,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  if (solutionSelected) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          icon: const Icon(Icons.chevron_left),
                          label: const Text('Back to All Solutions'),
                          onPressed: () {
                            setState(() {
                              solutionSelected = false;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        CodeTheme(
                          data: CodeThemeData(
                            styles: codeStyle,
                          ),
                          child: SizedBox(
                            height: 900,
                            width: 500,
                            child: CodeField(
                              textStyle: const TextStyle(
                                height: 1.5,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                              controller: CodeController(
                                language: python,
                                text: selectedSolution.body,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  List<Submission> solutions = snapshot.data!;
                  if (solutions.isEmpty) {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: Text('No solutions for this problem so far.'),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: solutions.length,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return const Divider(color: Colors.grey);
                    },
                    itemBuilder: (BuildContext context, int idx) {
                      Submission item = solutions[idx];
                      return buildSolutionRow(item);
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
                }
                return const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildSolutionRow(Submission solution) {
    final username = solution.user?.username ?? 'Anonymous';
    return GestureDetector(
      onTap: () {
        setState(() {
          solutionSelected = !solutionSelected;
          selectedSolution = solution;
        });
      },
      child: ListTile(
        subtitleTextStyle: const TextStyle(height: 3),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              child: Icon(Icons.person),
            ),
            const Gap(20),
            Text(
              username,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(solution.createdAt != null
                ? DateFormat("MMMM d, y h:mm a")
                    .format(solution.createdAt ?? DateTime.now())
                : '')
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      TextButton(
                        style: const ButtonStyle(
                            visualDensity: VisualDensity.compact),
                        onPressed: () {},
                        child: Text('Tag $index',
                            style: const TextStyle(fontSize: 12)),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Text('sososo'),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton.icon(
                  label: const Text('10'),
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_upward),
                ),
                TextButton.icon(
                  label: const Text('4.5K'),
                  onPressed: () {},
                  icon: const Icon(Icons.remove_red_eye_outlined),
                ),
                TextButton.icon(
                  label: const Text('5'),
                  onPressed: () {},
                  icon: const Icon(Icons.comment),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _solutionsFuture = _getSolutions();
  }

  Future<List<Submission>> _getSolutions() async {
    try {
      print('_getSolutions called for problem: ${widget.problem.id}');
      final response = await Api.get('solutions?problem=${widget.problem.id}');
      List<Submission> solutions = [];
      List<dynamic> data = response.toList();
      for (var solution in data) {
        solutions.add(Submission.fromJson(solution));
      }
      setState(() {
        solutions = solutions;
      });
      return solutions;
    } catch (e) {
      print('Error: $e');
      return [];
    } finally {}
  }
}
