import 'package:app/all.dart';
import 'package:app/screens/sql/lesson.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
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
  bool queried = false;
  String lessonContent = '';
  List lessonQueryPrompts = [];
  bool queryFinished = false;
  Iterable<String> columnNames = [];
  List<Iterable<MapEntry<String, dynamic>>> records = [];

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
                    Expanded(
                      child: Card.outlined(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: buildQueryPrompts(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card.outlined(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return HorizontalSplitView(
                      borderless: true,
                      top: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade300))),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [buildTable()],
                            ),
                          ),
                        ),
                      ),
                      bottom: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Editor(
                            onRun: onRun,
                            problem: problem,
                            lang: Language.sql,
                            onType: (c, l) {
                              setState(() {
                                code = c;
                              });
                            },
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
                                    // setState(() {
                                    //   lessonId = 0;
                                    // });
                                    // Storage.instance.setSqlStep(0);
                                  },
                                  outlined: true,
                                ),
                                Button(
                                  title: 'Hint',
                                  onPress: () {},
                                  outlined: true,
                                ),
                                Button(
                                  title: 'Next',
                                  onPress: () {
                                    if (lessonId == 14) return;
                                    setLesson(lessonId + 1);
                                  },
                                  outlined: true,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  buildPrompts() {
    if (!queryFinished) {
      return Column(
        children: [
          const SizedBox(height: 50),
          Text(
            'Query for Results. Available Tables:',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 25),
          Text(
            'Customers, Employees, Invoices, Invoice_Items, Albums, Playlists, Playlist_Track, Tracks, Artists, Genres, Media_Types',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      );
    }
    return const SizedBox();
  }

  buildQueryPrompts() {
    List<Widget> prompts = [];
    for (var i = 0; i < lessonQueryPrompts.length; i++) {
      prompts.add(Text(lessonQueryPrompts[i]['prompt']));
    }
    return prompts.toList();
  }

  buildResults() {
    if (queried && records.isEmpty && queryFinished) {
      return Column(
        children: [
          const SizedBox(height: 50),
          Text(
            '0 Results found. Double check your query and try again.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 25),
          Text(
            'If this problem persists please checkout our help guide as we do have a few known issues with our parser.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'Column names should not have quotes and the value should be in single quotes. For Example:',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'SELECT * from Customers where country = \'USA\' ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }
    return const SizedBox();
  }

  buildTable() {
    if (records.isNotEmpty) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            DataTable(
              columns: columnNames.map<DataColumn>((String columnName) {
                return DataColumn(label: Text(columnName));
              }).toList(),
              rows: records
                  .map<DataRow>((Iterable<MapEntry<String, dynamic>> row) {
                final cellMap = Map<String, dynamic>.fromEntries(row);
                return DataRow(
                  cells: columnNames.map<DataCell>((String columnName) {
                    return DataCell(
                      SelectableText(cellMap[columnName]?.toString() ?? ''),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }

  @override
  void initState() {
    super.initState();
    onRun("SELECT * FROM films limit 5; ");
    setup();
  }

  void onRun([String? c, Language? language]) {
    setState(() {
      records = [];
      queried = false;
      columnNames = [];
      queryFinished = false;
    });
    query(c ?? code);
  }

  List<Iterable<MapEntry<String, dynamic>>> parseQueryRows(
      List<QueryRow> queryRows) {
    for (var row in queryRows) {
      records.add(row.data.entries);
    }
    return records;
  }

  void query(String code) async {
    try {
      final database = ref.read(AppDatabase.provider);
      // Select table names
      // code = "SELECT name FROM sqlite_master WHERE type='table';";
      // code = "SELECT * from todo_entries";
      // code = "SELECT * from customers where country='Brazil'";
      // code = "Select * from categories";

      List<QueryRow> result = await database.customSelect(
        '$code ',
        readsFrom: {...database.allTables},
      ).get();
      if (result.isNotEmpty) {
        records = parseQueryRows(result);
        QueryRow firstRow = result.first;
        columnNames = firstRow.data.keys;
        setState(() {
          queried = true;
          records = records;
          queryFinished = true;
          columnNames = columnNames;
        });
      } else {
        setState(() {
          queried = true;
          queryFinished = true;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  setLesson(id) async {
    lessonContent = await loadData(id);
    setState(() {
      lessonId = id;
      lessonContent = lessonContent;
      lessonQueryPrompts = lessonPromptMap[lessons[id]]!;
    });
    Storage.instance.setSqlStep(id);
  }

  setup() async {
    lessonId = await checkProgress();
    await setLesson(lessonId);
  }
}
