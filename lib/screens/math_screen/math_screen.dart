// ignore_for_file: avoid_web_libraries_in_flutter, must_be_immutable
import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:app/all.dart';
import 'package:app/screens/math_screen/stepper.dart';
import 'package:app/screens/sql/markdown_styles.dart';
import 'package:app/services/quiz_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:markdown/markdown.dart' as md;

import 'math.helpers.dart';

class MathScreen extends StatefulWidget {
  final String category;
  const MathScreen({super.key, required this.category});

  @override
  State<MathScreen> createState() => _MathScreenState();
}

class Solution {
  List<dynamic>? answers;
  Solution({
    this.answers,
  });
}

class _MathScreenState extends State<MathScreen> {
  int index = 1;
  bool error = false;
  bool showAnswer = false;
  late QuizService quizService;
  List<MathProblem> questions = [];
  List<Map<String, dynamic>> answers = [];

  IFrameElement webView = IFrameElement();
  final StreamController<int> _problemStreamController = StreamController();

  @override
  Widget build(BuildContext context) {
    if (error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/img/SVG/bug-fixing.svg',
              width: 600,
            ),
            const Gap(50),
            Text(
              "We're experiencing issues. Please try again later.",
              style: Style.of(
                context,
                'displayL',
              ),
            )
          ],
        ),
      );
    }
    if (questions.isNotEmpty) {
      return buildUI(questions);
    }
    return Container();
  }

  Card buildActionPanel(problems, question) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildAnswerInputs(),
            buildFollowUpAnswers(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Gap(20),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: OutlinedButton.icon(
                    label: const AppText(
                      text: 'Back',
                    ),
                    onPressed: () {
                      if (index <= 1) return;
                      _problemStreamController.add(index - 1);
                      setState(() {
                        index = index - 1;
                      });
                    },
                    icon: const Icon(Icons.navigate_before_outlined),
                  ),
                ),
                const Gap(20),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: OutlinedButton.icon(
                    label: const AppText(
                      text: 'Next',
                    ),
                    onPressed: () {
                      if (index >= problems.length) return;
                      _problemStreamController.add(index + 1);
                      setState(() {
                        index = index + 1;
                      });
                    },
                    icon: const Icon(Icons.navigate_next_outlined),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                  width: 300,
                  child: OutlinedButton.icon(
                    label: const AppText(
                      text: 'New Problem(AI generated)',
                    ),
                    onPressed: () {
                      generateAIProblem(widget.category);
                    },
                    icon: const Icon(SDIcon.ai_enabled),
                  ),
                ),
                const Gap(20),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: OutlinedButton.icon(
                    label: const AppText(
                      text: 'Submit',
                    ),
                    onPressed: () async {
                      if (index >= problems.length) return;
                      await FirebaseAnalytics.instance.logEvent(
                        name: "engage",
                        parameters: {
                          "type": "problem_solve",
                          "category": "math",
                          "module": "calculus",
                        },
                      );
                    },
                    icon: const Icon(Icons.keyboard_return),
                  ),
                ),
              ],
            ),
            const Gap(10),
            if (showAnswer)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Answer'),
                  buildContentBox(question.answer, Style.of(context, 'bodyS')),
                  const Text('Answer Latex'),
                  buildContentBox(
                      question.answerLatex, Style.of(context, 'bodyS')),
                ],
              )
          ],
        ),
      ),
    );
  }

  buildAnswerInputs() {
    // Fix:
    // Switching questions results in the inputs not updating/reverting to their previous values.
    // Gotta make controller smarter.
    // Also the issue with them is they're fickle with allowing us to type.
    List<Widget> items = [];
    final answer = answers[index - 1];
    bool isMultiAnswer = false;
    if (questions[index - 1].answers?[0] is List) {
      isMultiAnswer = true;
    }
    int answerLength = answer['answers'].length;

    for (int i = 0; i < answerLength; i++) {
      items.add(
        Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            children: [
              Text(
                '${answerLength == 1 ? 'Answer' : optionLabels[i]}: ',
                style: Style.of(context, 'labelL').copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: themeColor(context, 'secondary'),
                ),
              ),
              SizedBox(
                height: 30,
                width: 200,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Answer',
                  ),
                  onChanged: (value) {
                    if (isMultiAnswer) {
                      answer['answers'][i][0] = value;
                    } else {
                      answer['answers'][i] = value;
                    }
                    answers[index - 1] = answer;
                    setState(() {
                      answers = answers;
                    });
                  },
                ),
              ),
              if (isMultiAnswer)
                SizedBox(
                  height: 30,
                  width: 200,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Answer',
                    ),
                    onChanged: (value) {
                      answer['answers'][i][1] = value;
                      answers[index - 1] = answer;
                      setState(() {
                        answers = answers;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    }
    return Align(
      alignment: Alignment.centerRight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items,
        ),
      ),
    );
  }

  buildContentBox(value, style) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 200,
        maxWidth: 1500,
        minHeight: 10,
        maxHeight: 150,
      ),
      child: AppText(
        text: value,
        style: style,
      ),
    );
  }

  Widget buildFollowUpAnswers() {
    List<Widget> items = [];
    final answer = answers[index - 1];
    int lengthOfAnswers = answer['followUpAnswers'].length;
    List<TextEditingController> controllers =
        List.generate(lengthOfAnswers, (_) => TextEditingController());
    for (int i = 0; i < lengthOfAnswers; i++) {
      controllers[i].text = answer['followUpAnswers'][i] ?? '';
      items.add(
        Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            children: [
              Text(
                '${lengthOfAnswers == 1 ? '(b) ' : optionLabels[i]}: ',
                style: Style.of(context, 'labelL').copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: themeColor(context, 'secondary')),
              ),
              SizedBox(
                height: 30,
                width: 200,
                child: TextFormField(
                  key: ValueKey('$index-$i'),
                  controller: controllers[i],
                  decoration: const InputDecoration(
                    hintText: 'Answer',
                  ),
                  onChanged: (value) {
                    setState(() {
                      answer['followUpAnswers'][i] = value;
                      answers[index - 1] = answer;
                      setState(() {
                        answers = answers;
                      });
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Align(
      alignment: Alignment.centerRight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: items,
        ),
      ),
    );
  }

  buildLatex(value) {
    return Markdown(
      selectable: true,
      data: value,
      styleSheet: myStyleSheet,
      builders: {
        'latex': LatexElementBuilder(
          textStyle: TextStyle(
            fontSize: 30,
            color: themeColor(context, 'primary'),
            fontWeight: FontWeight.w100,
          ),
          textScaleFactor: 1.2,
        ),
      },
      extensionSet: md.ExtensionSet(
        [LatexBlockSyntax()],
        [LatexInlineSyntax()],
      ),
    );
  }

  buildLatexContent(value) {
    // return buildLatex(value);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 200,
        maxWidth: 1000,
        minHeight: 100,
        maxHeight: 150,
      ),
      child: buildLatex(value),
    );
  }

  buildOptions(question) {
    final options = question.options;
    if (options.isNotEmpty) {
      return Card.filled(
        child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 100,
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: options.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(
                      '${optionLabels[index]}: ',
                      style: Style.of(context, 'labelL').copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: themeColor(context, 'secondary')),
                    ),
                    SizedBox(
                      height: 85,
                      width: 400,
                      child: buildLatex(options[index].toString()),
                    ),
                  ],
                );
              },
            )),
      );
    }
    return const SizedBox();
  }

  buildUI(problems) {
    final question = problems[index - 1];

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

        final title = matchSubject(widget.category) ?? '';

        return SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (title.isNotEmpty)
                            Expanded(
                              child: Text(
                                title,
                                style: Style.of(
                                  context,
                                  'displayL',
                                ),
                              ),
                            ),
                          Expanded(
                            child: StepperDemo(
                              setStep: setStep,
                              problemsLength: questions.length,
                              problemStream: _problemStreamController.stream,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildLatexContent(question.body),
                                  const Gap(10),
                                  if (question.equation != null)
                                    buildLatexContent(question.equation),
                                  if (question.prompt.isNotEmpty)
                                    buildLatexContent(question.prompt),
                                  buildOptions(question),
                                  if (question.followUpPrompt.isNotEmpty)
                                    buildLatexContent(question.followUpPrompt),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  if (question.urlImgs != null &&
                                      question.urlImgs.isNotEmpty)
                                    SizedBox(
                                      height: 400,
                                      width: 600,
                                      child: Image.asset(
                                        'assets/img/graph.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  const Spacer(),
                                  if (kDebugMode)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Answers for: $index'),
                                        Text(answers.toString()),
                                      ],
                                    ),
                                  buildActionPanel(problems, question),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> generateAIProblem(type) async {
    final gemini = Gemini.instance;
    try {
      final resp = await gemini.text(generateGeminiPrompts(type));
      final json = resp?.content?.parts?[0].text;
      if (json != null) {
        // Sometimes the response comes back wrapped with a ```json ```.
        String trimmedJson =
            json.replaceAll('```json', '').replaceAll('```', '');
        final Map<String, dynamic> question = await jsonDecode(trimmedJson);

        final problem = MathProblem(
          title: question['title'],
          body: question['body'],
          equation: question['equation'],
          prompt: question['prompt'],
          solution: question['solution'],
        );
        questions.add(problem);
        setState(() {
          questions = questions;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  getProblems(topic) async {
    try {
      List<MathProblem> values = [];
      if (!kDebugMode) {
        final response =
            await http.get(Uri.parse('http://localhost:8080/?category=$topic'));

        if (response.statusCode == 200) {
          final resp = jsonDecode(response.body);
          for (var question in resp['data']) {
            values.add(MathProblem.fromJson(question));
          }
          quizService = QuizService(problems: values);
          answers = quizService.answers;
          setState(() {
            questions = values;
            answers = answers;
            quizService = quizService;
          });

          return;
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        final json = await rootBundle.loadString('json/math/$topic.json');
        final Map<String, dynamic> data = await jsonDecode(json);
        for (var question in data['data']) {
          values.add(MathProblem.fromJson(question));
        }
        quizService = QuizService(problems: values);
        answers = quizService.answers;
        setState(() {
          questions = values;
          answers = answers;
          quizService = quizService;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        error = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProblems(widget.category);
  }

  setStep(idx) {
    setState(() {
      index = idx;
    });
  }
}
