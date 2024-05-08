import 'package:app/all.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../database/database.dart';

const go = """
# SQL Lesson 1: SELECT queries 101

To retrieve data from a SQL database, we write SELECT statements, which are often referred to as **queries**.

A query in itself is a statement which declares what data we're looking for, where to find it in the database, and optionally, how to transform it before it is returned.

It has a specific syntax though, which is what we are going to learn in the following exercises.

It's helpful to think of a table in SQL as a specific type of entity. Each row is an instance of that entity. The columns would then represent properties of an entity.

For example on the right we have the table `Movies`. Each movie has the same properties, `title`, `director`, `year` etc, but their properties have different values, `Toy Story`, `A Bug's Life`, etc.


The syntax for selecting data from our table follows:

```sql
SELECT column, another_column, …
FROM mytable;
```

So if we wanted to select the title of all our movies in our database we would write

```sql
SELECT title
FROM movies;
```
""";

class Employee {
  final int id;
  final int salary;
  final String name;
  final String designation;
  Employee(this.id, this.name, this.designation, this.salary);
}

class EmployeeDataSource extends DataGridSource {
  List<DataGridRow> _employeeData = [];
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}

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

  List<Employee> employees = <Employee>[];

  late EmployeeDataSource employeeDataSource;

  @override
  Widget build(BuildContext context) {
    return provider.Consumer<ProblemProvider>(
      builder: (context, problemProvider, _) {
        var problem = problemProvider.focusedProblem;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Card(
                      child: Column(
                        children: [
                          buildLesson(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card.outlined(
                      child: Editor(
                        onRun: onRun,
                        onType: () {},
                        problem: problem,
                        lang: Language.sql,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [buildTable()],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  buildLesson() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Markdown(
        data: go,
      ),
    );
    // return SizedBox(
    //   height: 1000,
    //   width: 1000,
    //   child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Markdown(
    //           key: const Key("defaultmarkdownformatter"),
    //           data: go,
    //           selectable: true,
    //           padding: const EdgeInsets.all(10),
    //           builders: {
    //             'code': CodeElementBuilder(),
    //           })),
    // );
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
          ],
        ),
      );
      // Info: Keeps header but isn't simple to have dynamic columns
      // return SfDataGrid(
      //   source: employeeDataSource,
      //   columnWidthMode: ColumnWidthMode.fill,
      //   columns: <GridColumn>[
      //     GridColumn(
      //         columnName: 'id',
      //         label: Container(
      //             padding: const EdgeInsets.all(16.0),
      //             alignment: Alignment.center,
      //             child: const Text(
      //               'ID',
      //             ))),
      //     GridColumn(
      //         columnName: 'name',
      //         label: Container(
      //             padding: const EdgeInsets.all(8.0),
      //             alignment: Alignment.center,
      //             child: const Text('Name'))),
      //     GridColumn(
      //         columnName: 'designation',
      //         label: Container(
      //             padding: const EdgeInsets.all(8.0),
      //             alignment: Alignment.center,
      //             child: const Text(
      //               'Designation',
      //               overflow: TextOverflow.ellipsis,
      //             ))),
      //     GridColumn(
      //         columnName: 'salary',
      //         label: Container(
      //             padding: const EdgeInsets.all(8.0),
      //             alignment: Alignment.center,
      //             child: const Text('Salary'))),
      //   ],
      // );
    }
    return const SizedBox();
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000)
    ];
  }

  @override
  void initState() {
    super.initState();
    onRun('');
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  void onRun(String code) {
    setState(() {
      records = [];
      queried = false;
      columnNames = [];
      queryFinished = false;
    });
    query("select * from 'Invoices'; ");
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
