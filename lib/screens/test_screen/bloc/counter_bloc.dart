import 'package:app/screens/test_screen/bloc/counter_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(0, 0, 0)) {
    on<CounterIncrementPressed>((event, emit) =>
        emit(CounterState(state.count + 1, state.updates + 1, state.resets)));
    on<CounterDecrementPressed>((event, emit) =>
        emit(CounterState(state.count - 1, state.updates + 1, state.resets)));
    on<CounterResetPressed>((event, emit) =>
        emit(CounterState(0, state.updates + 1, state.resets + 1)));
  }

  @override
  void onChange(Change<CounterState> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onTransition(Transition<CounterEvent, CounterState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
