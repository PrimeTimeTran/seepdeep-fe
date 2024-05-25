import 'all.dart';

class MathProblem extends Problem {
  String? hint;
  String? prompt;
  String? equation;
  String? evaluate;
  String? solution;
  String? format;

  String? answerLatex;

  String? followUpPrompt;
  String? followUpExplanation;

  List<dynamic>? answers;
  List<dynamic>? followUpAnswers;

  List<dynamic>? terms;
  List<dynamic>? options;
  List<dynamic>? answerLabels;

  MathProblem({
    super.id,
    super.type,
    super.title,
    super.body,
    super.urlImgs,
    this.hint,
    this.prompt,
    this.format,
    this.equation,
    this.evaluate,
    this.solution,
    this.answers,
    this.answerLatex,
    this.followUpPrompt,
    this.followUpAnswers,
    this.followUpExplanation,
    this.terms,
    this.options,
    this.answerLabels,
  });

  MathProblem.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? '';
    urlImgs = (json['urlImgs'] ?? []).cast<String>();
    id = json['id'] ?? '';
    title = json['title'] ?? '';
    body = json['body'] ?? '';
    hint = json['hint'] ?? '';
    prompt = json['prompt'] ?? '';
    equation = json['equation'] ?? '';
    evaluate = json['evaluate'] ?? '';
    solution = json['solution'] ?? '';
    answers = json['answers'] ?? [];
    answerLatex = json['answerLatex'] ?? '';
    followUpPrompt = json['followUpPrompt'] ?? '';
    followUpAnswers = json['followUpAnswers'] ?? [];
    followUpExplanation = json['followUpExplanation'] ?? '';
    format = json['format'] ?? '';
    terms = json['terms'] != null ? List<dynamic>.from(json['terms']) : [];
    options =
        json['options'] != null ? List<dynamic>.from(json['options']) : [];
    answerLabels = json['answerLabels'] != null
        ? List<dynamic>.from(json['answerLabels'])
        : [];
  }
}
