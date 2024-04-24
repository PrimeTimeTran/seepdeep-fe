import 'package:app/all.dart';

class Note {
  User? user;
  String? body;
  Problem? problem;

  Note({
    this.user,
    this.body,
    this.problem,
  });

  Note.fromJson(Map<String, dynamic> json)
      : user = json['user'] != null ? User.fromJson(json['user']) : null,
        body = json['body'],
        problem =
            json['problem'] != null ? Problem.fromJson(json['problem']) : null;

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'body': body,
      'problem': problem?.toJson(),
    };
  }
}
