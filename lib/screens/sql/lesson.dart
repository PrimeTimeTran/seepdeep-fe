import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import './markdown_styles.dart';
import './temp_lesson.dart';

Future<String> checkProgress() async {
  final lessonId = await Storage.instance.getSQLLesson();
  return lessonId ?? '1.0';
}

Future<String> loadData() async {
  final String lessonId = await checkProgress();
  return await loadMarkdownContent(lessonId);
}

Future<String> loadMarkdownContent(String lessonId) async {
  try {
    String data = lesson;
    if (true) {
      String path = 'assets/lessons/sql/$lessonId.md';
      data = await rootBundle.loadString(path);
    }
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
              return Markdown(
                selectable: true,
                data: snapshot.data!,
                styleSheet: _isDarkMode ? myStyleSheetDark : myStyleSheet,
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
