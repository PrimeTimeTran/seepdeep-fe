import 'all.dart';

class Topic {
  String id;
  String name;
  List<Post>? posts;
  List<Guide>? guides;
  List<Contest>? contests;
  List<dynamic>? problems;
  List<Submission>? submissions;

  Topic({
    this.posts,
    this.guides,
    this.problems,
    this.contests,
    this.submissions,
    required this.id,
    required this.name,
  });

  Topic.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        posts = [],
        guides = [],
        problems = List.from(json['problems'] ?? []),
        contests = [],
        submissions = [];

  int get numProblems => problems?.length ?? 0;
  // posts = (json['posts'] as List<dynamic>?)
  //     ?.map((postJson) => Post.fromJson(postJson))
  //     .toList(),
  // guides = (json['guides'] as List<dynamic>?)
  //     ?.map((guideJson) => Guide.fromJson(guideJson))
  //     .toList(),
  // problems = (json['problems'] as List<dynamic>?)
  //     ?.map((problemJson) => Problem.fromJson(problemJson))
  //     .toList(),
  // contests = (json['contests'] as List<dynamic>?)
  //     ?.map((contestJson) => Contest.fromJson(contestJson))
  //     .toList(),
  // submissions = (json['submissions'] as List<dynamic>?)
  //     ?.map((submissionJson) => Submission.fromJson(submissionJson))
  //     .toList();
  // numProblems = json['submissions'].length as List<dynamic>;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'posts': posts?.map((post) => post.toJson()).toList(),
      'guides': guides?.map((guide) => guide.toJson()).toList(),
      'problems': problems?.map((problem) => problem.toJson()).toList(),
      'contests': contests?.map((contest) => contest.toJson()).toList(),
      'submissions':
          submissions?.map((submission) => submission.toJson()).toList(),
    };
  }
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
