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
  List<Iterable<MapEntry<String, dynamic>>> records = [];
  Iterable<String> columnNames = [];
  bool queryFinished = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CodeEditorScreen(onRun: onRun), buildResults()],
    );
  }

  buildResults() {
    if (!queryFinished) {
      return const Text(
          'Query for Results. \nTables include Customers, Employees, Invoices, Invoice_Items, Albums, Playlists, Playlist_Track, Tracks, Artists, Genres, Media_Types');
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          columns: columnNames.map<DataColumn>((String columnName) {
            return DataColumn(label: Text(columnName));
          }).toList(),
          rows: records.map<DataRow>((Iterable<MapEntry<String, dynamic>> row) {
            final cellMap = Map<String, dynamic>.fromEntries(row);
            return DataRow(
              cells: columnNames.map<DataCell>((String columnName) {
                return DataCell(Text(cellMap[columnName]?.toString() ?? ''));
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }

  void onRun(String code) {
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
      List<QueryRow> result = await database.customSelect(
        code,
        readsFrom: {...database.allTables},
      ).get();
      if (result.isNotEmpty) {
        records = parseQueryRows(result);
        QueryRow firstRow = result.first;

        columnNames = firstRow.data.keys;
        print(columnNames);
        print(firstRow.data);
        setState(() {
          records = records;
          queryFinished = true;
          columnNames = columnNames;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
