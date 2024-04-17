import 'package:app/models/all.dart';
import 'package:flutter/foundation.dart';

class ProblemProvider extends ChangeNotifier {
  Problem? _focusedProblem;
  List<Problem> problems = [];
  Problem? get focusedProblem => _focusedProblem;

  Future<void> loadProblems() async {
    notifyListeners();
  }

  void setFocusedProblem(Problem problem) {
    _focusedProblem = problem;
    notifyListeners();
  }
}
