import 'dart:convert';

import 'package:app/all.dart';

class Submission {
  String? id;
  String? userId; // <-- Add this line

  DateTime? createdAt;
  String? body;
  String? title;
  // For those which are public
  String? explanation;
  String? language;
  String? notes;

  User? user;
  DateTime? submitted;
  Problem? problem;
  Contest? contest;

  bool? isAccepted;
  bool? isShared;
  bool? isContest;

  int? penalty;
  int? numVotes;
  int? numComments;
  double? runTime;
  double? memoryUsage;
  double? beats;

  List<int>? voterIds;
  List<Topic>? topics;
  List<Comment>? comments;
  List<TestCase>? testCases;

  Submission({
    this.id,
    this.userId,
    this.user,
    this.body,
    this.submitted,
    this.problem,
    this.language,
    this.isAccepted,
    this.runTime,
    this.beats,
    this.notes,
    this.isShared,
    this.title,
    this.explanation,
    this.numVotes,
    this.voterIds,
    this.numComments,
    this.topics,
    this.comments,
    this.isContest,
    this.contest,
    this.penalty,
    this.memoryUsage,
    this.testCases,
    this.createdAt,
  });

  Submission.fromJson(Map<String, dynamic> json)
      : user = _parseUser(json['user']),
        userId = json['user'] is String ? json['user'] : (json['user']?['_id']),
        body = json['body'],
        createdAt = json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(),
        submitted = json['submitted'] != null
            ? DateTime.parse(json['submitted'])
            : null,
        problem = _parseProblem(json['problem']),
        language = json['language'],
        isAccepted = json['passing'] ?? false,
        runTime = json['runResult'] != null
            ? jsonDecode(json['runResult']['timeToComplete'])
            : 0.0,
        memoryUsage = json['runResult'] != null
            ? jsonDecode(json['runResult']['memoryUsedMB'])
            : 0.0,
        beats = json['beats']?.toDouble(),
        notes = json['notes'],
        isShared = json['isShared'],
        title = json['title'],
        explanation = json['explanation'],
        numVotes = json['numVotes'],
        voterIds =
            json['voterIds'] != null ? List<int>.from(json['voterIds']) : null,
        numComments = json['numComments'],
        topics = json['topics'] != null
            ? List<Topic>.from(json['topics'].map((x) => Topic.fromJson(x)))
            : null,
        comments = json['comments'] != null
            ? List<Comment>.from(
                json['comments'].map((x) => Comment.fromJson(x)))
            : null,
        isContest = json['isContest'],
        testCases = json['testCases'] != null
            ? List<TestCase>.from(
                json['testCases'].map((x) => TestCase.fromJSON(x)))
            : [],
        contest =
            json['contest'] != null ? Contest.fromJson(json['contest']) : null,
        penalty = json['penalty'];

  factory Submission.placeholder(problemId, userId) {
    return Submission(
      user: userId,
      body: 'Placeholder body',
      title: 'Placeholder title',
      explanation: 'Placeholder explanation',
      language: 'Placeholder language',
      notes: 'Placeholder notes',
      submitted: DateTime.now(),
      problem: problemId,
      isAccepted: false,
      isShared: false,
      isContest: false,
      penalty: 0,
      numVotes: 0,
      numComments: 0,
      runTime: 0,
      memoryUsage: 0,
      beats: 0,
      voterIds: [],
      topics: [],
      comments: [],
      testCases: [],
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'body': body,
      'submitted': submitted?.toIso8601String(),
      'problem': problem?.toJson(),
      'language': language,
      'isAccepted': isAccepted,
      'runTime': runTime,
      'beats': beats,
      'notes': notes,
      'isShared': isShared,
      'title': title,
      'explanation': explanation,
      'numVotes': numVotes,
      'voterIds': voterIds,
      'numComments': numComments,
      'topics': topics?.map((topic) => topic.toJson()).toList(),
      'comments': comments?.map((comment) => comment.toJson()).toList(),
      'isContest': isContest,
      'contest': contest?.toJson(),
      'penalty': penalty,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  static Problem? _parseProblem(dynamic json) {
    if (json == null) {
      return null;
    } else if (json is String) {
      return Problem(id: json);
    } else {
      return Problem.fromJson(json);
    }
  }

  static User? _parseUser(dynamic json) {
    if (json == null) {
      return null;
    } else if (json is String) {
      return User(id: json);
    } else {
      return User.fromJson(json);
    }
  }
}
