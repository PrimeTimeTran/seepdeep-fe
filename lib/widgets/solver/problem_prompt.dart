import 'package:app/models/all.dart';
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
`O(N^2)` Space & Time complexity# Bubble Sort
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

## Constraints
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

// ignore: must_be_immutable
class ProblemPrompt extends StatefulWidget {
  bool passing;
  Problem problem;
  bool submitted;
  ProblemPrompt({
    super.key,
    required this.problem,
    required this.passing,
    required this.submitted,
  });

  @override
  State<ProblemPrompt> createState() => _ProblemPromptState();
}

class _ProblemPromptState extends State<ProblemPrompt> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration.zero,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              tabs: [
                Row(
                  children: [
                    const Tab(
                      icon: Icon(Icons.notes),
                    ),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
                Row(
                  children: [
                    const Tab(
                      icon: Icon(Icons.edit_note),
                    ),
                    Text(
                      'Editorial',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
                Row(
                  children: [
                    const Tab(
                      icon: Icon(Icons.science_outlined),
                    ),
                    Text(
                      'Solutions',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
                Row(
                  children: [
                    const Tab(
                      icon: Icon(Icons.history),
                    ),
                    Text(
                      'Submissions',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ],
            ),
          )),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      widget.problem.title!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SelectableText(widget.problem.body!),
                    const SizedBox(height: 10),
                    const SelectableText("Example 1"),
                    const SizedBox(height: 10),
                    SelectableText(
                        widget.problem.testSuite![0]['input'].toString()),
                    const SizedBox(height: 10),
                    SelectableText(
                        widget.problem.testSuite![0]['output'].toString()),
                  ],
                ),
              ),
            ),
            const Icon(Icons.directions_transit),
            const Icon(Icons.directions_bike),
            const Icon(Icons.directions_boat_rounded),
          ],
        ),
      ),
    );
  }

  buildExamples(Problem problem) {
    return ListView.builder(
      itemCount: problem.testSuite!.length,
      itemBuilder: (BuildContext context, int idx) {
        final item = problem.testSuite![idx];
        return Column(children: [
          const SelectableText("Example 1"),
          const SizedBox(height: 10),
          SelectableText(item['input'].toString()),
          const SizedBox(height: 10),
          SelectableText(item['output'].toString()),
        ]);
      },
    );
  }
}
