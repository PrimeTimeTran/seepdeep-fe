import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key});

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  final pics = [
    'argh.png',
    'bliss.png',
    'doubtful.png',
    'focus.png',
    'hic.png',
    'how.png',
    'leggo.png',
    'patience.png',
    'rage.png',
    'there.png',
    'aww.png',
    'derp.png',
    'dumbfounded.png',
    'hehe.png',
    'hm.png',
    'lawl.png',
    'prepared.png',
    'tears.png',
    'wojak.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 5,
      children: [...buildPreviews()],
    ));
  }

  buildPreviews() {
    List<Widget> imgs = [];
    for (var fileName in pics) {
      String url =
          'https://storage.googleapis.com/turboship-dev-alpha/feelings/$fileName';
      imgs.add(
        GestureDetector(
          onTap: () {
            GoRouter.of(context).go('/asset/$fileName');
          },
          child: Column(
            children: [
              Image.network(url),
              Text(
                fileName.split('.')[0],
                style: Style.of(
                  context,
                  'headlineL',
                ),
              )
            ],
          ),
        ),
      );
    }
    return imgs;
  }
}
