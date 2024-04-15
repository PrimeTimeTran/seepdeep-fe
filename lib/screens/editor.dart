// This example expands 01.minimal.dart by using CodeField
// instead of an ordinary TextField.
// This automatically adds the gutter, code folding, and basic autocompletion.

import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:highlight/languages/dart.dart';
import 'package:drift/drift.dart';

// import '../common/snippets.dart';

final controller = CodeController(
  text: pythonSort,
  language: dart,
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

class CodeEditor extends StatelessWidget {
  const CodeEditor({super.key});

  @override
  Widget build(BuildContext context) {
    //controller.visibleSectionNames = {'section1'};
    return CodeTheme(
      data: CodeThemeData(styles: vsTheme),
      child: SingleChildScrollView(
        child: CodeField(
          controller: controller,
        ),
      ),
    );
  }
}
