import 'package:app/all.dart';

class Solve {
  String id;
  SolveLVL level;
  String problemId;
  String problemTitle;

  Solve(
    this.id,
    this.level,
    this.problemId,
    this.problemTitle,
  );

  factory Solve.fromJson(Map<String, dynamic> json) {
    List<dynamic> topicsJson =
        json['topics'] != null ? json['topics'] as List<dynamic> : [];
    List<Topic> topics = topicsJson
        .map((topicJson) => Topic.fromJson(topicJson as Map<String, dynamic>))
        .toList();

    final problem = json['problem'];
    final problemId = problem != null ? problem['_id'] as String : '';
    final problemTitle = problem != null ? problem['title'] as String : '';
    return Solve(
      json['_id'],
      _parseSolveLVL(json['level']),
      problemId,
      problemTitle,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'level': _levelToString(level),
      'problemId': problemId,
      'problemTitle': problemTitle,
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
    switch (value.toLowerCase()) {
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
