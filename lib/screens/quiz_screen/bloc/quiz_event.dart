class AnswerProblem extends QuizEvent {
  int index;
  String value;
  AnswerProblem(this.index, this.value);
}

class FinishQuizButtonPress extends QuizEvent {}

class NextButtonPress extends QuizEvent {}

class PrevButtonPress extends QuizEvent {}

class ProblemSelectButtonPress extends QuizEvent {
  int index;
  ProblemSelectButtonPress(this.index);
}

abstract class QuizEvent {}

class QuizProblemsFetched extends QuizEvent {
  List problems;
  QuizProblemsFetched(this.problems);
}

class QuizScreenLoad extends QuizEvent {
  String category;
  QuizScreenLoad(this.category);
}
