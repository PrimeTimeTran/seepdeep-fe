import 'package:app/widgets/all.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';

class SQLScreen extends ConsumerStatefulWidget {
  const SQLScreen({super.key});

  @override
  ConsumerState<SQLScreen> createState() => _SQLScreenState();
}

class _SQLScreenState extends ConsumerState<SQLScreen> {
  bool queried = false;
  bool queryFinished = false;
  Iterable<String> columnNames = [];
  List<Iterable<MapEntry<String, dynamic>>> records = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          queried ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Editor(onRun: onRun, onType: () {}, problem: Problem.),
        buildPrompts(),
        buildTable(),
        buildResults(),
      ],
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
    } else {
      return const SizedBox();
    }
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
    } else {
      return const SizedBox();
    }
  }

  buildTable() {
    if (records.isNotEmpty) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text(cellMap[columnName]?.toString() ?? ''));
                    }).toList(),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Query Results: ${records.length} records.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'DatabaseTables:',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Customers, Employees, Invoices, Invoice_Items, Albums, Playlists, Playlist_Track, Tracks, Artists, Genres, Media_Types',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  void onRun(String code) {
    setState(() {
      records = [];
      queried = false;
      columnNames = [];
      queryFinished = false;
    });
    query(code);
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
      print(result);
      print(result[0].data);
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
}
