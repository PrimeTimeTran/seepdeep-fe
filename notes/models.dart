class Badge {
  int? year;
  int? month;
  String? name;
  String? imgUrl;
}

class BadgeItem {
  int? month;
  int? year;
  int? userId;
  DateTime? date;
  String? imgUrl;
}

class Comment {
  User? user;
  String? body;
  Problem? problem;
  Post? post;
  Comment? comment;
  List<Comment>? comments;
  int? numVotes;
}

class Company {
  String? name;
  String? industry;
}

class Contest {
  String? body;
  String? title;
  Company? company;
  Company? sponsor;
  DateTime? end;
  DateTime? start;
  List<Problem>? problems;
  List<Submission>? submissions;
  List<ContestParticipation>? participants;
}

class Ranking {
  Contest? contest;
  User? user;
  int? score;
  int? finishTime;
  int? rank;
  int? q1;
  int? q2;
  int? q3;
  int? q4;
}

class ContestParticipation {
  User? user;
  Contest? contest;
  DateTime? time;
  int? score;
  int? rank;
  int? rating;
  List<Problem>? problems;
  List<Submission>? submissions;
}

enum Difficulty { easy, medium, hard }

class Forum {}

class Job {
  String? title;
  String? description;
  String? requirements;
  String? salary;
  String? location;
  Company? company;
}

class LanguageScore {
  String? score;
  String? language;
}

class Note {
  String? body;
  String? userId;
  String? problemId;
}

class Post {
  User? user;
  String? title;
  String? body;
  DateTime? submitted;
  bool? isPublic;
  int? numVotes;
  int? numViews;
  int? numComments;
  List<Comment>? comments;
  List<Topic>? topics;
}

class Problem {
  String? status;
  String? title;
  String? body;
  String? solution;
  String? acceptance;
  Difficulty? difficult;
  double? frequency;
  int? accepted;
  int? submissions;
  double? acceptanceRate;
  List<Topic>? topics;
  int? elapsedTime;
}

class StudyGuide {
  String? title;
  String? body;
  String? caption;
  String? description;
  List<Topic>? topics;
}

class Submission {
  User? user;
  String? code;
  Problem? problem;
  DateTime? submitted;
  bool? isAccepted;
  String? language;
  double? runTime;
  double? beats;
  String? notes;

  bool? isShared;
  String? title;
  String? body;
  int? numVotes;
  int? numComments;
  List<Topic>? topics;
  List<Comment>? comments;

  bool? isContest;
  Contest? contest;
  int? penalty;
}

class Topic {
  String? name;
}

class TopicItem {
  String? name;
  int? postId;
  int? noteId;
  int? problemId;
  int? submissionId;
}

class User {
  // Personal
  String? username;
  String? firstName;
  String? lastName;
  String? location;
  int? rank;
  String? email;
  String? urlAvatar;
  String? urlPayPal;
  String? urlGithub;
  String? urlLinkedIn;
  String? urlPortfolio;
  List<String>? urls;
  Badge? activeBadge;

  // Community
  int? views;
  int? solutions;
  int? discuss;
  int? reputation;

  // Contests
  int? contestRating;
  int? globalRanking;
  int? attended;
  List<ContestParticipation>? contests;
  int? startYear;

  double? top;

  List<Badge>? badges;
  List<String>? websites;
  List<String>? activity;
  List<String>? contestRatings;

  // Learnings
  List<Submission>? problemsSolved;
  List<Note>? problemNotes;
  List<LanguageScore>? languages;
  List<Submission>? submissions;

  int? numAcceptedProblems;
  int? numSubmittedProblems;
  int? numAcceptedSubmissions;
  int? numSubmissions;
}
