class Article {
  String? type; // news, original, tutorial, announcement, review
  User? author;
  String? title;
  String? caption;
  String? body;
  String? link;
  String? urlCoverImg;
  String? urlVideo;
  String? isPublished;
  DateTime? publishDate;
  String? language;
  List<Comment>? comments;
  int? numComments;
  List<int>? voterIds;
  int? numVotes;

  bool? isOriginal; // Was this published on CSGems first?
}

class Badge {
  int? year;
  int? month;
  String? name;
  String? urlImg;
}

class BadgeItem {
  int? month;
  int? year;
  int? userId;
  DateTime? date;
  String? urlImg;
}

class Comment {
  String? body;
  User? user;
  Post? post;
  Article? article;
  Comment? comment; // The comment this comment is replying to
  Problem? problem;
  Submission? submission;
  List<Comment>? comments; // The replies this comment got.
  int? numVotes;
  List<int>? voterIds;
  String? code;
}

class Company {
  String? name;
  String? industry;
  String? founded;
  int? teamSize;
  String? location;
  String? urlAvatar;
  List<User>? founders;
  List<String>? industries;
  List<String>? technologies;
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

// Should be able to filter by topic
// Sort on date, ratings,
class Forum {}

class Guide {
  String? title;
  String? body;
  String? caption;
  String? description;
  List<Topic>? topics;
}

class Job {
  String? title;
  String? caption;
  String? location;
  bool? isRemote;
  Company? company;
  String? type; // Full or part time
  String? description;
  String? experience;
  String? project; // What we're up to. Whats awesome about this position?
  List<String>?
      technologies; // What do we use everyday? Is it different from what we do
  String? requirements;
  String? whoAreYou;
  String? salary;
  String? equity;
  String? benefits;
}

class LanguageScore {
  String? score;
  String? language;
}

class Note {
  User? user;
  String? body;
  Problem? problem;
}

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

class Post {
  User? user;
  String? title;
  String? body;
  DateTime? submitted;
  bool? isPublic;
  int? numVotes;
  int? numViews;
  int? numComments;
  List<Topic>? topics;
  List<Comment>? comments;
}

class Problem {
  String? title;
  String? body;
  List<Topic>? topics;
  String? status;
  bool? isPublished;
  bool? isSubmitted;
  User? author;

  String? editorialBody;
  User? editorialAuthor;

  String? solution;
  String? acceptance;

  double? frequency;
  Difficulty? difficulty;
  int? accepted;
  int? submissions;
  double? acceptanceRate;

  // Map of language and their tests to test the problem.
  Map<String, String>? bodyTests;

  // Language, then list of test suite inputs and outputs;
  Map<String, List<String>>? testSuite;
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
}

class Site {
  List<Ranking>? globalRankings;
}

class Submission {
  User? user;
  String? body;
  DateTime? submitted;
  Problem? problem;
  String? language;
  bool? isAccepted;
  double? runTime;
  double? beats;
  String? notes;

  bool? isShared;
  String? title;
  String? explanation;

  int? numVotes;
  List<int>? voterIds;
  int? numComments;
  List<Topic>? topics;
  List<Comment>? comments;

  bool? isContest;
  Contest? contest;
  int? penalty;
}

class Topic {
  String? name;
  List<Post>? posts;
  List<Guide>? guides;
  List<Problem>? problems;
  List<Contest>? contests;
  List<Submission>? submissions;
}

class TopicItem {
  String? name;
  Note? note;
  Post? post;
  Guide? guide;
  Problem? problem;
  Contest? contest;
  Submission? submission;
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
  List<String>? siteUrls;
  Badge? activeBadge;

  // Background worker updates these fields
  // Community
  int? views;
  int? discuss;
  int? solutions;
  int? reputation;

  // Contests
  int? contestRating;
  int? globalRanking;
  int? attended;
  List<ContestParticipation>? contests;
  int? startYear;

  double? top;

  List<Badge>? badges;
  List<String>? activity;
  List<String>? contestRatings;

  // Learnings
  List<Note>? notes;
  List<Submission>? problemsSolved;
  List<LanguageScore>? languages;
  List<Submission>? submissions;

  int? numAcceptedProblems;
  int? numSubmittedProblems;
  int? numAcceptedSubmissions;
  int? numSubmissions;

  String? gender;
  String? avatar;
}
