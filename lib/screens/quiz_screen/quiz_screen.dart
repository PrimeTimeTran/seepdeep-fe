// ignore_for_file: avoid_web_libraries_in_flutter, must_be_immutable
import 'dart:async';

import 'package:app/all.dart';
import 'package:app/screens/sql/markdown_styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:markdown/markdown.dart' as md;

import 'bloc/all.dart';
import 'math.helpers.dart';
import 'stepper.dart';

class QuizScreen extends StatefulWidget {
  final String category;
  const QuizScreen({super.key, required this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class Solution {
  List<dynamic>? answers;
  Solution({
    this.answers,
  });
}

class _QuizScreenState extends State<QuizScreen> {
  final StreamController<int> _problemStreamController = StreamController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => QuizBloc(),
      child: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state.isError) {
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
          if (state.problems.isNotEmpty) {
            return buildUI(context, state);
          }
          return Center(
            child: SizedBox(
              height: 50,
              width: 200,
              child: OutlinedButton.icon(
                label: const AppText(
                  text: 'Start',
                ),
                onPressed: () {
                  BlocProvider.of<QuizBloc>(context)
                      .add(QuizScreenLoad(widget.category));
                },
                icon: const Icon(Icons.navigate_next_outlined),
              ),
            ),
          );
        },
      ),
    );
  }

  Card buildActionPanel(BuildContext buildContext, state, problems, question) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildAnswerInputs(state),
            buildFollowUpAnswers(state),
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
                      buildContext.read<QuizBloc>().add(PrevButtonPress());
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
                      buildContext.read<QuizBloc>().add(NextButtonPress());
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
                      // generateAIProblem(widget.category);
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
            // if (showAnswer)
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text('Answer'),
            //       buildContentBox(question.answer, Style.of(context, 'bodyS')),
            //       const Text('Answer Latex'),
            //       buildContentBox(
            //           question.answerLatex, Style.of(context, 'bodyS')),
            //     ],
            //   )
          ],
        ),
      ),
    );
  }

  buildAnswerInputs(state) {
    final problem = state.activeProblem;
    final activeAnswer = state.activeAnswer;
    // return const SizedBox();
    // Fix:
    // Switching questions results in the inputs not updating/reverting to their previous values.
    // Gotta make controller smarter.
    // Also the issue with them is they're fickle with allowing us to type.
    List<Widget> items = [];
    // final answer = answers[index - 1];

    bool isMultiAnswer = false;
    // if (problem.answers?[0] is List) {
    //   isMultiAnswer = true;
    // }
    int answerLength = activeAnswer['answers']?.length ?? 0;
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
                    // if (isMultiAnswer) {
                    //   answer['answers'][i][0] = value;
                    // } else {
                    //   answer['answers'][i] = value;
                    // }
                    // answers[index - 1] = answer;
                    // setState(() {
                    //   answers = answers;
                    // });
                  },
                ),
              ),
              if (true)
                SizedBox(
                  height: 30,
                  width: 200,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Answer',
                    ),
                    onChanged: (value) {
                      // activeAnswer['answers'][i][1] = value;
                      // answers[index - 1] = answer;
                      // setState(() {
                      //   answers = answers;
                      // });
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

  Widget buildFollowUpAnswers(state) {
    List<Widget> items = [];
    Map<String, dynamic> answer = state.activeAnswer;
    // int lengthOfAnswers = answer['followUpAnswers'];
    print('dododo ${answer['followUpAnswers']}');
    // return const SizedBox();
    // List<TextEditingController> controllers =
    //     List.generate(lengthOfAnswers, (_) => TextEditingController());
    for (int i = 0; i < 1; i++) {
      // controllers[i].text = answer['followUpAnswers'][i] ?? '';
      items.add(
        Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            children: [
              Text(
                '${0 == 1 ? '(b) ' : optionLabels[i]}: ',
                style: Style.of(context, 'labelL').copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: themeColor(context, 'secondary')),
              ),
              SizedBox(
                height: 30,
                width: 200,
                child: TextFormField(
                  // key: ValueKey('$index-$i'),
                  // controller: controllers[i],
                  decoration: const InputDecoration(
                    hintText: 'Answer',
                  ),
                  onChanged: (value) {
                    setState(() {
                      answer['followUpAnswers'][i] = value;
                      // answers[index - 1] = answer;
                      // setState(() {
                      //   answers = answers;
                      // });
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
              itemCount: options?.length,
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

  buildUI(BuildContext buildContext, state) {
    final problems = state.problems;
    final activeProblem = state.activeProblem;
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
                              setStep: () {},
                              problemsLength: problems.length,
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
                                  buildLatexContent(activeProblem.body),
                                  const Gap(10),
                                  if (activeProblem.equation != null)
                                    buildLatexContent(activeProblem.equation),
                                  if (activeProblem.prompt.isNotEmpty)
                                    buildLatexContent(activeProblem.prompt),
                                  buildOptions(activeProblem),
                                  if (activeProblem.followUpPrompt.isNotEmpty)
                                    buildLatexContent(
                                        activeProblem.followUpPrompt),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  if (activeProblem.urlImgs != null &&
                                      activeProblem.urlImgs.isNotEmpty)
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
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text('Answers for: $index'),
                                        // Text(answers.toString()),
                                      ],
                                    ),
                                  buildActionPanel(
                                    buildContext,
                                    state,
                                    problems,
                                    activeProblem,
                                  ),
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

  @override
  void initState() {
    super.initState();
  }
}
