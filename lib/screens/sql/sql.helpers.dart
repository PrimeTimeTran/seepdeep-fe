import 'package:app/all.dart';
import 'package:flutter/services.dart';

import 'temp_lesson.dart';

final lessonPromptMap = {
  '0.toc.md': [
    {'prompt': 'Checkout the table in the top right'},
    {'prompt': 'Checkout the next & find buttons'},
    {'prompt': 'Checkout the results'},
  ],
  '1.insert.md': [
    {'prompt': 'Add an employee to the employees table'},
    {
      'prompt':
          'Add another employee with name & surname fields to the employees table'
    },
    {'prompt': 'Add a third employee to the employees table'},
  ],
  '2.select.md': [
    {'prompt': 'Find all the directors'},
    {'prompt': 'Find all the films'},
    {'prompt': 'Find all the film directors'},
  ],
  '3.update.md': [
    {'prompt': 'Update'},
  ],
  '4.delete.md': [
    {'prompt': 'Delete'},
  ],
  '5.where.md': [
    {'prompt': 'Where'},
  ],
  '6.orderby.md': [
    {'prompt': 'Orderby'},
  ],
  '7.groupby.md': [
    {'prompt': 'Groupby'},
  ],
  '8.aggregate.md': [
    {'prompt': 'Aggregate'},
  ],
  '9.join.md': [
    {'prompt': 'Join'},
  ],
  '10.union.md': [
    {'prompt': 'Union'},
  ],
  '11.window.md': [
    {'prompt': 'Window'},
  ],
  '12.functions.md': [
    {'prompt': 'Functions'},
  ],
  '15.table-management.md': [
    {'prompt': 'Table Management'},
  ],
  '16.database-management.md': [
    {'prompt': 'Database Management'},
  ],
};

final lessons = [
  '0.toc.md',
  '1.insert.md',
  '2.select.md',
  '3.update.md',
  '4.delete.md',
  '5.where.md',
  '6.orderby.md',
  '7.groupby.md',
  '8.aggregate.md',
  '9.join.md',
  '10.union.md',
  '11.window.md',
  '12.functions.md',
  '15.table-management.md',
  '16.database-management.md',
];

Future<int> checkProgress() async {
  final lessonId = await Storage.instance.getSQLLesson();
  return lessonId ?? 0;
}

Future<String> loadData(lessonId) async {
  return await loadMarkdownContent(lessonId);
}

Future<String> loadMarkdownContent(int lessonId) async {
  try {
    String data = lesson;
    if (true) {
      String path = 'assets/lessons/sql/${lessons[lessonId]}';
      data = await rootBundle.loadString(path);
    }
    return data;
  } catch (e) {
    print("Error loading Markdown content: $e");
    return '';
  }
}
