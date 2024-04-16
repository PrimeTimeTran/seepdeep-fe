import 'package:app/screens/code_editor/code_editor_screen.dart';
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
        CodeEditorScreen(onRun: onRun),
        buildPrompts(),
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
