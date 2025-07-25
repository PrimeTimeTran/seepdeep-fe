import 'package:app/all.dart';

class Post {
  User? user;
  String? title;
  String? body;
  DateTime? submitted;
  bool? isPublished;
  int? numVotes;
  int? numViews;
  int? numComments;
  List<Topic>? topics;
  List<Comment>? comments;

  Post({
    this.user,
    this.title,
    this.body,
    this.submitted,
    this.isPublished,
    this.numVotes,
    this.numViews,
    this.numComments,
    this.topics,
    this.comments,
  });

  Post.fromJson(Map<String, dynamic> json)
      : user = json['user'] != null ? User.fromJson(json['user']) : null,
        title = json['title'],
        body = json['body'],
        submitted = json['submitted'] != null
            ? DateTime.parse(json['submitted'])
            : null,
        isPublished = json['isPublished'],
        numVotes = json['numVotes'],
        numViews = json['numViews'],
        numComments = json['numComments'],
        topics = (json['topics'] as List<dynamic>?)
            ?.map((topicJson) => Topic.fromJson(topicJson))
            .toList(),
        comments = (json['comments'] as List<dynamic>?)
            ?.map((commentJson) => Comment.fromJson(commentJson))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'title': title,
      'body': body,
      'submitted': submitted?.toIso8601String(),
      'isPublished': isPublished,
      'numVotes': numVotes,
      'numViews': numViews,
      'numComments': numComments,
      'topics': topics?.map((topic) => topic.toJson()).toList(),
      'comments': comments?.map((comment) => comment.toJson()).toList(),
    };
  }
}
