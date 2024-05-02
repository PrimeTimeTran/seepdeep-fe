import 'package:app/models/all.dart';
import 'package:flutter/foundation.dart';

class ProblemProvider extends ChangeNotifier {
  Problem _focusedProblem = Problem.fromJson(
    {
      "id": '325eb55b0eeca014fcededbe',
      "acceptanceRate": 52.4,
      "accepted": 12.9,
      "author": {
        "urlAvatar": "https://avatars.leetcode.com/u/12345",
        "username": "ExperiencedCoder"
      },
      "body":
          "Given an array of integers and a target value, determine if there are two numbers that add up to the target. You may assume that each input would have exactly one solution, and you may not use the same element twice.",
      "constraints": [],
      "difficulty": "Easy",
      "editorialAuthor": {
        "urlAvatar": "https://avatars.leetcode.com/u/9876",
        "username": "LC_Solutions"
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
        {"difficulty": "Medium", "id": 2, "title": "3 Sum"}
      ],
      "submissions": 24.6,
      "testSuite": [
        {
          "input": [
            [2, 7, 11, 15],
            9
          ],
          "output": [0, 1]
        },
        {
          "input": [
            [3, 2, 4],
            6
          ],
          "output": [1, 2]
        },
        {
          "input": [
            [3, 3],
            6
          ],
          "output": [0, 1]
        }
      ],
      "title": "Two Sum",
      "topics": [
        {"name": "Array"},
        {"name": "Hash Table"}
      ],
      "signature": {
        "parameters": [
          {"type": "list", "name": "nums"},
          {"type": "int", "name": "target"}
        ],
        "returnType": "list"
      }
    },
  );
  List<Problem> problems = [];
  Problem get focusedProblem => _focusedProblem;

  Future<void> loadProblems() async {
    notifyListeners();
  }

  void setFocusedProblem(Problem problem) {
    _focusedProblem = problem;
    notifyListeners();
  }
}
