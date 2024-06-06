// ignore_for_file: avoid_web_libraries_in_flutter, must_be_immutable
import 'package:app/all.dart';
import 'package:app/screens/sql_screen/markdown_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:markdown/markdown.dart' as md;

import 'answer_panel.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (buildContext, state) {
        if (state.isDone) {
          final score = state.finalScore;
          final finalScore = (score['score'] * 100);
          Color? color = Colors.yellow;
          if (finalScore > 90) {
            color = Colors.teal;
          } else if (finalScore < 60) {
            color = Colors.red;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Card.outlined(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 56,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '# Problems:',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Gap(25),
                            Text(
                              score['countProblems'].toString(),
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '# Correct:',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Gap(25),
                            Text(
                              score['countCorrect'].toString(),
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Final Score:',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Gap(25),
                            Text(
                              finalScore.toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(color: color),
                            ),
                          ],
                        ),
                        const Gap(50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('View Problems'),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  buildContext
                                      .read<QuizBloc>()
                                      .add(RetakeQuiz());
                                },
                                child: const Text('Retake'),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Next'),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
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
    );
  }

  buildAnswerPreview(state) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Active Answers'),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Text(state.activeAnswer['answers'][0].toString()),
            ),
          ],
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

  buildCorrectCheck(state) {
    final activeProblemString =
        state.activeProblem?.answers?[0].toString().replaceAll(' ', '');
    final activeAnswerString =
        state.activeAnswer['answers'][0].toString().replaceAll(' ', '');
    final isSame = activeProblemString == activeAnswerString;
    // \[f'(x) = 18x^{2} - 9\]
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Problem Answer: $activeProblemString'),
            Text('Active Answer: $activeAnswerString'),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Text(
                'Same: $isSame',
                style: TextStyle(color: isSame ? Colors.green : Colors.red),
              ),
            )
          ],
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

  buildProblemAnswer(state) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Problem Idx: ${state.problemIdx}'),
            SizedBox(
              height: 50,
              child: buildLatex(state.activeProblem?.answers?[0].toString()),
            )
          ],
        ),
      ),
    );
  }

  buildQCPanel() {
    if (kDebugMode) {
      return BlocBuilder<QuizBloc, QuizState>(
        buildWhen: (previous, current) {
          return previous.activeAnswer != current.activeAnswer;
        },
        builder: (blocContext, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                buildProblemAnswer(state),
                buildAnswerPreview(state),
                buildCorrectCheck(state),
              ],
            ),
          );
        },
      );
    }
    return const SizedBox();
  }

  buildUI(BuildContext buildContext, state) {
    final problems = state.problems;
    final problem = state.activeProblem;
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
                          activeStep: state.problemIdx + 1,
                          problemsLength: problems.length,
                          setStep: (int idx) {
                            buildContext
                                .read<QuizBloc>()
                                .add(ProblemSelectButtonPress(idx));
                          },
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
                              buildLatexContent(problem.body),
                              const Gap(10),
                              if (problem.equation != null)
                                buildLatexContent(problem.equation),
                              if (problem.prompt.isNotEmpty)
                                buildLatexContent(problem.prompt),
                              buildOptions(problem),
                              if (problem.followUpPrompt.isNotEmpty)
                                buildLatexContent(problem.followUpPrompt),
                              const Spacer(),
                              buildQCPanel()
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              if (problem.urlImgs != null &&
                                  problem.urlImgs.isNotEmpty)
                                SizedBox(
                                  height: 400,
                                  width: 600,
                                  child: Image.asset(
                                    'assets/img/graph.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              const Spacer(),
                              const AnswerPanel(),
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
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuizBloc>(context).add(QuizScreenLoad(widget.category));
  }
}
