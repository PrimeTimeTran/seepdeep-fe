import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'package:app/all.dart';
import 'package:app/s_d_icon_icons.dart';
import 'package:app/screens/sql/lesson.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart' as provider;

import '../../database/database.dart';
import 'sql.helpers.dart';

colorPicker(context, color) {
  switch (color) {
    case 'background':
      return Theme.of(context).colorScheme.background;
    case 'onTertiaryContainer':
      return Theme.of(context).colorScheme.onTertiaryContainer;
    case 'primaryContainer':
      return Theme.of(context).colorScheme.primaryContainer;
    default:
  }
}

class SQLScreen extends ConsumerStatefulWidget {
  const SQLScreen({super.key});

  @override
  ConsumerState<SQLScreen> createState() => _SQLScreenState();
}

class _SQLScreenState extends ConsumerState<SQLScreen> {
  String code = '';
  int lessonId = 0;
  bool error = false;
  bool isAIProcessing = false;
  String aiText = '';
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
                  ratio: .45,
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
                      if (isAIProcessing)
                        const Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              Gap(25),
                              Text('AI Processing')
                            ],
                          ),
                        ),
                      if (!isAIProcessing && aiText != '')
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                aiText,
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      if (showHint)
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              lessonPromptMap[lessons[lessonId]]
                                  ?[lessonPromptIdx]['hint'],
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                buildButton(
                                  icon: Icons.reset_tv_rounded,
                                  title: 'Reset',
                                  onPressed: () {
                                    setLesson(0);
                                  },
                                ),
                                const Gap(10),
                                buildButton(
                                  icon: Icons.restore,
                                  title: 'Reset Query',
                                  onPressed: () {
                                    setState(() {
                                      code = '';
                                    });
                                  },
                                ),
                                const Gap(10),
                                buildButton(
                                  icon: Icons.arrow_back,
                                  title: 'Back',
                                  onPressed: () {
                                    if (lessonId == 0) return;
                                    setLesson(lessonId - 1);
                                  },
                                ),
                              ],
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                buildButton(
                                  title: 'Hint',
                                  onPressed: () {
                                    setState(() {
                                      showHint = true;
                                    });
                                  },
                                ),
                                const Gap(10),
                                buildButton(
                                  icon: SDIcon.ai_enabled,
                                  title: 'A.I. Help',
                                  onPressed: () {
                                    getOpenAIHint();
                                  },
                                ),
                                const Gap(10),
                                buildButton(
                                  title: 'Next',
                                  color: 'primaryContainer',
                                  icon: Icons.navigate_next_outlined,
                                  size: 2,
                                  onPressed: () {
                                    if (lessonId == 15) return;
                                    setLesson(lessonId + 1);
                                  },
                                ),
                              ],
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

  buildButton({
    String? color,
    String title = '',
    int size = 1,
    onPressed,
    IconData? icon,
  }) {
    MaterialStatePropertyAll<Color?> buttonColor = MaterialStatePropertyAll(
        colorPicker(context, color ?? 'onInverseSurface'));

    var button = Expanded(
      flex: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: buttonColor,
        ),
        child: Text(title),
      ),
    );
    if (icon != null) {
      button = Expanded(
        flex: size,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: buttonColor,
            minimumSize: MaterialStateProperty.all(const Size(20, 50)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title),
              const SizedBox(width: 8.0),
              Icon(icon),
            ],
          ),
        ),
      );
    }
    return button;
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
    if (answerIds.length != userQueryIds.length) {
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

  Future<void> getAIHelp(content) async {
    try {
      final headers = <String, String>{};
      headers['Content-Type'] = 'application/json';
      String api = 'https://seepdeep-api-dev-7d6537ynfa-uc.a.run.app/api/ai';
      if (kDebugMode) {
        api = 'http://localhost:3000/api/ai';
      }
      final response = await http.post(
        Uri.parse(api),
        headers: headers,
        body: jsonEncode(
          {"body": content},
        ),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final audioBase64 = body['body'];
        final bytes = base64Decode(audioBase64);
        await playAudioFromBytes(bytes);
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        aiText = content;
        isAIProcessing = false;
      });
    }
  }

  // Python backend working
  // Future<void> getAIHelp(content) async {
  //   try {
  //     final headers = <String, String>{};
  //     headers['Content-Type'] = 'application/json';
  //     final response = await http.post(
  //       Uri.parse('http://localhost:3000/api/ai'),
  //       headers: headers,
  //       body: jsonEncode(
  //         {"body": content},
  //       ),
  //     );
  //     if (response.statusCode == 200) {
  //       await playAudioFromBytes(response.bodyBytes);
  //     } else {}
  //   } catch (e) {
  //     print('Error: $e');
  //   } finally {
  //     setState(() {
  //       aiText = content;
  //       isAIProcessing = false;
  //     });
  //   }
  // }

  getOpenAIHint() async {
    setState(() {
      isAIProcessing = true;
    });
    try {
      final headers = <String, String>{};
      headers['authorization'] =
          'Bearer ${'sk-proj-Uib4u9nZ7uLEtPGcI9EgT3BlbkFJGlA5PKHfcN8SsXDmnbfo'}';
      headers['Content-Type'] = 'application/json';
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: headers,
        body: jsonEncode(
          {
            "model": "gpt-4o",
            "messages": [
              {
                "role": "system",
                "content":
                    """You help hint users towards a successful SQL query given a requirement & query.
                    Requirement:
                    ${lessonPromptMap[lessons[lessonId]]?[lessonPromptIdx]}
                    Query:
                    $code
                    """
              },
              {
                "role": "user",
                "content":
                    "What should I consider doing to make this work? Do not include code in your response. But do name specific columns or SQL keywords I might consider using."
              }
            ]
          },
        ),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        String resp = json['choices'][0]['message']['content'];
        getAIHelp(resp);
      }
      //       Map<String, dynamic> response = {"statusCode": 201, 'body': {}};
      //       if (response['statusCode'] == 200) {
      //         final json = jsonDecode(response['body']);
      //         String resp = json['choices'][0]['message']['content'];
      //       } else {
      //         String resp = """
      // To make this query work for selecting films with at least 1 billion in worldwide gross, you need to adjust the condition in the `WHERE` clause. The current condition `worldwide_gross >= 1` is incorrect because it looks for films with a worldwide gross of at least 1 unit, not 1 billion. The right condition should be `worldwide_gross >= 1000000000`.
      // """;
      //         getAIHelp(resp);
      //       }
    } catch (e) {
      // Handle any exceptions
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    onRun("select id, year, title from films limit 5;");
    setup();
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

  // Works for both Python & Node Backend
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
