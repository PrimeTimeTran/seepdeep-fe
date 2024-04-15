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
nums = [20, 13, 3, 3, 4, 5, 1, 2, 8, 7, 9, 0, 11]
def bubble_sort(nums):
  sorted = False

  while not sorted:
    sorted = True
    for i in range(len(nums) - 1):
      if nums[i] > nums[i + 1]:
        sorted = False
        nums[i], nums[i + 1] = nums[i + 1], nums[i]

  return nums
print('Bubble Sort:', bubble_sort(nums))
""";

final sqlController = CodeController(
  text: sqlQuery,
  language: sql,
);
var sqlQuery = """
SELECT * FROM tracks;
""";
getController(selectedLang) {
  switch (selectedLang) {
    case 'python':
      return pythonController;
    case 'dart':
      return dartController;
    default:
      return sqlController;
  }
}

getLanguage(selectedLang) {
  switch (selectedLang) {
    case 'python':
      return python;
    case 'dart':
      return dart;
    default:
      return sql;
  }
}
