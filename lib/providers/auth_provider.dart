import 'package:app/all.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _authenticated = false;
  get isAuthenticated => _authenticated;
  get user => _user;

  setAuthenticated() {
    _authenticated = !_authenticated;
    notifyListeners();
  }

  setUser(User? u) {
    _user = u;
    setAuthenticated();
  }
}
