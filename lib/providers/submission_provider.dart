import 'package:app/all.dart';
import 'package:flutter/material.dart';

class SubmissionProvider extends ChangeNotifier {
  final List<Submission> _submissions = [];

  List<Submission> get submissions => _submissions;

  Future<List<Submission>?> fetchSubmissions(userId) async {
    try {
      final response = await Api.get('users/$userId');
      print('response $response');
      // final List<dynamic> data = response.toList();
      // _submissions = data.map((json) => Submission.fromJson(json)).toList();
      // return _submissions;
    } catch (e) {
      return null;
      print('Error fetching submissions: $e');
    }
    return null;
  }
}
