import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';

import 'math.helpers.dart';

GlobalKey _one = GlobalKey();
GlobalKey _three = GlobalKey();
GlobalKey _two = GlobalKey();

class CategoryCard extends StatefulWidget {
  final String category;
  const CategoryCard({super.key, required this.category});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class MathIntroScreen extends StatefulWidget {
  const MathIntroScreen({super.key});

  @override
  State<MathIntroScreen> createState() => _MathIntroScreenState();
}

class _CategoryCardState extends State<CategoryCard> {
  String selectedSubject = '';
  String selectedSubjectTitle = '';
  String content = categoryIntroMap['Limits']!;
  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(
          minHeight: 400,
          maxHeight: 500,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.category,
              style: Style.of(
                context,
                'displayS',
              ),
            ),
            const Gap(10),
            InputDecorator(
              decoration: InputDecoration(
                labelText: 'Subjects',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Wrap(
                children: [
                  ...buildButtons(widget.category),
                ],
              ),
            ),
            const Gap(10),
            Text(
              content,
              style: Style.of(context, 'headlineS'),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Todo: Fix multiple uses of GlobalKey when Showcase is used here.
                SizedBox(
                  width: 500,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: selectedSubjectTitle != ''
                        ? ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.green,
                            ),
                          )
                        : null,
                    icon: Icon(Icons.track_changes_outlined,
                        color: Theme.of(context).colorScheme.primary),
                    label: Text('Practice: $selectedSubjectTitle',
                        style: selectedSubjectTitle != ''
                            ? const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )
                            : null),
                    onPressed: () {
                      if (selectedSubjectTitle == '') {
                        Glob.showSnack(
                            'Select a subject then you can practice by pressing the green button.');
                        return;
                      }
                      String encodedSubject =
                          Uri.encodeComponent(selectedSubject);
                      String navigationUrl = '/math/$encodedSubject';
                      GoRouter.of(context).go(navigationUrl);
                    },
                  ),
                ),

                // Showcase(
                //   key: _three,
                //   description:
                //       'Once you\'re ready you can practice exercises here.',
                //   onBarrierClick: () => debugPrint('Barrier clicked'),
                //   child: )
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildButtons(domain) {
    final subjectSubjects = subjects['calculus'][domain]['subjects'];
    final vals = [];
    for (var i = 0; i < subjectSubjects.length; i++) {
      String name = subjectSubjects[i];
      String categoryName = name
          .replaceAll(' ', '-')
          .replaceAll('&', 'and')
          .replaceAll(',', '')
          .toLowerCase();
      bool isSelected = categoryName == selectedSubject;
      if (domain == 'Limits' && i == 1) {
        vals.add(
          GestureDetector(
            onTap: () => debugPrint('menu button clicked'),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: isSelected
                    ? const ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                        backgroundColor: WidgetStatePropertyAll(Colors.green))
                    : null,
                onPressed: () {
                  String encodedSubject = Uri.encodeComponent(categoryName);
                  String navigationUrl = '/math/$encodedSubject';
                  // GoRouter.of(context).go(navigationUrl);
                  // String navigationUrl = '/math/test';
                  // String navigationUrl = '/math/test-latex';
                  setState(() {
                    selectedSubjectTitle = name;
                    selectedSubject = categoryName;
                    content = subjects['calculus'][domain][name]['description'];
                  });
                },
                child: Text(name),
              ),
            ),
          ),
        );
        // vals.add(Showcase(
        //   key: _two,
        //   description:
        //       'Select from a concept\'s subjects to see it\'s description before practicing it with exercises.',
        //   onBarrierClick: () => debugPrint('Barrier clicked'),
        //   child: ,
        // ));
      } else {
        vals.add(
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: isSelected
                  ? const ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor: WidgetStatePropertyAll(Colors.green))
                  : null,
              onPressed: () {
                String encodedSubject = Uri.encodeComponent(categoryName);
                String navigationUrl = '/math/$encodedSubject';
                // GoRouter.of(context).go(navigationUrl);
                // String navigationUrl = '/math/test';
                // String navigationUrl = '/math/test-latex';
                setState(() {
                  selectedSubjectTitle = name;
                  selectedSubject = categoryName;
                  content = subjects['calculus'][domain][name]['description'];
                });
              },
              child: Text(name),
            ),
          ),
        );
      }
    }
    return vals.toList();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      content = categoryIntroMap[widget.category]!;
    });
  }
}

class _MathIntroScreenState extends State<MathIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dialogBuilder(
            context,
            'Maths Screen',
            'Start developing your skills at higher level mathematics with us today.\nChoose a topic that sounds interesting, read the description below,\nand then dive into some examples with practice!',
          );
        },
        child: const Icon(Icons.help),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Calculus',
                      style: Style.of(
                        context,
                        'displayL',
                      ),
                    ),
                  ),
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Showcase(
                  //   key: _one,
                  //   description:
                  //       'Concept Cards organize the major subjects of a course. Brief descriptions of each subject are presented below the list as well. Click on any topic to see it\'s description. \'.',
                  //   onBarrierClick: () => debugPrint('Barrier clicked'),
                  //   child: GestureDetector(
                  //     onTap: () => debugPrint('menu button clicked'),
                  //     child: const CategoryCard(
                  //       category: 'Limits',
                  //     ),
                  //   ),
                  // ),
                  CategoryCard(
                    category: 'Limits',
                  ),
                  Gap(50),
                  CategoryCard(
                    category: 'Derivatives',
                  ),
                  Gap(50),
                  CategoryCard(
                    category: 'Applications of Derivatives',
                  ),
                  Gap(50),
                  CategoryCard(
                    category: 'Integrals',
                  ),
                  Gap(50),
                  CategoryCard(
                    category: 'Applications of Integrals',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  checkIntroCompleted() async {
    final items = await Storage.instance.getIntros();
    if (!items.contains('math-screen-done')) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ShowCaseWidget.of(context).startShowCase([_one, _two, _three]));
    }
  }

  @override
  initState() {
    super.initState();
    // checkIntroCompleted();
  }
}
