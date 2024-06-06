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

class DynamicInputsWidget extends StatefulWidget {
  final List<TextEditingController> controllers;
  final Function(String, int) onChanged;

  const DynamicInputsWidget({
    super.key,
    required this.controllers,
    required this.onChanged,
  });

  @override
  State<DynamicInputsWidget> createState() => _DynamicInputsWidgetState();
}

class _AnswerPanelState extends State<AnswerPanel> {
  String dropdownValue = '';
  bool isTrueOrFalse = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      buildWhen: (previous, current) {
        return previous.problemIdx != current.problemIdx ||
            previous.activeAnswer != current.activeAnswer;
      },
      builder: (blocContext, state) {
        return Card.outlined(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                buildAnswerInputs(blocContext, state),
                // buildFollowUpAnswers(state),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Gap(20),
                    SizedBox(
                      height: 40,
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
                      height: 40,
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
                      height: 40,
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
                      height: 40,
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
    Map<String, dynamic> activeAnswer = state.activeAnswer;
    if (activeAnswer['type'] == 'mc') {
      List<String> options = (state.activeAnswer['options'] as List<dynamic>)
          .map((item) => item.toString())
          .toList();

      items.add(Padding(
        padding: const EdgeInsets.all(30),
        child: buildSelectDropdown(
          blocContext,
          options,
        ),
      ));
    } else if (activeAnswer['type'] == 'tf') {
      items.add(Padding(
        padding: const EdgeInsets.all(30),
        child: buildTrueFalse(blocContext),
      ));
    } else {
      bool isMultiAnswer = activeAnswer['isMulti'];
      int answerLength = activeAnswer['answers'].length;
      List<TextEditingController> controllers = [];
      List<List<TextEditingController>> controllersMulti = [[]];
      if (isMultiAnswer) {
        // INFO: Answers which are lists
        controllersMulti = List.generate(
          activeAnswer['answers'].length,
          (outerIdx) => List.generate(
            activeAnswer['answers'][outerIdx].length,
            (innerIdx) => TextEditingController(
              text:
                  activeAnswer['answers'][outerIdx][innerIdx]?.toString() ?? '',
            ),
          ),
        );
      } else {
        controllers = List.generate(
          answerLength,
          (idx) => TextEditingController(
              text: activeAnswer['answers'][idx].toString()),
        );
      }

      for (int i = 0; i < answerLength; i++) {
        items.add(
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              children: [
                Text(
                  '${answerLength == 0 ? 'Answer' : optionLabels[i]}: ',
                  style: Style.of(context, 'labelL').copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: themeColor(context, 'secondary'),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 150,
                  width: 200,
                  child: isMultiAnswer
                      ? DynamicInputsWidget(
                          controllers: controllersMulti[i],
                          onChanged: (value, idx) {
                            blocContext
                                .read<QuizBloc>()
                                .add(AnswerProblemMulti(i, idx, value));
                          },
                        )
                      : DynamicInputsWidget(
                          controllers: [controllers[i]],
                          onChanged: (value, idx) {
                            blocContext
                                .read<QuizBloc>()
                                .add(AnswerProblem(i, value));
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      }
    }
    return Align(
      alignment: Alignment.centerRight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ),
      ),
    );
  }

  Widget buildFollowUpAnswers(state) {
    List<Widget> items = [];
    Map<String, dynamic> answer = state.activeAnswer;
    int lengthOfAnswers = answer['followUpAnswers'].length;
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

  Widget buildSelectDropdown(
    BuildContext blocContext,
    List<dynamic> list, [
    i = 0,
  ]) {
    List<String> options = list.map((item) => item.toString()).toList();
    String value;
    if (dropdownValue != '') {
      value = dropdownValue;
    } else {
      value = options.isNotEmpty ? options[0] : '';
    }
    return DropdownButton<String>(
      value: value,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        if (value != null) {
          blocContext.read<QuizBloc>().add(AnswerProblem(i, value));
          setState(() {
            dropdownValue = value;
          });
        }
      },
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget buildTrueFalse(BuildContext blocContext, [i = 0]) {
    return Switch(
      value: isTrueOrFalse,
      onChanged: (bool value) {
        blocContext.read<QuizBloc>().add(AnswerProblem(i, value.toString()));
        setState(() {
          isTrueOrFalse = value;
        });
      },
    );
  }
}

class _DynamicInputsWidgetState extends State<DynamicInputsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: widget.controllers.asMap().entries.map((entry) {
        // INFO: Required to fix the cursor moving left
        final int index = entry.key;
        final TextEditingController controller = entry.value;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            key: ValueKey(index),
            controller: controller,
            // TODO: Fix focus to stay within this widget before moving to next group.
            onChanged: (value) {
              widget.onChanged(value, index);
            },
            decoration: const InputDecoration(
              hintText: 'Answer',
            ),
          ),
        );
      }).toList(),
    );
  }
}
