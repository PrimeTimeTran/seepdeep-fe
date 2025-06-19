import 'package:app/all.dart';
import 'package:flutter/material.dart';

class SolvesProvider extends ChangeNotifier {
  final List<Solve> _solves = [];

  List<Solve> get solves => _solves;

  Future<List<Solve>?> fetchSolves() async {
    try {
      final response = await Api.get('solves');
      _solves.clear();
      _solves.addAll((response as List).map((e) => Solve.fromJson(e)).toList());
      notifyListeners();
    } catch (e) {
      print('Error fetching solves: $e');
    }
    return null;
  }
}
