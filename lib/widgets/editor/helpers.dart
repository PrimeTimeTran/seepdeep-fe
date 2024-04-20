import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/sql.dart';

final dartController = CodeController(
  text: dartMain,
  language: dart,
);

var dartMain = """
void main() {
  print('Hello World');
}
""";

final pythonController = CodeController(
  text: pythonSort,
  language: python,
);
var pythonSort = """
def twoSum(nums, target):
  return [1,2]
""";
// var pythonSort = """
// nums = [20, 13, 3, 3, 4, 5, 1, 2, 8, 7, 9, 0, 11]
// def bubble_sort(nums, a):
//   sorted = False

//   while not sorted:
//     sorted = True
//     for i in range(len(nums) - 1):
//       if nums[i] > nums[i + 1]:
//         sorted = False
//         nums[i], nums[i + 1] = nums[i + 1], nums[i]

//   return nums
// bubble_sort(nums)
// """;

final sqlController = CodeController(
  text: sqlQuery,
  language: sql,
);
var sqlQuery = """
SELECT * FROM customers;
""";
getController(selectedLang) {
  switch (selectedLang) {
    case Languages.python:
      return pythonController;
    case Languages.dart:
      return dartController;
    default:
      return sqlController;
  }
}

getLanguage(selectedLang) {
  switch (selectedLang) {
    case Languages.python:
      return python;
    case 'dart':
      return dart;
    default:
      return sql;
  }
}

enum Languages { sql, python, dart }
