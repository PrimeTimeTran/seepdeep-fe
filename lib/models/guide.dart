import 'package:app/models/topic.dart';

class Guide {
  String? title;
  String? body;
  String? caption;
  String? description;
  List<Topic>? topics;

  Guide({
    this.title,
    this.body,
    this.caption,
    this.description,
    this.topics,
  });

  Guide.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        body = json['body'],
        caption = json['caption'],
        description = json['description'],
        topics = (json['topics'] as List<dynamic>?)
            ?.map((topicJson) => Topic.fromJson(topicJson))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'caption': caption,
      'description': description,
      'topics': topics?.map((topic) => topic.toJson()).toList(),
    };
  }
}
