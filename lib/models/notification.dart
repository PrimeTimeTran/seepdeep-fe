import 'package:app/all.dart';

class Notification {
  String? type;
  String? title;
  String? body;
  int? points;
  bool? isPublished;
  DateTime? date;
}

class NotificationItem {
  int? icon;
  bool? isRead;
  int? points;
  User? user;
  DateTime? date;
  // Notification Origin. A new post? A comment on a submission? A reply to comment?
  String? notifiableId;
  String? notifiableType;
  // update(New Guide, New feature, Contest Starting),
  // content(Post Created),
  // reply/comment(Post, Submission, Comment)
  String? type;
  Notification? notification;
}
