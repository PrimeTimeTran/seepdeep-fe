import 'package:app/all.dart';

class Problem {
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
  List<String>? constraints;
  List<Map<String, String>>? similar;

  String? editorialBody;
  User? editorialAuthor;
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
  Map<String, String>? signature;
  List<Map<String, dynamic>>? testSuite;
  Problem({
    this.id,
    this.title,
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
    this.testSuite,
    this.signature,
  });
  Problem.fromJson(Map<String, dynamic> json) {
    Map<String, String>? signature;
    if (json.containsKey('signature') && json['signature'] != null) {
      if (json['signature'] is Map<String, String>) {
        signature = json['signature'];
      } else {
        print(
            'Error: The value associated with "signature" key is not a Map<String, String>.');
      }
    } else {
      print('Error: The "signature" key is missing or its value is null.');
    }

    id = json['id'];
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
    signature = signature;
    testSuite =
        (json['testSuite'] as List<dynamic>?)?.cast<Map<String, dynamic>>();
  }
  // Problem.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       title = json['title'],
  //       numLC = json['numLC'],
  //       body = json['body'],
  //       topics = (json['topics'] as List<dynamic>?)
  //           ?.map((topicJson) => Topic.fromJson(topicJson))
  //           .toList(),
  //       isPublished = json['isPublished'],
  //       isSubmitted = json['isSubmitted'],
  //       author = User.fromJson(json['author']),
  //       hints = (json['hints'] as List<dynamic>?)?.cast<String>(),
  //       constraints = (json['constraints'] as List<dynamic>?)?.cast<String>(),
  //       similar =
  //           (json['similar'] as List<dynamic>?)?.cast<Map<String, String>>(),
  //       editorialBody = json['editorialBody'],
  //       editorialAuthor = User.fromJson(json['editorialAuthor']),
  //       editorialRating = json['editorialRating'],
  //       editorialVotes = json['editorialVotes']?.cast<String, int>(),
  //       frequency = json['frequency'],
  //       difficulty = json['difficulty'],
  //       accepted = json['accepted'],
  //       submissions = json['submissions'],
  //       acceptanceRate = json['acceptanceRate']?.toDouble(),
  //       signature = json['signature']?.cast<Map<String, String>>(),
  //       testSuite =
  //           (json['testSuite'] as List<dynamic>?)?.cast<Map<String, dynamic>>();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'numLC': numLC,
      'body': body,
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
      'testSuite': testSuite,
      'signature': signature,
    };
  }
}
