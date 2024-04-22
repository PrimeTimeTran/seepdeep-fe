import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _authenticated = false;
  get isAuthenticated => _authenticated;
  setAuthenticated() {
    _authenticated = !_authenticated;
    notifyListeners();
  }
}
