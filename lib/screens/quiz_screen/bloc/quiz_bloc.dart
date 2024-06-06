import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../quiz_provider.dart';
import 'all.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final _quizRepo = QuizRepository();
  QuizBloc() : super(QuizState()) {
    on<QuizScreenLoad>((event, emit) async {
      List<MathProblem> problems =
          await _quizRepo.getQuizProblems(event.category);
      List<Map<String, dynamic>> answers = problems.map((el) {
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
    on<FinishQuizButtonPress>((event, emit) {
      emit(state.copyWith(isDone: true));
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
      // Create a copy of activeAnswer and its nested structures
      final updatedActiveAnswer =
          Map<String, dynamic>.from(state.activeAnswer ?? {});

      // Ensure answers is initialized as a list if it's null
      updatedActiveAnswer['answers'] =
          List.from(updatedActiveAnswer['answers'] ?? []);

      // Update the specific nested value
      updatedActiveAnswer['answers'][event.index] =
          List.from(updatedActiveAnswer['answers'][event.index] ?? []);
      updatedActiveAnswer['answers'][event.index][event.multiIndex] =
          event.value;

      // Create a copy of answers with the updated activeAnswer
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
  }

  @override
  void onChange(Change<QuizState> change) {
    super.onChange(change);
    debugPrint('Change: $change');
  }

  @override
  void onEvent(QuizEvent event) {
    super.onEvent(event);
    debugPrint('Event: $event');
  }

  @override
  void onTransition(Transition<QuizEvent, QuizState> transition) {
    super.onTransition(transition);
    debugPrint('Transition: $transition');
  }
}
