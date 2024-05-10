import 'package:app/all.dart';
import 'package:app/screens/sql/lesson.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart' as provider;

import '../../database/database.dart';

class SQLScreen extends ConsumerStatefulWidget {
  const SQLScreen({super.key});

  @override
  ConsumerState<SQLScreen> createState() => _SQLScreenState();
}

class _SQLScreenState extends ConsumerState<SQLScreen> {
  String code = '';
  bool queried = false;
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
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Card(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            LessonMarkDown(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card.outlined(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Select id, title & '),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const SizedBox(height: 10),
                      //     Text(
                      //       'Query Results: ${records.length} records.',
                      //       style: Theme.of(context).textTheme.bodyMedium,
                      //     ),
                      //     const SizedBox(height: 30),
                      //     Text(
                      //       'DatabaseTables:',
                      //       style: Theme.of(context).textTheme.bodySmall,
                      //     ),
                      //     const SizedBox(height: 5),
                      //     Text(
                      //       'studios, directors, movies, movie_directors, customers, employees, invoices, invoice_items, albums, playlists, playlist_track, tracks, artists, genres, media_types',
                      //       style: Theme.of(context).textTheme.bodySmall,
                      //     ),
                      //   ],
                      // ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: (getHeight() / 1.5) + 225,
                              width: double.infinity,
                              child: HorizontalSplitView(
                                borderless: true,
                                top: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      buildTable(),
                                    ],
                                  ),
                                ),
                                bottom: Column(
                                  children: [
                                    Editor(
                                      onRun: onRun,
                                      onType: (c) => setState(() => code = c),
                                      problem: problem,
                                      lang: Language.sql,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Button(
                                            title: 'Back',
                                            onPress: () {},
                                            outlined: true,
                                          ),
                                          Button(
                                            title: 'Reset',
                                            onPress: () {},
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
                                              Storage.instance
                                                  .setSqlStep('2.0');
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
                          ],
                        ),
                      ),
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
    // onRun("SELECT * FROM films as f WHERE f.title LIKE '% and %';");
    // onRun("SELECT * FROM films as f WHERE f.title LIKE '%Harry%';");
    onRun("SELECT * FROM films limit 5; ");
    setup();
  }

  void onRun([String? c]) {
    setState(() {
      records = [];
      queried = false;
      columnNames = [];
      queryFinished = false;
    });
    print('Running');
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
        code,
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

  setup() {}
}
