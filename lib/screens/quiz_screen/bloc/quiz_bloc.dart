import 'package:app/all.dart';
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
      final activeAnswer = state.answers?[idx];
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
      final activeAnswer = state.answers?[idx];
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
      final activeAnswer = state.answers?[event.index];
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
      state.activeAnswer?['answers'][event.index] = event.value;
      state.answers?[state.problemIdx] = state.activeAnswer!;
      emit(state.copyWith(
        answers: state.answers,
        activeAnswer: state.activeAnswer,
      ));
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
