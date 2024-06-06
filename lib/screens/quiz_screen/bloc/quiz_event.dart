class NextButtonPress extends QuizEvent {}

class PrevButtonPress extends QuizEvent {}

abstract class QuizEvent {}

class QuizProblemsFetched extends QuizEvent {
  List problems;
  QuizProblemsFetched(this.problems);
}

class QuizScreenLoad extends QuizEvent {
  String category;
  QuizScreenLoad(this.category);
}
