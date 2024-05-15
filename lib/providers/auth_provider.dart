import 'package:app/all.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _authenticated = false;
  AuthProvider({Map<String, dynamic>? user}) {
    if (user == null) return;
    setUser(user);
  }
  get isAuthenticated => _authenticated;
  get user => _user;

  getStreakDates() {
    Map<String, dynamic>? streak = _user?.streak;
    Map<DateTime, int> dateTimeDayTotals = {};
    DateTime parseDate(String dateString) {
      List<String> dateParts = dateString.split('/');
      int month = int.parse(dateParts[0]);
      int day = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
      year += (year < 100) ? 2000 : 0;
      return DateTime(year, month, day);
    }

    streak?.forEach((dateString, value) {
      DateTime date = parseDate(dateString);
      if (value is Map<String, dynamic> && value.containsKey("dayTotal")) {
        dateTimeDayTotals[date] = value["dayTotal"];
      }
    });
    return dateTimeDayTotals;
  }

  setAuthenticated(bool authenticated) {
    _authenticated = authenticated;
    notifyListeners();
  }

  setUser(u) {
    if (u == null) {
      _user = null;
      setAuthenticated(false);
    } else {
      _user = User.fromJson(u);
      setAuthenticated(true);
    }
  }
}
