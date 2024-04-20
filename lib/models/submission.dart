import 'package:app/models/comment.dart';
import 'package:app/models/contest.dart';
import 'package:app/models/problem.dart';
import 'package:app/models/topic.dart';
import 'package:app/models/user.dart';

class Submission {
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
  double? beats;

  List<int>? voterIds;
  List<Topic>? topics;
  List<Comment>? comments;

  Submission({
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
  });

  Submission.fromJson(Map<String, dynamic> json)
      : user = json['user'] != null ? User.fromJson(json['user']) : null,
        body = json['body'],
        submitted = json['submitted'] != null
            ? DateTime.parse(json['submitted'])
            : null,
        problem =
            json['problem'] != null ? Problem.fromJson(json['problem']) : null,
        language = json['language'],
        isAccepted = json['isAccepted'],
        runTime = json['runTime']?.toDouble(),
        beats = json['beats']?.toDouble(),
        notes = json['notes'],
        isShared = json['isShared'],
        title = json['title'],
        explanation = json['explanation'],
        numVotes = json['numVotes'],
        voterIds = (json['voterIds'] as List<dynamic>?)?.cast<int>(),
        numComments = json['numComments'],
        topics = (json['topics'] as List<dynamic>?)
            ?.map((topicJson) => Topic.fromJson(topicJson))
            .toList(),
        comments = (json['comments'] as List<dynamic>?)
            ?.map((commentJson) => Comment.fromJson(commentJson))
            .toList(),
        isContest = json['isContest'],
        contest =
            json['contest'] != null ? Contest.fromJson(json['contest']) : null,
        penalty = json['penalty'];

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}
