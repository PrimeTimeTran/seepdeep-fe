part of 'app_bloc.dart';

class AppState extends Equatable {
  final bool isDarkMode;
  final bool isAuthenticated;

  const AppState(this.isAuthenticated, this.isDarkMode);

  @override
  List<Object?> get props => [isAuthenticated, isDarkMode];
}
