import 'package:flutter/material.dart';
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
  modifiers: [const TabModifier()],
);

// def add(a,b):
//   return a + b

// result = add(1,2)
// print(result)

var pythonSort = """
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        store = {}
        for idx, n in enumerate(nums):
            remainder = target - n
            if store.get(remainder) != None:
                return [store.get(remainder), idx]
            store[n] = idx
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
    case Language.python:
      return pythonController;
    case Language.dart:
      return dartController;
    default:
      return sqlController;
  }
}

getLanguage(selectedLang) {
  switch (selectedLang) {
    case Language.python:
      return python;
    case 'dart':
      return dart;
    default:
      return sql;
  }
}

enum Language { python, cpp, js, ts, dart }

class TabModifier extends CodeModifier {
  const TabModifier() : super('\t');

  @override
  TextEditingValue? updateString(
      String text, TextSelection sel, EditorParams params) {
    final tmp = replace(text, sel.start, sel.end, " " * params.tabSpaces);
    return tmp;
  }
}
