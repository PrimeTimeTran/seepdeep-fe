import 'dart:async';
import 'dart:html' as html;

import 'package:app/all.dart';
import 'package:app/screens/sql/lesson.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart' as provider;

import '../../database/database.dart';
import 'sql.helpers.dart';

class SQLScreen extends ConsumerStatefulWidget {
  const SQLScreen({super.key});

  @override
  ConsumerState<SQLScreen> createState() => _SQLScreenState();
}

class _SQLScreenState extends ConsumerState<SQLScreen> {
  String code = '';
  int lessonId = 0;
  bool error = false;
  String errorMsg = '';
  bool showHint = false;
  bool querying = false;
  List queryResults = [];
  int lessonPromptIdx = 0;
  String lessonContent = '';
  List lessonQueryPrompts = [];
  Iterable<String> columnNames = [];
  Map<String, dynamic> answerMap = {};

  http.Client client = http.Client();

  @override
  Widget build(BuildContext context) {
    return provider.Consumer<ProblemProvider>(
      builder: (context, problemProvider, _) {
        var problem = problemProvider.focusedProblem;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Modal(type: GiffyType.rive, title: '', content: Gap(1)),
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Card(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              LessonMarkDown(lessonContent: lessonContent)
                            ],
                          ),
                        ),
                      ),
                    ),
                    buildQueryPromptPanel(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card.outlined(
                child: HorizontalSplitView(
                  borderless: false,
                  borderColor: Colors.grey,
                  ratio: .6,
                  top: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: buildQueryResultsTable()),
                  ),
                  bottom: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Editor(
                        onRun: onRun,
                        problem: problem,
                        lang: Language.sql,
                        onType: (c, l) => setState(() => code = c),
                      ),
                      if (showHint)
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            lessonPromptMap[lessons[lessonId]]?[lessonPromptIdx]
                                ['hint'],
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Button(
                              title: 'Back',
                              onPress: () {
                                if (lessonId == 0) return;
                                setLesson(lessonId - 1);
                              },
                              outlined: true,
                            ),
                            Button(
                              title: 'Reset Progress',
                              onPress: () {
                                setLesson(0);
                              },
                              outlined: true,
                            ),
                            Button(
                              title: 'Reset Query',
                              onPress: () {
                                setState(() {
                                  code = '';
                                });
                              },
                              outlined: true,
                            ),
                            Button(
                              title: 'Hint',
                              onPress: () {
                                setState(() {
                                  showHint = true;
                                });
                              },
                              outlined: true,
                            ),
                            Button(
                              title: 'Next',
                              onPress: () {
                                if (lessonId == 15) return;
                                setLesson(lessonId + 1);
                              },
                              outlined: true,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Expanded buildQueryPromptPanel() {
    return Expanded(
      flex: 2,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: lessonQueryPrompts.length,
            itemBuilder: (BuildContext context, int index) {
              final item = lessonQueryPrompts[index];
              final subtitle = item['queryPromptFollowup'] != null
                  ? Text(item['queryPromptFollowup'])
                  : null;

              bool isDone = answerMap['$lessonId-$index'];
              var checkboxColor = Colors.grey;
              var icon = Icon(Icons.check_box_outline_blank_outlined,
                  color: Colors.red.shade400);
              if (isDone) {
                checkboxColor = Colors.green;
                icon =
                    const Icon(Icons.check_box_outlined, color: Colors.green);
              }

              return ListTile(
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: checkboxColor),
                style: ListTileStyle.drawer,
                leading: icon,
                title: Text(item['queryPrompt']),
                subtitle: subtitle,
              );
            },
          ),
        ),
      ),
    );
  }

  buildQueryResultsTable() {
    if (queryResults.isNotEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  DataTable(
                    columns: columnNames.map<DataColumn>((String columnName) {
                      return DataColumn(label: Text(columnName));
                    }).toList(),
                    rows: queryResults.map<DataRow>((cellMap) {
                      return DataRow(
                        cells: columnNames.map<DataCell>((String columnName) {
                          return DataCell(
                            SelectableText(
                                cellMap[columnName]?.toString() ?? ''),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    if (error) {
      return Center(
        child: SizedBox(
          child: Text(errorMsg.isNotEmpty
              ? errorMsg
              : 'Invalid submission. Try adding a valid SQL query.'),
        ),
      );
    }

    if (querying) {
      return const Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return const SizedBox();
  }

  // buildResults() {
  //   if (queried && records.isEmpty && queryFinished) {
  //     return Column(
  //       children: [
  //         const SizedBox(height: 50),
  //         Text(
  //           '0 Results found. Double check your query and try again.',
  //           style: Theme.of(context).textTheme.headlineSmall,
  //         ),
  //         const SizedBox(height: 25),
  //         Text(
  //           'If this problem persists please checkout our help guide as we do have a few known issues with our parser.',
  //           style: Theme.of(context).textTheme.bodyLarge,
  //         ),
  //         const SizedBox(height: 10),
  //         Text(
  //           'Column names should not have quotes and the value should be in single quotes. For Example:',
  //           style: Theme.of(context).textTheme.bodyLarge,
  //         ),
  //         const SizedBox(height: 10),
  //         RichText(
  //           text: const TextSpan(
  //             style: TextStyle(
  //               fontSize: 16.0,
  //               color: Colors.black,
  //             ),
  //             children: <TextSpan>[
  //               TextSpan(
  //                 text: 'SELECT * from Customers where country = \'USA\' ',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.blue,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     );
  //   }
  //   return const SizedBox();
  // }

  checkCorrect() async {
    final lesson = lessonPromptMap[lessons[lessonId]];
    final answerQuery = lesson![lessonPromptIdx]['answer']!;
    List results = await queryDB(answerQuery);
    List answerIds = results.map((e) => e['id']).toList();
    print('lessonId $lessonId');
    print('lessonPromptIdx $lessonPromptIdx');
    print('query ${lesson[lessonPromptIdx]['answer']!}');
    print('resultIdsresultIds $answerIds');

    const go = """
select id, title, worldwide_gross from films where worldwide_gross >= 1000;
select id, year, title, oscars_nominated from films where oscars_nominated >= 5;
select id, year, title, oscars_nominated, oscars_won from films where oscars_won >= 3;
""";
    final userQueryIds = queryResults.map((e) => e['id']).toList();
    print('userQueryIds $userQueryIds');
    if (answerIds.length != userQueryIds.length) {
      print('not same');
    } else {
      bool same = true;
      for (int i = 0; i < answerIds.length; i++) {
        if (answerIds[i] != userQueryIds[i]) {
          same = false;
          break;
        }
      }
      if (same) {
        print('same');
        await FirebaseAnalytics.instance
            .logEvent(name: "study_query_end_success");
        answerMap['$lessonId-$lessonPromptIdx'] = true;
        setState(() {
          answerMap = answerMap;
          lessonPromptIdx = lessonPromptIdx + 1;
        });
      } else {
        print('not same');
      }
    }
    setState(() {
      querying = false;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> getAIHelp() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080'),
      );
      if (response.statusCode == 200) {
        await playAudioFromBytes(response.bodyBytes);
      } else {
        // Handle other status codes if needed
      }
    } catch (e) {
      // Handle any exceptions
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // onRun("select id, year, title from films limit 5;");
    // setup();
    getAIHelp();
    super.initState();
  }

  void onRun([String? c, Language? language]) {
    setState(() {
      error = false;
      querying = true;
      columnNames = [];
      showHint = false;
      queryResults = [];
    });
    queryUser(c ?? code);
  }

  parseResults(result) {
    return result.map((row) {
      return Map<String, dynamic>.fromEntries(row.data.entries);
    }).toList();
  }

  Future<void> playAudioFromBytes(Uint8List audioBytes) async {
    try {
      final blob = html.Blob([audioBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final audioElement = html.AudioElement()
        ..src = url
        ..controls = true;
      audioElement.play();
    } catch (e) {
      print('Error: $e');
    }
  }

  queryDB(String code) async {
    final database = ref.read(AppDatabase.provider);
    List<QueryRow> result = await database.customSelect(
      '$code ',
      readsFrom: {...database.allTables},
    ).get();

    if (result.isNotEmpty) {
      return parseResults(result);
    }
  }

  void queryUser(String code) async {
    Completer<void> queryCompleter = Completer<void>();
    await FirebaseAnalytics.instance.logEvent(
      name: "study_submission_create",
      parameters: {
        "type": "sql",
        "problem_id": '$lessonId-$lessonPromptIdx',
      },
    );
    try {
      Glob.logI('Query started');
      final results = await queryDB(code);
      setState(() {
        queryResults = results;
        columnNames = results[0].keys;
      });
    } catch (e) {
      String msg = e.toString();
      if (e.toString().contains('Must contain an SQL')) {
        msg = 'Try adding a valid SQL query.';
      }
      setState(() {
        error = true;
        errorMsg = msg;
      });
    } finally {
      queryCompleter.complete();
      await queryCompleter.future;
      Glob.logI('Query ended');
      checkCorrect();
    }
  }

  setLesson(id) async {
    lessonContent = await loadData(id);
    lessonQueryPrompts = lessonPromptMap[lessons[id]]!;
    int idx = 0;
    for (var _ in lessonQueryPrompts) {
      answerMap['$id-$idx'] = false;
      idx += 1;
    }
    setState(() {
      lessonId = id;
      showHint = false;
      lessonContent = lessonContent;
      lessonQueryPrompts = lessonQueryPrompts;
    });
    Storage.instance.setSqlStep(id);
  }

  setup() async {
    lessonId = await checkProgress();
    await setLesson(lessonId);
  }
}
