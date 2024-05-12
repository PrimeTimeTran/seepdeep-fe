import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final Storage _instance = Storage._privateConstructor();
  static Storage get instance => _instance;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? _cachedToken;
  Storage._privateConstructor();

  Future<String> get token async {
    if (_cachedToken != null) {
      return _cachedToken!;
    }
    final prefs = await _prefs;
    _cachedToken = prefs.getString('authToken') ?? '';
    return _cachedToken!;
  }

  Future<String?> getProblemCode(problemId, lang, code) async {
    final prefs = await _prefs;
    return prefs.getString('problemId-$lang-$problemId');
  }

  Future<bool> getSqlIntroHide() async {
    final prefs = await _prefs;
    return prefs.getBool('introSqlHide') ?? false;
  }

  Future<int?> getSQLLesson() async {
    final prefs = await _prefs;
    return prefs.getInt('sql-lessonId');
  }

  Future<bool> getTheme() async {
    final prefs = await _prefs;
    return prefs.getBool('isLightMode') ?? true;
  }

  Future<void> setProblemCode(problemId, lang, code) async {
    final prefs = await _prefs;
    await prefs.setString('problemId-$lang-$problemId', code);
  }

  Future<void> setSqlIntroHide() async {
    final prefs = await _prefs;
    await prefs.setBool('introSqlHide', true);
  }

  Future<void> setSqlStep(int step) async {
    // 1.0 is new lesson, no items done.
    // 1.1 is one problem done.
    //
    final prefs = await _prefs;
    prefs.setInt('sql-lessonId', step);
  }

  Future<void> setTheme() async {
    final prefs = await _prefs;
    final curTheme = await getTheme();
    await prefs.setBool('isLightMode', !curTheme);
  }

  Future<void> setToken(authToken) async {
    final prefs = await _prefs;
    await prefs.setString('authToken', authToken);
    _cachedToken = authToken;
  }
}
