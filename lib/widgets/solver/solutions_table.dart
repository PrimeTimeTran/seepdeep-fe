// ignore_for_file: must_be_immutable

import 'package:app/all.dart';
import 'package:flutter/material.dart';

class SolutionRow extends StatelessWidget {
  final solution;
  const SolutionRow({super.key, required this.solution});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitleTextStyle: const TextStyle(height: 3),
      title: const Row(
        children: [
          Icon(Icons.circle, size: 40),
          Text('Username'),
          Spacer(),
          Text('1 hour ago')
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ListView.builder(
              itemCount: 10,
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
    );
  }
}

class SolutionsTable extends StatefulWidget {
  Problem problem;
  SolutionsTable({super.key, required this.problem});

  @override
  State<SolutionsTable> createState() => _SolutionsTableState();
}

class _SolutionsTableState extends State<SolutionsTable> {
  late Future<List<Submission>> _solutionsFuture;
  List<String> solutions = [];
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 0,
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
                      return SolutionRow(solution: item);
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
                return const Center(child: CircularProgressIndicator());
              },
            ),
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
