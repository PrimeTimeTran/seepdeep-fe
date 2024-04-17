// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const COLS = 80;
const END_NODE = '20,75';
const KNEWS = "cce242e028864b98b729032f7d9d3d6f";
const ROWS = 40;

const START_NODE = '20,5';

final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

final material3Notifier = ValueNotifier<bool>(true);

List<NewsTopic> newsTopics = [
  NewsTopic(name: "AI", avatar: "NewsTopic.png"),
  NewsTopic(name: "Data", avatar: "NewsTopic.png"),
  NewsTopic(name: "Health", avatar: "NewsTopic.png"),
  NewsTopic(name: "Sports", avatar: "NewsTopic.png"),
  NewsTopic(name: "Finance", avatar: "NewsTopic.png"),
  NewsTopic(name: "Science", avatar: "NewsTopic.png"),
  NewsTopic(name: "Business", avatar: "NewsTopic.png"),
  NewsTopic(name: "Startups", avatar: "NewsTopic.png"),
  NewsTopic(name: "Business", avatar: "NewsTopic.png"),
  NewsTopic(name: "Medicine", avatar: "NewsTopic.png"),
  NewsTopic(name: "Entertainment", avatar: "NewsTopic.png"),
  NewsTopic(name: "Technology", avatar: "NewsTopic.png"),
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

class NewsTopic {
  final String? name;
  final String? avatar;
  NewsTopic({this.name, this.avatar});
}

class Topic {
  final String? name;
  final String? avatar;
  Topic({this.name, this.avatar});
}
