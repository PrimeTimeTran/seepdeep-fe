import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final Storage _instance = Storage._privateConstructor();
  static Storage get instance => _instance;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int? _cachedCount;
  String? _cachedToken;
  Storage._privateConstructor();

  Future<int> get count async {
    if (_cachedCount != null) {
      return _cachedCount!;
    }
    final prefs = await _prefs;
    _cachedCount = prefs.getInt('counter') ?? 0;
    return _cachedCount!;
  }

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

  Future<void> increment() async {
    final prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
    await prefs.setInt('counter', counter);
    _cachedCount = counter;
  }

  Future<void> setProblemCode(problemId, lang, code) async {
    final prefs = await _prefs;
    await prefs.setString('problemId-$lang-$problemId', code);
  }

  Future<void> setToken(authToken) async {
    final prefs = await _prefs;
    await prefs.setString('authToken', authToken);
    _cachedToken = authToken;
  }
}
