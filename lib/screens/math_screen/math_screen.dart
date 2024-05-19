// ignore_for_file: avoid_web_libraries_in_flutter, must_be_immutable
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:app/all.dart';
import 'package:app/screens/math_screen/stepper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:gap/gap.dart';
import 'package:markdown/markdown.dart' as md;

class MathScreen extends StatefulWidget {
  const MathScreen({super.key});

  @override
  State<MathScreen> createState() => _MathScreenState();
}

class Optimization {
  String? hint;
  String? body;
  String? title;
  String? prompt;
  String? equation;
  String? evaluate;
  String? solution;
  String? answer;
  String? answerLatex;
  String? solutionsWrong;
  List<String>? imgUrls;
  List<String>? formulas;
  String? answerPlaceholder;
  List<String>? explanation;

  String? type;

  Optimization({
    this.body,
    this.title,
    this.type,
    this.hint,
    this.prompt,
    this.evaluate,
    this.solution,
    this.answer,
    this.answerLatex,
    this.imgUrls,
    this.formulas,
    this.equation,
  });
}

class _MathScreenState extends State<MathScreen> {
  int index = 1;
  bool error = false;
  String problemType = 'optimization';
  List<Optimization> questions = [];
  IFrameElement webView = IFrameElement();
  final StreamController<int> _problemStreamController = StreamController();

  @override
  Widget build(BuildContext context) {
    setSubscription();
    if (questions.isNotEmpty) {
      return buildProblemUI(questions);
    }
    return Container();
  }

  buildProblemUI(problems) {
    final question = problems[index - 1];
    return Column(
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
                      ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 200,
                            maxWidth: 1000,
                            minHeight: 10,
                            maxHeight: 150,
                          ),
                          child: AppText(
                            text: question.title!,
                            style: Theme.of(context).textTheme.headlineMedium,
                          )),
                      const Gap(10),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 200,
                          maxWidth: 1000,
                          minHeight: 100,
                          maxHeight: 150,
                        ),
                        child: AppText(
                          text: question.body!,
                          style: Style.of(context, 'displayS'),
                        ),
                      ),
                      const Gap(10),
                      ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 200,
                            maxWidth: 1000,
                            minHeight: 100,
                            maxHeight: 150,
                          ),
                          child: Markdown(
                            selectable: true,
                            data: question.equation,
                            builders: {
                              'latex': LatexElementBuilder(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w100, fontSize: 25),
                              ),
                            },
                            extensionSet: md.ExtensionSet(
                              [LatexBlockSyntax()],
                              [LatexInlineSyntax()],
                            ),
                          )),
                      ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 200,
                            maxWidth: 1000,
                            minHeight: 100,
                            maxHeight: 150,
                          ),
                          child: Markdown(
                            selectable: true,
                            data: question.evaluate,
                            builders: {
                              'latex': LatexElementBuilder(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w100, fontSize: 25),
                              ),
                            },
                            extensionSet: md.ExtensionSet(
                              [LatexBlockSyntax()],
                              [LatexInlineSyntax()],
                            ),
                          )),
                      const Gap(10),
                      ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 200,
                            maxWidth: 1000,
                            minHeight: 100,
                            maxHeight: 150,
                          ),
                          child: AppText(
                            text: question.prompt!,
                            style: Style.of(context, 'displayS'),
                          )),
                      const Gap(10),
                      Card.outlined(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
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
                                  icon: const Icon(
                                      Icons.navigate_before_outlined),
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
                                  icon:
                                      const Icon(Icons.navigate_next_outlined),
                                ),
                                const Gap(20),
                                OutlinedButton.icon(
                                  label: const AppText(
                                    text: 'Answer',
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
                                  icon:
                                      const Icon(Icons.navigate_next_outlined),
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
                            ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minHeight: 30,
                                  maxHeight: 50,
                                ),
                                child: Markdown(
                                  selectable: true,
                                  data: question.answer,
                                  builders: {
                                    'latex': LatexElementBuilder(
                                      textStyle: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  },
                                  extensionSet: md.ExtensionSet(
                                    [LatexBlockSyntax()],
                                    [LatexInlineSyntax()],
                                  ),
                                )),
                            // ConstrainedBox(
                            //     constraints: const BoxConstraints(
                            //       minHeight: 30,
                            //       maxHeight: 125,
                            //     ),
                            //     child: Markdown(
                            //       selectable: true,
                            //       data: question.answerLatex,
                            //       builders: {
                            //         'latex': LatexElementBuilder(
                            //           textStyle: const TextStyle(
                            //             fontSize: 25,
                            //             fontWeight: FontWeight.w100,
                            //           ),
                            //         ),
                            //       },
                            //       extensionSet: md.ExtensionSet(
                            //         [LatexBlockSyntax()],
                            //         [LatexInlineSyntax()],
                            //       ),
                            //     )),
                            // ConstrainedBox(
                            //     constraints: const BoxConstraints(
                            //       minHeight: 30,
                            //       maxHeight: 125,
                            //     ),
                            //     child: Markdown(
                            //       selectable: true,
                            //       data: question.solution,
                            //       builders: {
                            //         'latex': LatexElementBuilder(
                            //           textStyle: const TextStyle(
                            //             fontSize: 25,
                            //             fontWeight: FontWeight.w100,
                            //           ),
                            //         ),
                            //       },
                            //       extensionSet: md.ExtensionSet(
                            //         [LatexBlockSyntax()],
                            //         [LatexInlineSyntax()],
                            //       ),
                            //     )),
                            const Gap(10),
                          ],
                        ),
                      ),
                      const Gap(10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Gap(10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerRight,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    const ratio = 1025 / 750;
                    final width = constraints.maxWidth;
                    final height = width / ratio;
                    return SizedBox(
                      width: width,
                      height: height,
                      child: const HtmlElementView(
                        viewType: 'index',
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ],
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

        final problem = Optimization(
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
      print('Errorr: $e');
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
    getProblems(category);
  }

  getProblems(topic) async {
    try {
      List<Optimization> values = [];
      final json = await rootBundle.loadString('json/$topic.json');
      final Map<String, dynamic> data = await jsonDecode(json);
      for (var question in data['data']) {
        values.add(Optimization(
          body: question['body'] ?? '',
          title: question['title'] ?? '',
          prompt: question['prompt'] ?? '',
          answer: question['answer'] ?? '',
          equation: question['equation'] ?? '',
          evaluate: question['evaluate'] ?? '',
          solution: question['solution'] ?? '',
          answerLatex: question['answerLatex'] ?? '',
        ));
      }
      setState(() {
        questions = values;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        getCategory();
      });
    });
  }

  setProblem() {}

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
