import 'dart:convert';

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProblemsProvider extends ChangeNotifier {
  final List<Problem> _problems = [];

  List<Problem> get problems => _problems;

  Future<void> fetchProblems() async {
    try {
      throw 'Error';
      final response = await Api.get('problems');
      _problems.clear();
      _problems
          .addAll((response as List).map((e) => Problem.fromJson(e)).toList());
      notifyListeners();
    } catch (e) {
      Glob.logE('Fetching Problems: $e');
      final response = await rootBundle.loadString("json/problems.json");
      final Map<String, dynamic> json = jsonDecode(response);
      final List<dynamic> data = json['data'];
      _problems.addAll((data).map((e) => Problem.fromJson(e)).toList());
    }
  }
}
