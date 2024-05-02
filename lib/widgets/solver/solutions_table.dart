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
  List<Submission> solutions = [];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search',
              ),
            ),
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
            ListView.separated(
              shrinkWrap: true,
              itemCount: solutions.length,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.grey);
              },
              itemBuilder: (BuildContext context, int idx) {
                final item = solutions[idx];
                return SolutionRow(solution: item);
              },
            ),
          ],
        ),
      ),
    );
  }

  getSolutions() async {
    try {
      final response = await Api.get('solutions?problem=${widget.problem.id}');
      print(response);
      for (var solution in response) {
        solutions.add(Submission.fromJson(solution));
      }
      setState(() {
        solutions = solutions;
      });
    } catch (e) {
      print('Error: $e');
      return [];
    } finally {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSolutions();
  }
}
