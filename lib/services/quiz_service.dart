import 'package:app/all.dart';

class QuizService {
  double finalScore = 0.0;
  List<MathProblem> problems;
  List<Map<String, dynamic>> graded = [];
  List<Map<String, dynamic>> answers = [];
  QuizService({
    required this.problems,
  }) {
    setupAnswerObj(problems);
  }

  getGrade(List<Map<String, dynamic>> answersFromWidget) {
    int right = 0;
    int totalAnswers = 0;
    for (var i = 0; i < problems.length; i++) {
      MathProblem problem = problems[i];
      for (var j = 0; j < (problem.answers?.length ?? 0); j++) {
        totalAnswers += 1;
        final correct = problem.answers?[j].toString() ==
            answersFromWidget[i]['answers'][j].toString();
        graded[i]['answers'][j] = correct;
        if (correct) {
          right += 1;
        }
      }
      for (var k = 0; k < (problem.followUpAnswers?.length ?? 0); k++) {
        totalAnswers += 1;
        final correct = problem.followUpAnswers?[k].toString() ==
            answersFromWidget[i]['followUpAnswers'][k].toString();
        graded[i]['followUpAnswers'][k] = correct;
        if (correct) {
          right += 1;
        }
      }
    }
    finalScore = double.parse((right / totalAnswers).toStringAsFixed(2));
  }

  setAnswer(problemIdx, idx, field, value) {
    answers[problemIdx][field][idx] = value;
  }

  setAnswers(newAnswers) {
    answers = newAnswers;
  }

  setupAnswerObj(values) {
    for (MathProblem element in values) {
      Map<String, dynamic> problem = {
        'problemId': element.id,
        // 'answers': List<dynamic>.generate(
        //   element.answers?.length ?? 0,
        //   (index) => null,
        // ),
        // 'followUpAnswers': List<dynamic>.generate(
        //   element.followUpAnswers?.length ?? 0,
        //   (index) => null,
        // ),
        'answers': List<dynamic>.generate(
          element.answers?.length ?? 0,
          (index) => element.answers?[0] is List ? ['', ''] : null,
        ),
        'followUpAnswers': List<dynamic>.generate(
          element.followUpAnswers?.length ?? 0,
          (index) => element.followUpAnswers?[0] is List ? ['', ''] : null,
        ),
      };
      graded.add(problem);
      answers.add(problem);
    }
  }
}
