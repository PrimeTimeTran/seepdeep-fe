import 'dart:convert';

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProblemsProvider extends ChangeNotifier {
  List<Problem> _problems = [];
  final List<Problem> _allProblems = [];

  List<Problem> get problems => _problems;

  Future<void> fetchProblems() async {
    try {
      var response = await Api.get('problems');
      if (response is! List || response.isEmpty) {
        Glob.logE('Empty or invalid response, retrying...');
        response = await Api.get('problems');
      }
      _problems.clear();
      final problems =
          (response as List).map((e) => Problem.fromJson(e)).toList();
      problems.sort((a, b) {
        final aVal = a.numLC ?? double.infinity;
        final bVal = b.numLC ?? double.infinity;
        return aVal.compareTo(bVal);
      });
      _problems.addAll(problems);
      _allProblems.addAll(problems);
      notifyListeners();
    } catch (e) {
      Glob.logE('Error fetching Problems: $e');
      final response = await rootBundle.loadString("json/problems.json");
      final Map<String, dynamic> json = jsonDecode(response);
      final List<dynamic> data = json['data'];
      final problems = (data).map((e) => Problem.fromJson(e)).toList();
      problems.sort((a, b) {
        final aVal = a.numLC ?? double.infinity;
        final bVal = b.numLC ?? double.infinity;
        return aVal.compareTo(bVal);
      });
      _problems.addAll(problems);
      _allProblems.addAll(problems);
    }
  }

  Future<void> fetchProblemsByTopic(Topic topic) async {
    final response = await Api.get('problems?topicId=${topic.id}');
    _problems.clear();
    _problems
        .addAll((response as List).map((e) => Problem.fromJson(e)).toList());
    notifyListeners();
  }

  Future<void> resetProblems(Topic topic) async {
    _problems = List.from(_allProblems);
    notifyListeners();
  }

  Future<void> searchProblems(String title) async {
    final response = await Api.get('problems?title=$title');
    _problems.clear();
    _problems
        .addAll((response as List).map((e) => Problem.fromJson(e)).toList());
    notifyListeners();
  }
}
