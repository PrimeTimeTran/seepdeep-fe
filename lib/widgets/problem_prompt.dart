import 'package:app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
import 'package:flutter_highlighter/themes/atom-one-light.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:markdown/markdown.dart' as md;

// Problem Requirements
// 1. Name
// 2. Prompt/Description
// 3. Examples
// 4. Answer
// 5. Tests

var markdownSource = """
# Bubble Sort
A sorting algorithm.

## Description
Your goal is to sort all the items in the list.

```python
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
bubble_sort(nums)
```

## Example 1
```python
Input: [20, 13, 3, 3, 4, 5, 1, 2, 8, 7, 9, 0, 11]
Output: [0, 1, 2, 3, 3, 4, 5, 7, 8, 9, 11, 13, 20]
```

## Example 2
```python
Input: [20, 13, 3, 3, 4, 5, 1, 2, 8, 7, 9, 0, 11]
Output: [0, 1, 2, 3, 3, 4, 5, 7, 8, 9, 11, 13, 20]
```

## Example 3
```python
Input: [20, 13, 3, 3, 4, 5, 1, 2, 8, 7, 9, 0, 11]
Output: [0, 1, 2, 3, 3, 4, 5, 7, 8, 9, 11, 13, 20]
```

## Requirements
`O(N^2)` Space & Time complexity
""";

class CodeElementBuilder extends MarkdownElementBuilder {
  getTheme() {
    return MediaQueryData.fromView(WidgetsBinding.instance.window)
                .platformBrightness ==
            Brightness.light
        ? atomOneDarkTheme
        : atomOneLightTheme;
  }

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    String language = '';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }
    return SizedBox(
      width: getWidth(),
      child: HighlightView(
        element.textContent,
        theme: getTheme(),
        language: language,
        textStyle: GoogleFonts.robotoMono(),
      ),
    );
  }
}

class ProblemPrompt extends StatefulWidget {
  const ProblemPrompt({super.key});

  @override
  State<ProblemPrompt> createState() => _ProblemPromptState();
}

class _ProblemPromptState extends State<ProblemPrompt> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Markdown(
      selectable: true,
      data: markdownSource,
      builders: {
        'code': CodeElementBuilder(),
      },
    );
  }
}
