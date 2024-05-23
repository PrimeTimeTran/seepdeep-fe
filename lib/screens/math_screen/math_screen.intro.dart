import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import './math.helpers.dart';

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
            Wrap(
              children: [
                ...buildButtons(widget.category),
              ],
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
                SizedBox(
                  width: 500,
                  height: 50,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.track_changes_outlined),
                    label: Text('Practice: $selectedSubjectTitle'),
                    onPressed: () {
                      String encodedSubject =
                          Uri.encodeComponent(selectedSubject);
                      String navigationUrl = '/math/$encodedSubject';
                      GoRouter.of(context).go(navigationUrl);
                    },
                  ),
                )
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
      vals.add(
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            style: isSelected
                ? const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    backgroundColor: MaterialStatePropertyAll(Colors.green))
                : null,
            onPressed: () {
              String encodedSubject = Uri.encodeComponent(categoryName);
              String navigationUrl = '/math/$encodedSubject';
              GoRouter.of(context).go(navigationUrl);
              // setState(() {
              //   selectedSubjectTitle = name;
              //   selectedSubject = categoryName;
              //   content = subjects['calculus'][domain][name]['description'];
              // });
            },
            child: Text(name),
          ),
        ),
      );
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
    return SingleChildScrollView(
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
                CategoryCard(
                  category: 'Limits',
                ),
                Gap(50),
                CategoryCard(
                  category: 'Derivatives',
                ),
                Gap(50),
                CategoryCard(
                  category: 'Integrals',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
