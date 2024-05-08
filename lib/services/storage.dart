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

  Future<String?> getSqlStep() async {
    final prefs = await _prefs;
    return prefs.getString('sql-step');
  }

  Future<void> setProblemCode(problemId, lang, code) async {
    final prefs = await _prefs;
    await prefs.setString('problemId-$lang-$problemId', code);
  }

  Future<void> setSqlStep(String step) async {
    // 1.1?
    //
    final prefs = await _prefs;
    prefs.setString('sql-step', step);
  }

  Future<void> setToken(authToken) async {
    final prefs = await _prefs;
    await prefs.setString('authToken', authToken);
    _cachedToken = authToken;
  }
}
