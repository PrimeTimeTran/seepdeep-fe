import 'dart:convert';

import 'package:app/models/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProblemProvider extends ChangeNotifier {
  Problem _focusedProblem = Problem.fromJson(
    {
      "_id": "66367f5e0d552cf0a90e85e9",
      "title": "Two Sum",
      "acceptanceRate": 52.4,
      "accepted": 12.9,
      "author": {
        "urlAvatar": "https://avatars.leetcode.com/u/12345",
        "username": "PrimeTimeTran"
      },
      "body":
          "Given an array of integers and a target value, determine if there are two numbers that add up to the target. You may assume that each input would have exactly one solution, and you may not use the same element twice.",
      "constraints": [],
      "difficulty": "Easy",
      "editorialAuthor": {
        "urlAvatar": "https://avatars.leetcode.com/u/9876",
        "username": "PrimeTimeTran"
      },
      "editorialBody":
          "Solutions include a brute force approach, using a hash table for efficient lookups, or sorting with two pointers.",
      "editorialRating": 4.5,
      "editorialVotes": {"1": 5, "2": 4},
      "frequency": "High",
      "hints": [],
      "isPublished": true,
      "isSubmitted": true,
      "numLC": 1,
      "similar": [
        {"difficulty": "Medium", "_id": 2, "title": "3 Sum"}
      ],
      "submissions": 24.6,
      "testCases": [
        {
          "output": [0, 1],
          "explanation": "",
          "inputs": {
            "nums": [2, 7, 11, 15],
            "target": 9
          }
        },
        {
          "output": [1, 2],
          "explanation": "",
          "inputs": {
            "nums": [3, 2, 4],
            "target": 6
          }
        },
        {
          "output": [0, 1],
          "explanation": "",
          "inputs": {
            "nums": [3, 3],
            "target": 6
          }
        }
      ],
      "signature": {
        "parameters": [
          {"type": "List[int]", "name": "nums"},
          {"type": "int", "name": "target"}
        ],
        "returnType": "List[int]"
      }
    },
  );
  List<Problem> problems = [];
  ProblemProvider();

  Problem get focusedProblem => _focusedProblem;

  Future<Problem> checkUrl() async {
    final uri = Uri.base;
    final pathSegments = uri.pathSegments;
    if (pathSegments.length >= 2 && pathSegments[0] == 'problem') {
      final routeProblemName = pathSegments[1];
      final defaultProblem =
          _focusedProblem.title?.replaceAll(' ', '-').toLowerCase();
      if (defaultProblem != routeProblemName) {
        await setByRouteUrl(routeProblemName);
      }
    }
    debugPrint(_focusedProblem.title);
    return _focusedProblem;
  }

  Future<Problem> findByRouteUrl(value) async {
    problems = await setProblems();
    final sought = problems.firstWhere((element) =>
        element.title?.replaceAll(' ', '-').toLowerCase() == value);
    return sought;
  }

  Future<void> loadProblems() async {
    problems = await setProblems();
    notifyListeners();
  }

  sampleProblems() {
    problems.shuffle();
    _focusedProblem = problems[0];
    notifyListeners();
  }

  setByRouteUrl(title) async {
    _focusedProblem = await findByRouteUrl(title);
    notifyListeners();
  }

  void setFocusedProblem(Problem problem) {
    _focusedProblem = problem;
    notifyListeners();
  }

  Future<List<Problem>> setProblems() async {
    final json = await rootBundle.loadString("json/problems.json");
    final Map<String, dynamic> data = jsonDecode(json);
    final List<dynamic> fetchedProblems = data['data'];
    List<Problem> res =
        fetchedProblems.map((item) => Problem.fromJson(item)).toList();
    notifyListeners();
    return res;
  }
}
