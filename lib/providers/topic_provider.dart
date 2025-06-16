import 'package:app/all.dart';
import 'package:flutter/material.dart';

class TopicProvider extends ChangeNotifier {
  final List<Topic> _topics = [];

  List<Topic> get topics => _topics;

  Future<void> fetchTopics() async {
    try {
      final response = await Api.get('topics');
      _topics.clear();
      _topics.addAll((response as List).map((e) => Topic.fromJson(e)).toList());
      notifyListeners();
    } catch (e) {
      print('Error fetching topics: $e');
    }
  }
}
