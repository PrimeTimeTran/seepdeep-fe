import 'dart:convert';

import 'package:app/all.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../quiz_provider.dart';
import 'all.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final _quizRepo = QuizRepository();
  QuizBloc() : super(QuizState()) {
    on<QuizScreenLoad>((event, emit) async {
      List<MathProblem> problems =
          await _quizRepo.getQuizProblems(event.category);
      List<Map<String, dynamic>> answers;
      if (!kDebugMode && false) {
        final json = await rootBundle.loadString('json/math/test.json');
        final Map<String, dynamic> data = jsonDecode(json);
        answers = (data['data'] as List).map((el) {
          return {
            'type': el['type'],
            'problemId': el['id'],
            'options': el['options'],
            'isMulti': el['answers']?[0] is List,
            'answers': el['answers'],
            'followUpAnswers': el['followupAnswers'],
          };
        }).toList();
      } else {
        answers = problems.map((el) {
          return {
            'type': el.type,
            'problemId': el.id,
            'options': el.options,
            'isMulti': el.answers?[0] is List,
            'answers': List<dynamic>.generate(
              el.answers?.length ?? 0,
              (index) => el.answers?[0] is List ? ['', ''] : '',
            ),
            'followUpAnswers': List<dynamic>.generate(
              el.followUpAnswers?.length ?? 0,
              (index) => el.followUpAnswers?[0] is List ? ['', ''] : '',
            ),
          };
        }).toList();
      }

      emit(
        state.copyWith(
          answers: answers,
          problems: problems,
          activeAnswer: answers.first,
          activeProblem: problems[0],
        ),
      );
    });
    on<NextButtonPress>((event, emit) {
      if (state.problemIdx + 1 == state.problems.length) return;
      int idx = state.problemIdx + 1;
      final activeAnswer = state.answers[idx];
      emit(
        state.copyWith(
          problemIdx: idx,
          activeAnswer: activeAnswer,
          activeProblem: state.problems[idx],
        ),
      );
    });
    on<PrevButtonPress>((event, emit) {
      if (state.problemIdx - 1 < 0) return;
      int idx = state.problemIdx - 1;
      final activeAnswer = state.answers[idx];
      emit(
        state.copyWith(
          problemIdx: idx,
          activeAnswer: activeAnswer,
          activeProblem: state.problems[idx],
        ),
      );
    });
    on<QuizProblemsFetched>((event, emit) {
      emit(
        state.copyWith(
          problems: event.problems,
          activeProblem: event.problems[0],
        ),
      );
    });
    on<ProblemSelectButtonPress>((event, emit) {
      final activeAnswer = state.answers[event.index];
      emit(
        state.copyWith(
          problemIdx: event.index,
          activeAnswer: activeAnswer,
          activeProblem: state.problems[event.index],
        ),
      );
    });
    on<AnswerProblem>((event, emit) {
      final updatedActiveAnswer = Map<String, dynamic>.from(state.activeAnswer);
      updatedActiveAnswer['answers'] =
          List<dynamic>.from(updatedActiveAnswer['answers'] ?? []);
      updatedActiveAnswer['answers'][event.index] = event.value;
      final updatedAnswers = List<Map<String, dynamic>>.from(state.answers);
      updatedAnswers[state.problemIdx] =
          Map<String, dynamic>.from(updatedActiveAnswer);

      emit(
        state.copyWith(
          answers: updatedAnswers,
          activeAnswer: updatedActiveAnswer,
        ),
      );
    });
    on<AnswerProblemMulti>((event, emit) {
      final updatedActiveAnswer = Map<String, dynamic>.from(state.activeAnswer);
      updatedActiveAnswer['answers'] =
          List.from(updatedActiveAnswer['answers'] ?? []);
      updatedActiveAnswer['answers'][event.index] =
          List.from(updatedActiveAnswer['answers'][event.index] ?? []);
      updatedActiveAnswer['answers'][event.index][event.multiIndex] =
          event.value;
      final updatedAnswers = List<Map<String, dynamic>>.from(state.answers);
      updatedAnswers[state.problemIdx] =
          Map<String, dynamic>.from(updatedActiveAnswer);

      emit(
        state.copyWith(
          answers: updatedAnswers,
          activeAnswer: updatedActiveAnswer,
        ),
      );
    });
    on<FinishQuizButtonPress>((event, emit) {
      int right = 0;
      int problemCount = 0;
      List<Map<String, dynamic>> answers = state.answers;
      for (var i = 0; i < answers.length; i++) {
        MathProblem problem = state.problems[i];
        Map<String, dynamic> answer = answers[i];
        for (int index = 0; index < answer['answers'].length; index++) {
          if (answer['isMulti']) {
            answer['answers'][index].map((answerValue) {
              final correct =
                  problem.answers?[index].toString() == answerValue.toString();
              problemCount += 1;
              if (correct) {
                right += 1;
              }
            });
          } else {
            final answerValue = answer['answers'][0];
            final correct =
                problem.answers?[0].toString() == answerValue.toString();
            problemCount += 1;
            if (correct) {
              right += 1;
            }
          }
        }
      }
      final finalScore =
          double.parse((right / problemCount).toStringAsFixed(2));

      Map<String, dynamic> scoreMap = {
        'score': finalScore,
        'countCorrect': right,
        'countProblems': problemCount,
      };
      // TODO: Send score to API
      emit(state.copyWith(isDone: true, finalScore: scoreMap));
    });
    on<RetakeQuiz>((event, emit) {
      List<Map<String, dynamic>> answers = state.problems.map((el) {
        return {
          'type': el.type,
          'problemId': el.id,
          'options': el.options,
          'isMulti': el.answers?[0] is List,
          'answers': List<dynamic>.generate(
            el.answers?.length ?? 0,
            (index) => el.answers?[0] is List ? ['', ''] : '',
          ),
          'followUpAnswers': List<dynamic>.generate(
            el.followUpAnswers?.length ?? 0,
            (index) => el.followUpAnswers?[0] is List ? ['', ''] : '',
          ),
        };
      }).toList();
      emit(
        state.copyWith(
          isDone: false,
          problemIdx: 0,
          answers: answers,
        ),
      );
    });
  }

  @override
  void onChange(Change<QuizState> change) {
    super.onChange(change);
    // debugPrint('Change: $change');
  }

  @override
  void onEvent(QuizEvent event) {
    super.onEvent(event);
    // debugPrint('Event: $event');
  }

  @override
  void onTransition(Transition<QuizEvent, QuizState> transition) {
    super.onTransition(transition);
    // debugPrint('Transition: $transition');
  }
}
