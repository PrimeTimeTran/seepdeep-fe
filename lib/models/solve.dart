import 'package:app/all.dart';

class Solve {
  User user;
  String id;
  SolveLVL level;
  String problemId;
  String problemTitle;
  int numSolvedTotal;
  int numSolvedLevel;
  String submissionId;
  DateTime dateChallenge;
  List<Topic> topics;

  Solve(
    this.id,
    this.user,
    this.level,
    this.topics,
    this.problemId,
    this.problemTitle,
    this.numSolvedTotal,
    this.numSolvedLevel,
    this.dateChallenge,
    this.submissionId,
  );
  factory Solve.fromJson(Map<String, dynamic> json) {
    List<dynamic> topicsJson = json['topics'] as List<dynamic>;
    List<Topic> topics = topicsJson
        .map((topicJson) => Topic.fromJson(topicJson as Map<String, dynamic>))
        .toList();

    return Solve(
      json['id'] as String,
      User.fromJson(json['user'] as Map<String, dynamic>),
      _parseSolveLVL(json['level'] as String),
      topics,
      json['problemId'] as String,
      json['problemTitle'] as String,
      json['numSolvedTotal'] as int,
      json['numSolvedLevel'] as int,
      DateTime.parse(json['dateChallenge'] as String),
      json['submissionId'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'level': _levelToString(level),
      'problemId': problemId,
      'problemTitle': problemTitle,
      'numSolvedTotal': numSolvedTotal,
      'numSolvedLevel': numSolvedLevel,
      'dateChallenge': dateChallenge.toIso8601String(),
      'submissionId': submissionId,
    };
  }

  static String _levelToString(SolveLVL level) {
    switch (level) {
      case SolveLVL.encountered:
        return 'encountered';
      case SolveLVL.novice:
        return 'novice';
      case SolveLVL.apprentice:
        return 'apprentice';
      case SolveLVL.proficient:
        return 'proficient';
      case SolveLVL.intermediate:
        return 'intermediate';
      case SolveLVL.advanced:
        return 'advanced';
      case SolveLVL.expert:
        return 'expert';
      case SolveLVL.mastered:
        return 'mastered';
      case SolveLVL.guru:
        return 'guru';
      case SolveLVL.legend:
        return 'legend';
      default:
        throw ArgumentError('Invalid SolveLVL value: $level');
    }
  }

  static SolveLVL _parseSolveLVL(String value) {
    switch (value) {
      case 'encountered':
        return SolveLVL.encountered;
      case 'novice':
        return SolveLVL.novice;
      case 'apprentice':
        return SolveLVL.apprentice;
      case 'proficient':
        return SolveLVL.proficient;
      case 'intermediate':
        return SolveLVL.intermediate;
      case 'advanced':
        return SolveLVL.advanced;
      case 'expert':
        return SolveLVL.expert;
      case 'mastered':
        return SolveLVL.mastered;
      case 'guru':
        return SolveLVL.guru;
      case 'legend':
        return SolveLVL.legend;
      default:
        throw ArgumentError('Invalid SolveLVL value: $value');
    }
  }
}
