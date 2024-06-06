import 'package:app/all.dart';
import 'package:equatable/equatable.dart';

class QuizState extends Equatable {
  final bool isDone;
  final double score;
  final bool isError;
  final List problems;
  final int problemIdx;
  final bool isChallengeMode;
  final Problem? activeProblem;
  final List<Map<String, dynamic>> answers;
  final List<Map<String, dynamic>> graded;
  final Map<String, dynamic> activeAnswer;

  QuizState({
    this.problemIdx = 0,
    this.answers = const [],
    this.graded = const [],
    this.problems = const [],
    this.isChallengeMode = false,
    this.isDone = false,
    this.isError = false,
    this.score = 0.0,
    this.activeProblem,
    Map<String, dynamic>? activeAnswer,
  }) : activeAnswer = activeAnswer ?? {};

  @override
  List<Object?> get props => [
        isError,
        score,
        isDone,
        isChallengeMode,
        problemIdx,
        problems,
        answers,
        activeProblem,
        activeAnswer,
        graded
      ];

  QuizState copyWith({
    int? problemIdx,
    List? problems,
    bool? isChallengeMode,
    double? score,
    bool? isDone,
    bool? isError,
    Problem? activeProblem,
    Map<String, dynamic>? activeAnswer,
    List<Map<String, dynamic>>? answers,
    List<Map<String, dynamic>>? graded,
  }) {
    return QuizState(
      activeAnswer:
          activeAnswer ?? Map<String, dynamic>.from(this.activeAnswer),
      answers: answers ?? List<Map<String, dynamic>>.from(this.answers),
      graded: graded ?? List<Map<String, dynamic>>.from(this.graded),
      problems: problems ?? this.problems,
      problemIdx: problemIdx ?? this.problemIdx,
      isChallengeMode: isChallengeMode ?? this.isChallengeMode,
      isDone: isDone ?? this.isDone,
      isError: isError ?? this.isError,
      score: score ?? this.score,
      activeProblem: activeProblem ?? this.activeProblem,
    );
  }
}
