import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    if (_isDarkMode != value) {
      _isDarkMode = value;
    }
  }

  void toggleTheme(dark) {
    _isDarkMode = dark;
    notifyListeners();
  }
}
