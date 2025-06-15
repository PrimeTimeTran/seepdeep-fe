// ignore_for_file: must_be_immutable

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
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
  List<String> solutions = [];
  List<Comment> comments = [];
  bool solutionSelected = false;
  late Submission selectedSolution;
  late Future<List<Submission>> _solutionsFuture;
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!solutionSelected)
              TextField(
                onSubmitted: (value) {
                  onSearch(value);
                },
                controller: _searchController,
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
                    return buildSolutionFocusedPanel();
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

  Column buildSolutionFocusedPanel() {
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
        SizedBox(
          height: 500,
          width: double.infinity,
          child: CodeField(
            textStyle: const TextStyle(
              height: 1.5,
              leadingDistribution: TextLeadingDistribution.even,
            ),
            controller: CodeController(
              language: python,
              text: selectedSolution.body,
            ),
          ),
        ),
        Row(
          children: [
            TextButton.icon(
              icon: const Icon(Icons.thumb_up),
              label: const Text('Upvote'),
              onPressed: () {
                onVote(selectedSolution, 'up');
                // setState(() {
                //   solutionSelected = false;
                // });
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.thumb_down),
              label: const Text('Downvote'),
              onPressed: () {
                onVote(selectedSolution, 'down');
                // setState(() {
                //   solutionSelected = false;
                // });
              },
            ),
          ],
        ),
        if (comments.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              return ListTile(
                leading: const Icon(Icons.comment),
                title: Text(comment.user?.username ?? 'Anonymous'),
                subtitle: Text(comment.body ?? ''),
                trailing: Text(
                  comment.createdAt != null
                      ? DateFormat("MMM d, y h:mm a").format(comment.createdAt!)
                      : '',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              );
            },
          )
        else
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('No comments yet.'),
          ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                minLines: 1,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Add a comment...',
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                if (_commentController.text.trim().isNotEmpty) {
                  await postComment(_commentController.text.trim());
                  _commentController.clear();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ],
    );
  }

  GestureDetector buildSolutionRow(Submission solution) {
    final username = solution.user?.username ?? 'Anonymous';
    return GestureDetector(
      onTap: () {
        onFocusSolution(solution);
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
                itemCount: 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const Gap(5),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          backgroundColor: themeColor(context, 'secondary'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          // your action here
                        },
                        child: Text(
                          solution.language!,
                          style: TextStyle(
                              color:
                                  Style.currentTheme(context) == Brightness.dark
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 10),
                        ),
                      ),
                      const Gap(5),
                    ],
                  );
                },
              ),
            ),
            Text(
              solution.explanation,
              style: Style.of(context, 'headlineS'),
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton.icon(
                  label: Text(solution.voteIdsUp.length.toString()),
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_upward),
                ),
                TextButton.icon(
                  label: Text(solution.viewCount.toString()),
                  onPressed: () {
                    onFocusSolution(solution);
                  },
                  icon: const Icon(Icons.remove_red_eye_outlined),
                ),
                TextButton.icon(
                  label: Text(solution.comments.length.toString()),
                  onPressed: () {
                    onFocusSolution(solution);
                  },
                  icon: const Icon(Icons.comment),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  fetchComments(solution) async {
    try {
      final response = await Api.get('comments?submission=${solution.id}');
      List<Comment> newComments = [];
      final data = response is List ? response : response['comments'];
      for (var comment in data) {
        if (comment is Map<String, dynamic>) {
          newComments.add(Comment.fromJson(comment));
        } else if (comment is String) {
          newComments.add(Comment(body: comment));
        }
      }
      setState(() {
        comments = newComments;
      });
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  Future<List<Submission>> fetchSolutions() async {
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

  Future<List<Submission>> fetchSolutionsWithParams(String url) async {
    final response = await Api.get(url);
    if (response == null) return [];

    final List<dynamic> data = response.toList();
    return data.map((json) => Submission.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    _solutionsFuture = fetchSolutions();
  }

  onFocusSolution(solution) {
    setState(() {
      selectedSolution = solution;
      solutionSelected = !solutionSelected;
    });
    fetchComments(solution);
  }

  onSearch(String value) async {
    final query = Uri.encodeQueryComponent(value);
    final url = '/solutions?explanation=$query&problem=${widget.problem.id}';

    setState(() {
      _solutionsFuture = fetchSolutionsWithParams(url);
    });
  }

  onVote(submission, upDown) async {
    final body = {'id': submission.id, 'upDown': upDown, 'spam': 'ham'};
    final resp = await Api.put('submissions/${submission.id}', body);
    Glob.showSnackSuccess(
      'Vote Saved',
    );
  }

  postComment(comment) async {
    try {
      final body = {"body": comment, "submission": selectedSolution.id};
      final response = await Api.post('comments', body);
    } catch (e) {
      print('Error posting comment: $e');
    } finally {
      _commentController.clear();
    }
  }
}
