// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const COLS = 80;
const END_NODE = '20,75';
const ROWS = 40;
const START_NODE = '20,5';

final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

final material3Notifier = ValueNotifier<bool>(true);

List<News> newsList = [
  News(name: "Python", avatar: "News.png"),
  News(name: "Dart", avatar: "News.png"),
  News(name: "SQL", avatar: "News.png"),
  News(name: "Postgres", avatar: "News.png"),
  News(name: "MongoDB", avatar: "News.png"),
  News(name: "C", avatar: "News.png"),
  News(name: "C++", avatar: "News.png"),
  News(name: "C#", avatar: "News.png"),
  News(name: "Go", avatar: "News.png"),
  News(name: "Mojo", avatar: "News.png"),
  News(name: "Ruby", avatar: "News.png"),
  News(name: "Typescript", avatar: "News.png"),
  News(name: "Javascript", avatar: "News.png"),
  News(name: "Flutter", avatar: "News.png"),
  News(name: "Vue", avatar: "News.png"),
  News(name: "React", avatar: "News.png"),
  News(name: "React Native", avatar: "News.png"),
  News(name: "Nuxt", avatar: "News.png"),
  News(name: "Next", avatar: "News.png"),
  News(name: "Ruby on Rails", avatar: "News.png"),
  News(name: "Django", avatar: "News.png"),
  News(name: ".Net", avatar: "News.png"),
  News(name: "NodeJS", avatar: "News.png"),
  News(name: "Flask", avatar: "News.png"),
  News(name: "Kubernetes", avatar: "News.png"),
  News(name: "Docker", avatar: "News.png"),
  News(name: "Data Analysis", avatar: "News.png"),
  News(name: "Data Analytics", avatar: "News.png"),
  News(name: "LLM", avatar: "News.png"),
  News(name: "AI", avatar: "News.png"),
  News(name: "Machine Learning", avatar: "News.png"),
  News(name: "Theresa", avatar: "News.png"),
  News(name: "Una", avatar: "News.png"),
  News(name: "Vanessa", avatar: "News.png"),
  News(name: "Victoria", avatar: "News.png"),
  News(name: "Wanda", avatar: "News.png"),
  News(name: "Wendy", avatar: "News.png"),
  News(name: "Yvonne", avatar: "News.png"),
  News(name: "Zoe", avatar: "News.png"),
];

List<Topic> topicList = [
  Topic(name: "Python", avatar: "Topic.png"),
  Topic(name: "Dart", avatar: "Topic.png"),
  Topic(name: "SQL", avatar: "Topic.png"),
  Topic(name: "Postgres", avatar: "Topic.png"),
  Topic(name: "MongoDB", avatar: "Topic.png"),
  Topic(name: "C", avatar: "Topic.png"),
  Topic(name: "C++", avatar: "Topic.png"),
  Topic(name: "C#", avatar: "Topic.png"),
  Topic(name: "Go", avatar: "Topic.png"),
  Topic(name: "Mojo", avatar: "Topic.png"),
  Topic(name: "Ruby", avatar: "Topic.png"),
  Topic(name: "Typescript", avatar: "Topic.png"),
  Topic(name: "Javascript", avatar: "Topic.png"),
  Topic(name: "Flutter", avatar: "Topic.png"),
  Topic(name: "Vue", avatar: "Topic.png"),
  Topic(name: "React", avatar: "Topic.png"),
  Topic(name: "React Native", avatar: "Topic.png"),
  Topic(name: "Nuxt", avatar: "Topic.png"),
  Topic(name: "Next", avatar: "Topic.png"),
  Topic(name: "Ruby on Rails", avatar: "Topic.png"),
  Topic(name: "Django", avatar: "Topic.png"),
  Topic(name: ".Net", avatar: "Topic.png"),
  Topic(name: "NodeJS", avatar: "Topic.png"),
  Topic(name: "Flask", avatar: "Topic.png"),
  Topic(name: "Kubernetes", avatar: "Topic.png"),
  Topic(name: "Docker", avatar: "Topic.png"),
  Topic(name: "Data Analysis", avatar: "Topic.png"),
  Topic(name: "Data Analytics", avatar: "Topic.png"),
  Topic(name: "LLM", avatar: "Topic.png"),
  Topic(name: "AI", avatar: "Topic.png"),
  Topic(name: "Machine Learning", avatar: "Topic.png"),
  Topic(name: "Theresa", avatar: "Topic.png"),
  Topic(name: "Una", avatar: "Topic.png"),
  Topic(name: "Vanessa", avatar: "Topic.png"),
  Topic(name: "Victoria", avatar: "Topic.png"),
  Topic(name: "Wanda", avatar: "Topic.png"),
  Topic(name: "Wendy", avatar: "Topic.png"),
  Topic(name: "Yvonne", avatar: "Topic.png"),
  Topic(name: "Zoe", avatar: "Topic.png"),
];

class News {
  final String? name;
  final String? avatar;
  News({this.name, this.avatar});
}

class Topic {
  final String? name;
  final String? avatar;
  Topic({this.name, this.avatar});
}
