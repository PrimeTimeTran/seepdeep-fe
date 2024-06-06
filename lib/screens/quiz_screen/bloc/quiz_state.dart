import 'package:app/all.dart';
import 'package:equatable/equatable.dart';

class QuizState extends Equatable {
  final bool isDone;
  final bool isError;
  final List problems;
  final int problemIdx;
  final bool isChallengeMode;
  final Problem? activeProblem;
  final List<Map<String, dynamic>> answers;
  final List<Map<String, dynamic>> graded;
  final Map<String, dynamic> activeAnswer;
  final Map<String, dynamic> finalScore;

  QuizState({
    this.problemIdx = 0,
    this.answers = const [],
    this.graded = const [],
    this.problems = const [],
    this.isChallengeMode = false,
    this.isDone = false,
    this.isError = false,
    this.activeProblem,
    Map<String, dynamic>? activeAnswer,
    Map<String, dynamic>? finalScore,
  })  : activeAnswer = activeAnswer ?? {},
        finalScore = finalScore ??
            {
              // "score": 1,
              // "countProblems": 100,
              // "countCorrect": 100,
            };

  @override
  List<Object?> get props => [
        isError,
        isDone,
        isChallengeMode,
        problemIdx,
        problems,
        answers,
        activeProblem,
        activeAnswer,
        graded,
        finalScore
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
    Map<String, dynamic>? finalScore,
    List<Map<String, dynamic>>? answers,
    List<Map<String, dynamic>>? graded,
  }) {
    return QuizState(
      activeAnswer:
          activeAnswer ?? Map<String, dynamic>.from(this.activeAnswer),
      finalScore: finalScore ?? Map<String, dynamic>.from(this.finalScore),
      answers: answers ?? List<Map<String, dynamic>>.from(this.answers),
      graded: graded ?? List<Map<String, dynamic>>.from(this.graded),
      problems: problems ?? this.problems,
      problemIdx: problemIdx ?? this.problemIdx,
      isChallengeMode: isChallengeMode ?? this.isChallengeMode,
      isDone: isDone ?? this.isDone,
      isError: isError ?? this.isError,
      activeProblem: activeProblem ?? this.activeProblem,
    );
  }
}
