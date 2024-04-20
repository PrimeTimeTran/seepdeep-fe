import 'package:app/models/comment.dart';
import 'package:app/models/user.dart';

class Article {
  String? type; // news, original, tutorial, announcement, review
  String? title;
  String? caption;
  String? body;
  String? link;
  String? urlCoverImg;
  String? urlVideo;
  String? language;

  int? numComments;
  int? numVotes;
  DateTime? publishDate;
  bool? isPublished;
  bool? isOriginal; // Was this published on CSGems first?

  User? author;
  List<int>? voterIds;
  List<Comment>? comments;
  Article({
    this.type,
    this.author,
    this.title,
    this.caption,
    this.body,
    this.link,
    this.urlCoverImg,
    this.urlVideo,
    this.isPublished,
    this.publishDate,
    this.language,
    this.comments,
    this.numComments,
    this.voterIds,
    this.numVotes,
    this.isOriginal,
  });

  Article.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        author = json['author'] != null ? User.fromJson(json['author']) : null,
        title = json['title'],
        caption = json['caption'],
        body = json['body'],
        link = json['link'],
        urlCoverImg = json['urlCoverImg'],
        urlVideo = json['urlVideo'],
        isPublished = json['isPublished'],
        publishDate = json['publishDate'] != null
            ? DateTime.parse(json['publishDate'])
            : null,
        language = json['language'],
        comments = (json['comments'] as List<dynamic>?)
            ?.map((commentJson) => Comment.fromJson(commentJson))
            .toList(),
        numComments = json['numComments'],
        voterIds = (json['voterIds'] as List<dynamic>?)?.cast<int>(),
        numVotes = json['numVotes'],
        isOriginal = json['isOriginal'];

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'author': author?.toJson(),
      'title': title,
      'caption': caption,
      'body': body,
      'link': link,
      'urlCoverImg': urlCoverImg,
      'urlVideo': urlVideo,
      'isPublished': isPublished,
      'publishDate': publishDate?.toIso8601String(),
      'language': language,
      'comments': comments?.map((comment) => comment.toJson()).toList(),
      'numComments': numComments,
      'voterIds': voterIds,
      'numVotes': numVotes,
      'isOriginal': isOriginal,
    };
  }
}
