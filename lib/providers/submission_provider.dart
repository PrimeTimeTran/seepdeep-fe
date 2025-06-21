import 'package:app/all.dart';
import 'package:flutter/material.dart';

class SubmissionProvider extends ChangeNotifier {
  List<Submission> _submissions = [];

  List<Submission> get submissions => _submissions;

  Future<List<Submission>?> fetchSubmissions(userId) async {
    try {
      final response = await Api.get('users/$userId');
      final List<dynamic> data = response['submissions'].toList();
      _submissions = data.map((json) => Submission.fromJson(json)).toList();
      notifyListeners();
      return _submissions;
    } catch (e) {
      print('Error fetching submissions: $e');
      return null;
    }
    return null;
  }
}
