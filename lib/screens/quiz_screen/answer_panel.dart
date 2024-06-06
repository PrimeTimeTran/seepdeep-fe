import 'package:app/all.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'bloc/all.dart';
import 'math.helpers.dart';

class AnswerPanel extends StatefulWidget {
  const AnswerPanel({super.key});

  @override
  State<AnswerPanel> createState() => _AnswerPanelState();
}

class _AnswerPanelState extends State<AnswerPanel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      buildWhen: (previous, current) {
        return previous.problemIdx != current.problemIdx;
      },
      builder: (blocContext, state) {
        return Card.outlined(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildAnswerInputs(blocContext, state),
                // buildFollowUpAnswers(state),
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
                          blocContext.read<QuizBloc>().add(PrevButtonPress());
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
                          blocContext.read<QuizBloc>().add(NextButtonPress());
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
                          blocContext
                              .read<QuizBloc>()
                              .add(FinishQuizButtonPress());
                        },
                        icon: const Icon(Icons.keyboard_return),
                      ),
                    ),
                  ],
                ),
                const Gap(10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildAnswerInputs(BuildContext blocContext, QuizState state) {
    List<Widget> items = [];
    Map<String, dynamic> activeAnswer = state.activeAnswer!;
    int answerLength = activeAnswer['answers'].length;

    List<TextEditingController> controllers = List.generate(
      answerLength,
      (idx) => TextEditingController(text: activeAnswer['answers'][idx] ?? ''),
    );

    for (int i = 0; i < answerLength; i++) {
      items.add(
        Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            children: [
              Text(
                '${i + 1 == 1 ? 'Answer' : optionLabels[i]}: ',
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
                  controller: controllers[i],
                  decoration: const InputDecoration(
                    hintText: 'Answer',
                  ),
                  onChanged: (value) {
                    blocContext.read<QuizBloc>().add(AnswerProblem(i, value));
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

  Widget buildFollowUpAnswers(state) {
    List<Widget> items = [];
    Map<String, dynamic> answer = state.activeAnswer;
    int lengthOfAnswers = answer['followUpAnswers'].length;
    // List<TextEditingController> controllers =
    //     List.generate(lengthOfAnswers, (_) => TextEditingController());
    for (int i = 0; i < lengthOfAnswers; i++) {
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
                  decoration: const InputDecoration(
                    hintText: 'Answer',
                  ),
                  onChanged: (value) {
                    setState(() {
                      answer['followUpAnswers'][i] = value;
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
}
