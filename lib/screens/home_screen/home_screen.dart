import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:showcaseview/showcaseview.dart';

final cards = [
  CourseCard(
    'Calculus',
    '0',
    'https://picsum.photos/250?image=9',
    '1. Find your next adventure and get started by clicking here.',
    _one,
  ),
  CourseCard(
    'Data Structures & Algorithms',
    '0',
    'https://picsum.photos/250?image=9',
    '',
    _two,
  ),
];
GlobalKey _four = GlobalKey();
GlobalKey _one = GlobalKey();
GlobalKey _three = GlobalKey();
GlobalKey _two = GlobalKey();

class CourseCard {
  String title;
  String level;
  String imgUrl;
  GlobalKey key;
  String ftuePrompt;
  CourseCard(this.title, this.level, this.imgUrl, this.ftuePrompt, this.key);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCourseCard(context, cards[0]),
                const Gap(20),
                buildCourseCard(context, cards[1]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildCourseCard(BuildContext context, CourseCard card) {
    return Showcase(
      key: card.key,
      description: card.ftuePrompt,
      child: SizedBox(
        child: GestureDetector(
          onTap: () => debugPrint('menu button clicked'),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Pick up Where your left off',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.network(
                        card.imgUrl,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.album),
                      title: Text(card.title),
                      subtitle: Text('Level: ${card.level}'),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        child: Text(
                          'Continue Learning',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setupFTUE();
  }

  setupFTUE() async {
    final items = await Storage.instance.getIntros();
    if (!items.contains('home-screen-done')) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          await Future.delayed(const Duration(seconds: 1));
          ShowCaseWidget.of(context).startShowCase([_one]);
        },
      );
    }
  }
}
