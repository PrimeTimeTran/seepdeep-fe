import 'package:app/all.dart';

class Comment {
  String? body;
  String? code;
  int? numVotes;
  Comment? comment; // The comment this comment is replying to

  User? user;
  Post? post;
  Article? article;
  Problem? problem;
  Submission? submission;

  List<Comment>? comments; // The replies this comment got.
  List<int>? voterIds;

  Comment({
    this.body,
    this.user,
    this.post,
    this.article,
    this.comment,
    this.problem,
    this.submission,
    this.comments,
    this.numVotes,
    this.voterIds,
    this.code,
  });

  Comment.fromJson(Map<String, dynamic> json)
      : body = json['body'],
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        post = json['post'] != null ? Post.fromJson(json['post']) : null,
        article =
            json['article'] != null ? Article.fromJson(json['article']) : null,
        comment =
            json['comment'] != null ? Comment.fromJson(json['comment']) : null,
        problem =
            json['problem'] != null ? Problem.fromJson(json['problem']) : null,
        submission = json['submission'] != null
            ? Submission.fromJson(json['submission'])
            : null,
        comments = (json['comments'] as List<dynamic>?)
            ?.map((commentJson) => Comment.fromJson(commentJson))
            .toList(),
        numVotes = json['numVotes'],
        voterIds = (json['voterIds'] as List<dynamic>?)?.cast<int>(),
        code = json['code'];

  Map<String, dynamic> toJson() {
    return {
      'body': body,
      'user': user?.toJson(),
      'post': post?.toJson(),
      'article': article?.toJson(),
      'comment': comment?.toJson(),
      'problem': problem?.toJson(),
      'submission': submission?.toJson(),
      'comments': comments?.map((comment) => comment.toJson()).toList(),
      'numVotes': numVotes,
      'voterIds': voterIds,
      'code': code,
    };
  }
}
