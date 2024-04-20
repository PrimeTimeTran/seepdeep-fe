// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const COLS = 80;
const END_NODE = '20,75';
const KNEWS = "cce242e028864b98b729032f7d9d3d6f";
const ROWS = 40;

const START_NODE = '20,5';

final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

final material3Notifier = ValueNotifier<bool>(true);

List<NewsTopic> newsTopics = [
  NewsTopic(name: "AI", avatar: "NewsTopic.png"),
  NewsTopic(name: "Data", avatar: "NewsTopic.png"),
  NewsTopic(name: "Health", avatar: "NewsTopic.png"),
  NewsTopic(name: "Sports", avatar: "NewsTopic.png"),
  NewsTopic(name: "Finance", avatar: "NewsTopic.png"),
  NewsTopic(name: "Science", avatar: "NewsTopic.png"),
  NewsTopic(name: "Business", avatar: "NewsTopic.png"),
  NewsTopic(name: "Startups", avatar: "NewsTopic.png"),
  NewsTopic(name: "Business", avatar: "NewsTopic.png"),
  NewsTopic(name: "Medicine", avatar: "NewsTopic.png"),
  NewsTopic(name: "Entertainment", avatar: "NewsTopic.png"),
  NewsTopic(name: "Technology", avatar: "NewsTopic.png"),
];

List<CSTopic> topicList = [
  CSTopic(name: "Python", avatar: "CSTopic.png"),
  CSTopic(name: "Dart", avatar: "CSTopic.png"),
  CSTopic(name: "SQL", avatar: "CSTopic.png"),
  CSTopic(name: "Postgres", avatar: "CSTopic.png"),
  CSTopic(name: "MongoDB", avatar: "CSTopic.png"),
  CSTopic(name: "C", avatar: "CSTopic.png"),
  CSTopic(name: "C++", avatar: "CSTopic.png"),
  CSTopic(name: "C#", avatar: "CSTopic.png"),
  CSTopic(name: "Go", avatar: "CSTopic.png"),
  CSTopic(name: "Mojo", avatar: "CSTopic.png"),
  CSTopic(name: "Ruby", avatar: "CSTopic.png"),
  CSTopic(name: "Typescript", avatar: "CSTopic.png"),
  CSTopic(name: "Javascript", avatar: "CSTopic.png"),
  CSTopic(name: "Flutter", avatar: "CSTopic.png"),
  CSTopic(name: "Vue", avatar: "CSTopic.png"),
  CSTopic(name: "React", avatar: "CSTopic.png"),
  CSTopic(name: "React Native", avatar: "CSTopic.png"),
  CSTopic(name: "Nuxt", avatar: "CSTopic.png"),
  CSTopic(name: "Next", avatar: "CSTopic.png"),
  CSTopic(name: "Ruby on Rails", avatar: "CSTopic.png"),
  CSTopic(name: "Django", avatar: "CSTopic.png"),
  CSTopic(name: ".Net", avatar: "CSTopic.png"),
  CSTopic(name: "NodeJS", avatar: "CSTopic.png"),
  CSTopic(name: "Flask", avatar: "CSTopic.png"),
  CSTopic(name: "Kubernetes", avatar: "CSTopic.png"),
  CSTopic(name: "Docker", avatar: "CSTopic.png"),
  CSTopic(name: "Data Analysis", avatar: "CSTopic.png"),
  CSTopic(name: "Data Analytics", avatar: "CSTopic.png"),
  CSTopic(name: "LLM", avatar: "CSTopic.png"),
  CSTopic(name: "AI", avatar: "CSTopic.png"),
  CSTopic(name: "Machine Learning", avatar: "CSTopic.png"),
  CSTopic(name: "Theresa", avatar: "CSTopic.png"),
  CSTopic(name: "Una", avatar: "CSTopic.png"),
  CSTopic(name: "Vanessa", avatar: "CSTopic.png"),
  CSTopic(name: "Victoria", avatar: "CSTopic.png"),
  CSTopic(name: "Wanda", avatar: "CSTopic.png"),
  CSTopic(name: "Wendy", avatar: "CSTopic.png"),
  CSTopic(name: "Yvonne", avatar: "CSTopic.png"),
  CSTopic(name: "Zoe", avatar: "CSTopic.png"),
];

var zMarkdownSource = """
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

class CSTopic {
  final String? name;
  final String? avatar;
  CSTopic({this.name, this.avatar});
}

class NewsTopic {
  final String? name;
  final String? avatar;
  NewsTopic({this.name, this.avatar});
}
