import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

MarkdownStyleSheet myStyleSheet = MarkdownStyleSheet(
  h1: const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
  h2: const TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
  p: const TextStyle(fontSize: 16, color: Colors.black),
  a: const TextStyle(color: Colors.blue),
  listBullet: const TextStyle(fontSize: 16, color: Colors.grey),
  code: TextStyle(
    backgroundColor: Colors.blue.shade200,
    fontSize: 16,
    decorationThickness: 10,
  ),
  codeblockDecoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(4),
  ),
);

MarkdownStyleSheet myStyleSheetDark = MarkdownStyleSheet(
  h1: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
  h2: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  ),
  p: const TextStyle(
    fontSize: 16,
    color: Colors.white,
  ),
  a: const TextStyle(
    color: Colors.blue,
  ),
  listBullet: const TextStyle(
    fontSize: 16,
    color: Colors.grey,
  ).copyWith(
    color: Colors.white,
  ),
  code: TextStyle(
    backgroundColor: Colors.blue.shade900,
    fontSize: 16,
  ),
  codeblockDecoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(4),
  ),
);

Future<String> checkProgress() async {
  final lessonId = await Storage.instance.getSQLLesson();
  print(lessonId);
  return lessonId ?? '1.0';
}

Future<String> loadData() async {
  final String lessonId = await checkProgress();
  return await loadMarkdownContent(lessonId);
}

Future<String> loadMarkdownContent(String lessonId) async {
  try {
    String path = 'assets/lessons/sql/$lessonId.md';
    final data = await rootBundle.loadString(path);
    return data;
  } catch (e) {
    print("Error loading Markdown content: $e");
    return '';
  }
}

class LessonMarkDown extends StatefulWidget {
  const LessonMarkDown({super.key});

  @override
  State<LessonMarkDown> createState() => _LessonMarkDownState();
}

class _LessonMarkDownState extends State<LessonMarkDown> {
  late bool _isDarkMode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight() / 2,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<String>(
          future: loadData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading Markdown content.'),
              );
            } else {
              // return Container(
              //   // color: Theme.of(context).secondaryHeaderColor,
              //   // color: Theme.of(context).splashColor,
              //   child: Markdown(
              //     selectable: true,
              //     data: snapshot.data!,
              //   ),
              // );
              return Markdown(
                styleSheet: _isDarkMode ? myStyleSheetDark : myStyleSheet,
                data: snapshot.data!,
                onTapLink: (text, url, title) {
                  launchUrl(Uri.parse(url!));
                },
              );
            }
          },
        ),
      ),
    );
  }

  getStoredTheme() async {
    _isDarkMode = await Storage.instance.getTheme();
    setState(() {
      _isDarkMode = _isDarkMode;
    });
  }

  @override
  void initState() {
    super.initState();
    checkProgress();
    getStoredTheme();
  }
}
