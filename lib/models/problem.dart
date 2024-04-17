import 'package:app/models/topic.dart';
import 'package:app/models/user.dart';

class Problem {
  String? title;
  int? numLC;
  String? body;
  List<Topic>? topics;
  bool? isPublished;
  bool? isSubmitted;
  User? author;
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
  String? frequency;
  String? difficulty;
  double? accepted;
  double? submissions;
  double? acceptanceRate;

  // Map of language and their tests to test the problem.
  Map<String, String>? bodyTests;

  List<Map<String, dynamic>>? testSuite;

  Problem({
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
  });

  // Problem.fromJson(Map<String, dynamic> json) {
  //   // Debug statements
  //   print('Title: $title');
  //   print('NumLC: $numLC');
  //   print('Body: $body');
  //   print('Topics: $topics');
  //   print('Is Published: $isPublished');
  //   print('Is Submitted: $isSubmitted');
  //   print('Author: $author');
  //   print('Hints: $hints');
  //   print('Constraints: $constraints');
  //   print('Similar: $similar');
  //   print('Editorial Body: $editorialBody');
  //   print('Editorial Author: $editorialAuthor');
  //   print('Editorial Rating: $editorialRating');
  //   print('Editorial Votes: $editorialVotes');
  //   print('Frequency: $frequency');
  //   print('Difficulty: $difficulty');
  //   print('Accepted: $accepted');
  //   print('Submissions: $submissions');
  //   print('Acceptance Rate: $acceptanceRate');
  //   print('Body Tests: $bodyTests');
  //   print('Test Suite: $testSuite');

  //   print(json);

  //   title = json['title'];
  //   numLC = json['numLC'];
  //   body = json['body'];
  //   topics = (json['topics'] as List<dynamic>?)
  //       ?.map((topicJson) => Topic.fromJson(topicJson))
  //       .toList();
  //   isPublished = json['isPublished'];
  //   isSubmitted = json['isSubmitted'];
  //   author = User.fromJson(json['author']);
  //   hints = (json['hints'] as List<dynamic>?)?.cast<String>();
  //   constraints = (json['constraints'] as List<dynamic>?)?.cast<String>();
  //   similar = (json['similar'] as List<dynamic>?)?.cast<Map<String, String>>();
  //   editorialBody = json['editorialBody'];
  //   editorialAuthor = User.fromJson(json['editorialAuthor']);
  //   editorialRating = json['editorialRating']?.toDouble();
  //   editorialVotes = json['editorialVotes']?.cast<String, int>();
  //   frequency = json['frequency']?.toDouble();
  //   difficulty = json['difficulty'];
  //   accepted = json['accepted'];
  //   submissions = json['submissions'];
  //   acceptanceRate = json['acceptanceRate']?.toDouble();
  //   bodyTests = json['bodyTests']?.cast<String, String>();
  //   testSuite =
  //       (json['testSuite'] as List<dynamic>?)?.cast<Map<String, dynamic>>();
  // }

  // Named constructor for JSON initialization
  Problem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        numLC = json['numLC'],
        body = json['body'],
        topics = (json['topics'] as List<dynamic>?)
            ?.map((topicJson) => Topic.fromJson(topicJson))
            .toList(),
        isPublished = json['isPublished'],
        isSubmitted = json['isSubmitted'],
        author = User.fromJson(json['author']),
        hints = (json['hints'] as List<dynamic>?)?.cast<String>(),
        constraints = (json['constraints'] as List<dynamic>?)?.cast<String>(),
        similar =
            (json['similar'] as List<dynamic>?)?.cast<Map<String, String>>(),
        editorialBody = json['editorialBody'],
        editorialAuthor = User.fromJson(json['editorialAuthor']),
        editorialRating = json['editorialRating'],
        editorialVotes = json['editorialVotes']?.cast<String, int>(),
        frequency = json['frequency'],
        difficulty = json['difficulty'],
        accepted = json['accepted'],
        submissions = json['submissions'],
        acceptanceRate = json['acceptanceRate']?.toDouble(),
        testSuite =
            (json['testSuite'] as List<dynamic>?)?.cast<Map<String, dynamic>>();

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}
