// ignore_for_file: avoid_web_libraries_in_flutter, must_be_immutable
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:app/all.dart';
import 'package:app/screens/math_screen/stepper.dart';
import 'package:app/screens/sql/markdown_styles.dart';
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

final optionLabels = [
  'i',
  'ii',
  'iii',
  'iv',
  'v',
  'vi',
  'vii',
  'viii',
  'ix',
  'x'
];

class MathScreen extends StatefulWidget {
  final String category;
  const MathScreen({super.key, required this.category});

  @override
  State<MathScreen> createState() => _MathScreenState();
}

class _MathScreenState extends State<MathScreen> {
  int index = 1;
  bool error = false;
  bool showAnswer = false;
  String problemType = 'optimization';
  List<MathProblem> questions = [];
  List<String> answers = [];
  List<String?> problemAnswers = [];

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

  Card buildAnswerBox(problems, question) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildAnswerBoxes(question),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                right: 50,
                bottom: 50,
                left: 100,
              ),
              child: TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Answer',
                  hintText: 'Enter answer here',
                ),
              ),
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Gap(20),
                OutlinedButton.icon(
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
                const Gap(20),
                OutlinedButton.icon(
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
                const Gap(20),
                OutlinedButton.icon(
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
                const Gap(20),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton.icon(
                  icon: const Icon(SDIcon.ai_enabled),
                  onPressed: () {
                    generateAIProblem(problemType);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      themeColor(
                        context,
                        'primaryContainer',
                      ),
                    ),
                  ),
                  label: const Text('New'),
                ),
                const Gap(20),
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

  buildAnswerBoxes(question) {
    List<Widget> items = [];
    for (int i = 0; i < question.options.length; i++) {
      items.add(
        Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            children: [
              Text(
                '${optionLabels[i]}: ',
                style: Style.of(context, 'labelL').copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: themeColor(context, 'secondary')),
              ),
              SizedBox(
                height: 30,
                width: 200,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter answer here',
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (problemAnswers.length <= i) {
                        while (problemAnswers.length <= i) {
                          problemAnswers.add(null);
                        }
                      }
                      problemAnswers[i] = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items,
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

  buildLatexSection(value) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 200,
        maxWidth: 1500,
        minHeight: 100,
        maxHeight: 150,
      ),
      child: Markdown(
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
      ),
    );
  }

  buildOptions(question) {
    List<Widget> items = [];
    for (int i = 0; i < question.options.length; i++) {
      var element = question.options[i];
      items.add(
        Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            children: [
              Text(
                '${optionLabels[i]}: ',
                style: Style.of(context, 'labelL').copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: themeColor(context, 'secondary')),
              ),
              Text(
                element.toString(),
                style: Style.of(context, 'labelL').copyWith(
                  fontSize: 30,
                ),
              )
            ],
          ),
        ),
      );
    }
    return Row(children: items);
  }

  buildUI(problems) {
    final question = problems[index - 1];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepperDemo(
            setStep: setStep,
            problemsLength: questions.length,
            problemStream: _problemStreamController.stream,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  semanticContainer: true,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLatexSection(question.body),
                        const Gap(10),
                        buildLatexSection(question.prompt),
                        if (question.options != null) buildOptions(question),
                        const Gap(10),
                        buildLatexSection(question.followUpPrompt),
                        const Gap(10),
                        buildAnswerBox(problems, question),
                        const Gap(10),
                        Text(problemAnswers.toString())
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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

  getCategory() {
    final url = html.window.location.href;
    Uri uri = Uri.parse(url);
    String category = uri.queryParameters['category'] ?? 'limits';
    if (category != '') {
      setState(() {
        problemType = category;
      });
    }
  }

  getProblems(topic) async {
    try {
      List<MathProblem> values = [];
      if (kDebugMode) {
        final response =
            await http.get(Uri.parse('http://localhost:8080/?category=$topic'));

        if (response.statusCode == 200) {
          final resp = jsonDecode(response.body);
          for (var question in resp['data']) {
            values.add(MathProblem.fromJson(question));
          }
          setState(() {
            questions = values;
          });
          return;
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        final json = await rootBundle.loadString('json/$topic.json');
        final Map<String, dynamic> data = await jsonDecode(json);
        for (var question in data['data']) {
          values.add(MathProblem.fromJson(question));
        }
        setState(() {
          problemAnswers = List.generate(
            values[0].options?.length ?? 0,
            (index) => null,
          );
          questions = values;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        problemType = widget.category;
      });
      getProblems(widget.category);
    });
  }

  setStep(idx) {
    setState(() {
      index = idx;
    });
  }

  setSubscription() {
    ui.platformViewRegistry.registerViewFactory('index', (int viewId) {
      webView = IFrameElement()
        ..src = 'assets/index.html'
        ..style.border = 'none';
      window.onMessage.listen((msg) {
        if (msg.data?.startsWith("onMsg Success:")) {
          Glob.logI('onMsg Success');
        } else {
          Glob.logI('onMsg not success');
        }
      }, onError: (e) {
        Glob.logI(e);
      }, onDone: () {
        Glob.logI('Done');
      });
      return webView;
    }, isVisible: false);
  }
}
