// ignore_for_file: must_be_immutable

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import './markdown_styles.dart';
import './sql.helpers.dart';

class LessonMarkDown extends StatefulWidget {
  int lessonId;
  LessonMarkDown({super.key, required this.lessonId});

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
          future: loadData(widget.lessonId),
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
