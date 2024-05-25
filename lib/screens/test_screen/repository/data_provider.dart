import 'bloc_app.dart';

class AppProvider {
  final AppBloc _appBloc;

  AppProvider(this._appBloc);

  bool isAuthenticated() => _appBloc.state.isAuthenticated;
  bool isDarkMode() => _appBloc.state.isDarkMode;

  Future<List<String>> readData() async {
    return ['foo', 'bar', 'spam', 'ham'];
  }

  Future<void> signIn() async {
    _appBloc.add(AppAuthSignIn());
  }

  Future<void> signOut() async {
    _appBloc.add(AppAuthSignOut());
  }

  Future<void> toggleTheme() async {
    _appBloc.add(AppThemeUpdate());
  }
}

class DataProvider {
  Future<List<String>> readData() async {
    return ['foo', 'bar', 'spam', 'ham'];
  }
}
