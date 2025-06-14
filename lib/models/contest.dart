import 'package:app/all.dart';

class Contest {
  String? body;
  String? title;
  Company? company;
  Company? sponsor;
  DateTime? end;
  DateTime? start;
  List<Problem>? problems;
  List<Submission>? submissions;
  List<Participant>? participants;

  Contest({
    this.body,
    this.title,
    this.company,
    this.sponsor,
    this.end,
    this.start,
    this.problems,
    this.submissions,
    this.participants,
  });

  Contest.fromJson(Map<String, dynamic> json)
      : body = json['body'],
        title = json['title'],
        company =
            json['company'] != null ? Company.fromJson(json['company']) : null,
        sponsor =
            json['sponsor'] != null ? Company.fromJson(json['sponsor']) : null,
        end = json['end'] != null ? DateTime.parse(json['end']) : null,
        start = json['start'] != null ? DateTime.parse(json['start']) : null,
        problems = (json['problems'] as List<dynamic>?)
            ?.map((problemJson) => Problem.fromJson(problemJson))
            .toList(),
        submissions = (json['submissions'] as List<dynamic>?)
            ?.map((submissionJson) => Submission.fromJson(submissionJson))
            .toList(),
        participants = (json['participants'] as List<dynamic>?)
            ?.map((participantJson) => Participant.fromJson(participantJson))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'body': body,
      'title': title,
      'company': company?.toJson(),
      'sponsor': sponsor?.toJson(),
      'end': end?.toIso8601String(),
      'start': start?.toIso8601String(),
      'problems': problems?.map((problem) => problem.toJson()).toList(),
      'submissions':
          submissions?.map((submission) => submission.toJson()).toList(),
      'participants':
          participants?.map((participant) => participant.toJson()).toList(),
    };
  }
}

class Participant {
  int? rank;
  User? user;
  int? score;
  int? rating;
  DateTime? time;
  Contest? contest;
  List<Problem>? problems;
  List<Submission>? submissions;

  Participant({
    this.time,
    this.rank,
    this.user,
    this.score,
    this.rating,
    this.contest,
    this.problems,
    this.submissions,
  });

  Participant.fromJson(Map<String, dynamic> json)
      : user = json['user'] != null ? User.fromJson(json['user']) : null,
        contest =
            json['contest'] != null ? Contest.fromJson(json['contest']) : null,
        time = json['time'] != null ? DateTime.parse(json['time']) : null,
        score = json['score'],
        rank = json['rank'],
        rating = json['rating'],
        problems = (json['problems'] as List<dynamic>?)
            ?.map((problemJson) => Problem.fromJson(problemJson))
            .toList(),
        submissions = (json['submissions'] as List<dynamic>?)
            ?.map((submissionJson) => Submission.fromJson(submissionJson))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'contest': contest?.toJson(),
      'time': time?.toIso8601String(),
      'score': score,
      'rank': rank,
      'rating': rating,
      'problems': problems?.map((problem) => problem.toJson()).toList(),
      'submissions':
          submissions?.map((submission) => submission.toJson()).toList(),
    };
  }
}

class Ranking {
  String? type;
  Contest? contest;
  User? user;
  int? score;
  int? finishTime;
  int? rank;
  int? q1;
  int? q2;
  int? q3;
  int? q4;

  Ranking({
    this.type,
    this.contest,
    this.user,
    this.score,
    this.finishTime,
    this.rank,
    this.q1,
    this.q2,
    this.q3,
    this.q4,
  });

  Ranking.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        contest =
            json['contest'] != null ? Contest.fromJson(json['contest']) : null,
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        score = json['score'],
        finishTime = json['finishTime'],
        rank = json['rank'],
        q1 = json['q1'],
        q2 = json['q2'],
        q3 = json['q3'],
        q4 = json['q4'];

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'contest': contest?.toJson(),
      'user': user?.toJson(),
      'score': score,
      'finishTime': finishTime,
      'rank': rank,
      'q1': q1,
      'q2': q2,
      'q3': q3,
      'q4': q4,
    };
  }
}
