import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState(false, false)) {
    on<AppAuthSignIn>((event, emit) => emit(AppState(true, state.isDarkMode)));
    on<AppAuthSignOut>(
        (event, emit) => emit(AppState(false, state.isDarkMode)));
    on<AppThemeUpdate>((event, emit) =>
        emit(AppState(state.isAuthenticated, !state.isDarkMode)));
  }

  @override
  void onChange(Change<AppState> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onEvent(AppEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onTransition(Transition<AppEvent, AppState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
