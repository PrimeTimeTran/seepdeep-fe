import 'dart:convert';

import 'package:app/all.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class QuizProvider {
  // Low level: Remote server/local assets
  Future<List<MathProblem>> readData(topic) async {
    try {
      List<MathProblem> values = [];
      if (kDebugMode) {
        final response =
            await http.get(Uri.parse('http://localhost:8080/?category=$topic'));
        debugPrint('response.statusCode ${response.statusCode}');
        if (response.statusCode == 200) {
          final resp = jsonDecode(response.body);
          for (var question in resp['data']) {
            values.add(MathProblem.fromJson(question));
          }
          return values;
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        final json = await rootBundle.loadString('json/math/$topic.json');
        final Map<String, dynamic> data = await jsonDecode(json);
        for (var question in data['data']) {
          values.add(MathProblem.fromJson(question));
        }
        return values;
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return [];
  }
}

class QuizRepository {
  // Business Logic: Filtering...
  final QuizProvider quizProvider = QuizProvider();

  Future<List<MathProblem>> getQuizProblems(topic) async {
    List<MathProblem> data = await quizProvider.readData(topic);
    return data;
  }
}
