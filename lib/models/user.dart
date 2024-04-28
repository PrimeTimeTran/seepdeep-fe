import 'package:app/all.dart';

class LanguageScore {
  String? score;
  String? language;

  LanguageScore({
    this.score,
    this.language,
  });

  LanguageScore.fromJson(Map<String, dynamic> json)
      : score = json['score'],
        language = json['language'];

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'language': language,
    };
  }
}

class User {
  int? rank;
  String? email;
  String? phone;
  String? username;
  String? firstName;
  String? lastName;
  String? location;
  String? urlAvatar;
  String? urlPayPal;
  String? urlGithub;
  String? urlLinkedIn;
  String? urlPortfolio;
  String? urlCSProfile;
  Badge? activeBadge;
  List<String>? siteUrls;

  // Community
  int? views;
  int? discuss;
  int? solutions;
  int? reputation;

  // Contests
  int? contestRating;
  int? globalRanking;
  int? attended;
  List<Participant>? contests;
  int? startYear;

  double? top;

  List<Badge>? badges;
  List<String>? activity;
  List<String>? contestRatings;

  // Learnings
  List<Note>? notes;
  List<Solve>? solved;
  List<Submission>? submissions;
  List<LanguageScore>? languages;

  int? numSubmissions;
  int? numAcceptedProblems;
  int? numSubmittedProblems;
  int? numAcceptedSubmissions;

  String? gender;
  String? avatar;

  User({
    this.rank,
    this.email,
    this.phone,
    this.username,
    this.firstName,
    this.lastName,
    this.location,
    this.urlAvatar,
    this.urlPayPal,
    this.urlGithub,
    this.urlLinkedIn,
    this.urlPortfolio,
    this.urlCSProfile,
    this.siteUrls,
    this.activeBadge,
    this.views,
    this.discuss,
    this.solutions,
    this.reputation,
    this.contestRating,
    this.globalRanking,
    this.attended,
    this.contests,
    this.startYear,
    this.top,
    this.badges,
    this.activity,
    this.contestRatings,
    this.notes,
    this.solved,
    this.languages,
    this.submissions,
    this.numAcceptedProblems,
    this.numSubmittedProblems,
    this.numAcceptedSubmissions,
    this.numSubmissions,
    this.gender,
    this.avatar,
  });

  User.fromJson(Map<String, dynamic> json)
      : rank = json['rank'],
        email = json['email'],
        phone = json['phone'],
        username = json['username'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        location = json['location'],
        urlAvatar = json['urlAvatar'],
        urlPayPal = json['urlPayPal'],
        urlGithub = json['urlGithub'],
        urlLinkedIn = json['urlLinkedIn'],
        urlPortfolio = json['urlPortfolio'],
        urlCSProfile = json['urlCSProfile'],
        siteUrls = json['siteUrls']?.cast<String>(),
        activeBadge = json['activeBadge'] != null
            ? Badge.fromJson(json['activeBadge'])
            : null,
        views = json['views'],
        discuss = json['discuss'],
        solutions = json['solutions'],
        reputation = json['reputation'],
        contestRating = json['contestRating'],
        globalRanking = json['globalRanking'],
        attended = json['attended'],
        contests = (json['contests'] as List<dynamic>?)
            ?.map((contestJson) => Participant.fromJson(contestJson))
            .toList(),
        startYear = json['startYear'],
        top = json['top'],
        badges = (json['badges'] as List<dynamic>?)
            ?.map((badgeJson) => Badge.fromJson(badgeJson))
            .toList(),
        activity = json['activity']?.cast<String>(),
        contestRatings = json['contestRatings']?.cast<String>(),
        notes = (json['notes'] as List<dynamic>?)
            ?.map((noteJson) => Note.fromJson(noteJson))
            .toList(),
        solved = (json['solved'] as List<dynamic>?)
            ?.map((submissionJson) => Solve.fromJson(submissionJson))
            .toList(),
        languages = (json['languages'] as List<dynamic>?)
            ?.map((languageScoreJson) =>
                LanguageScore.fromJson(languageScoreJson))
            .toList(),
        // submissions = (json['submissions'] as List<dynamic>?)
        //     ?.map((submissionJson) => Submission.fromJson(submissionJson))
        //     .toList(),
        numAcceptedProblems = json['numAcceptedProblems'],
        numSubmittedProblems = json['numSubmittedProblems'],
        numAcceptedSubmissions = json['numAcceptedSubmissions'],
        numSubmissions = json['numSubmissions'],
        gender = json['gender'],
        avatar = json['avatar'];

  factory User.fromMap(Map<String, dynamic> map) {
    return User(solved: [], email: 'john@gmail.com');
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'email': email,
      'phone': phone,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'location': location,
      'urlAvatar': urlAvatar,
      'urlPayPal': urlPayPal,
      'urlGithub': urlGithub,
      'urlLinkedIn': urlLinkedIn,
      'urlPortfolio': urlPortfolio,
      'urlCSProfile': urlCSProfile,
      'siteUrls': siteUrls,
      'activeBadge': activeBadge?.toJson(),
      'views': views,
      'discuss': discuss,
      'solutions': solutions,
      'reputation': reputation,
      'contestRating': contestRating,
      'globalRanking': globalRanking,
      'attended': attended,
      'contests': contests?.map((contest) => contest.toJson()).toList(),
      'startYear': startYear,
      'top': top,
      'badges': badges?.map((badge) => badge.toJson()).toList(),
      'activity': activity,
      'contestRatings': contestRatings,
      'notes': notes?.map((note) => note.toJson()).toList(),
      'solved': solved?.map((sub) => sub.toJson()).toList(),
      'languages':
          languages?.map((languageScore) => languageScore.toJson()).toList(),
      'submissions':
          submissions?.map((submission) => submission.toJson()).toList(),
      'numAcceptedProblems': numAcceptedProblems,
      'numSubmittedProblems': numSubmittedProblems,
      'numAcceptedSubmissions': numAcceptedSubmissions,
      'numSubmissions': numSubmissions,
      'gender': gender,
      'avatar': avatar,
    };
  }
}
