// ignore_for_file: avoid_web_libraries_in_flutter, must_be_immutable
import 'package:app/all.dart';
import 'package:app/screens/sql/markdown_styles.dart';
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
      builder: (context, state) {
        if (state.isDone) {
          return const Center(
            child: Column(
              children: [Text('Done!')],
            ),
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
                                  if (kDebugMode)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(state.answers.toString()),
                                      ],
                                    ),
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
            ),
          ),
        );
      },
    );
  }
}
