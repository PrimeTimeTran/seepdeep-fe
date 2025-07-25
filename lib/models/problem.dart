import 'package:app/all.dart';

class Problem {
  String? type;
  String? id;
  String? title;
  String? body;
  String? frequency;
  String? difficulty;
  User? author;
  bool? isPublished;
  bool? isSubmitted;

  int? numLC;
  List<Topic>? topics;
  List<String>? hints;
  List<String>? urlImgs;
  List<String>? constraints;
  List<Map<String, String>>? similar;

  String? editorialBody;
  User? editorialAuthor;
  Signature? signature;

  double? editorialRating;
  // id of Voter as key, their vote as value. Maximum of 5.
  // In this way we don't have to create a new table for just votes
  // and we have the Object available client side to determine if current user has voted on this or not.
  Map<String, int>? editorialVotes;

  double? accepted;
  double? submissions;
  double? acceptanceRate;
  // Map of language and their tests to test the problem.
  Map<String, String>? bodyTests;
  List<Map<String, dynamic>>? testCases;

  Problem({
    this.id,
    this.type,
    this.title,
    this.urlImgs,
    this.numLC,
    this.body,
    this.topics,
    this.isPublished,
    this.isSubmitted,
    this.author,
    this.hints,
    this.constraints,
    this.similar,
    this.editorialBody,
    this.editorialAuthor,
    this.editorialRating,
    this.editorialVotes,
    this.frequency,
    this.difficulty,
    this.accepted,
    this.submissions,
    this.acceptanceRate,
    this.bodyTests,
    this.testCases,
    this.signature,
  });
  Problem.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> j = json['signature'];
    Signature signature = Signature(
      parameters: j['parameters'],
      returnType: j['returnType'],
    );
    id = json['id'];
    type = json['type'];
    urlImgs = json['urlImgs'];
    title = json['title'];
    numLC = json['numLC'];
    body = json['body'];
    topics = (json['topics'] as List<dynamic>?)
        ?.map((topicJson) => Topic.fromJson(topicJson))
        .toList();
    isPublished = json['isPublished'];
    isSubmitted = json['isSubmitted'];
    author = User.fromJson(json['author']);
    hints = (json['hints'] as List<dynamic>?)?.cast<String>();
    constraints = (json['constraints'] as List<dynamic>?)?.cast<String>();
    similar = (json['similar'] as List<dynamic>?)?.cast<Map<String, String>>();
    editorialBody = json['editorialBody'];
    editorialAuthor = User.fromJson(json['editorialAuthor']);
    editorialRating = json['editorialRating'];
    editorialVotes = json['editorialVotes']?.cast<String, int>();
    frequency = json['frequency'];
    difficulty = json['difficulty'];
    accepted = json['accepted'];
    submissions = json['submissions'];
    acceptanceRate = json['acceptanceRate']?.toDouble();
    this.signature = signature;
    testCases =
        (json['testCases'] as List<dynamic>?)?.cast<Map<String, dynamic>>();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'numLC': numLC,
      'body': body,
      'urlImgs': urlImgs,
      'topics': topics?.map((topic) => topic.toJson()).toList(),
      'isPublished': isPublished,
      'isSubmitted': isSubmitted,
      'author': author?.toJson(),
      'hints': hints,
      'constraints': constraints,
      'similar': similar,
      'editorialBody': editorialBody,
      'editorialAuthor': editorialAuthor?.toJson(),
      'editorialRating': editorialRating,
      'editorialVotes': editorialVotes,
      'frequency': frequency,
      'difficulty': difficulty,
      'accepted': accepted,
      'submissions': submissions,
      'acceptanceRate': acceptanceRate,
      'bodyTests': bodyTests,
      'testCases': testCases,
      'signature': signature,
    };
  }
}

class Signature {
  String returnType;
  List<dynamic> parameters;
  Signature({required this.parameters, required this.returnType});

  factory Signature.placeHolder() {
    return Signature(parameters: [], returnType: 'list');
  }
  Map<String, dynamic> toJson() {
    return {
      'returnType': returnType,
      'parameters': parameters,
    };
  }
}
