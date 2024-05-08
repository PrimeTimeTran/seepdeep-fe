import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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