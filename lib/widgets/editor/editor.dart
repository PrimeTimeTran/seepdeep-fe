// ignore_for_file: must_be_immutable, depend_on_referenced_packages, deprecated_member_use, duplicate_ignore
import 'dart:async';

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';

class Editor extends StatefulWidget {
  Function onRun;
  Problem problem;
  Function onType;
  Editor({
    super.key,
    required this.onRun,
    required this.onType,
    required this.problem,
  });

  @override
  State<Editor> createState() => _EditorState();
}

// camelCase
// C++, Java, Python, Python3, C, JS, TS, PHP, Swift, Kotlin, Dart, Go, Scala

// snake_case
// Ruby, Rust, Erlang, Elixir

// TitleCase
// C#,

class _EditorState extends State<Editor> {
  int step = 1;
  Language selectedItem = Language.python;
  final GlobalKey _codeEditorKey = GlobalKey();
  late CodeController _controller = methodBuilder();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  PopupMenuButton<Language>(
                    initialValue: selectedItem,
                    onSelected: (Language item) {
                      setState(() {
                        selectedItem = item;
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<Language>>[
                      buildMenuItem(
                          'Python', Icons.keyboard, AppScreens.explore.path),
                      buildMenuItem('JS', Icons.note_alt_outlined,
                          AppScreens.featureRequests.path),
                      buildMenuItem(
                          'C++', Icons.bug_report, AppScreens.bugReports.path),
                      buildMenuItem(
                          'TS', Icons.bug_report, AppScreens.bugReports.path),
                    ],
                    child: TextButton.icon(
                      onPressed: null,
                      icon:
                          const Icon(size: 20, Icons.code, color: Colors.green),
                      label: const Text(
                        'Code',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.keyboard,
                      size: 20,
                    ),
                    color: Colors.black54,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.format_align_center,
                      size: 20,
                    ),
                    color: Colors.black54,
                    onPressed: () {
                      // _formatCode();
                    },
                  ),
                ],
              ),
            ],
          ),
          RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (RawKeyEvent event) {
              if (event is RawKeyDownEvent) {
                if (event.isControlPressed &&
                    event.logicalKey == LogicalKeyboardKey.enter) {
                  onRun();
                } else if (event.logicalKey == LogicalKeyboardKey.tab) {
                  final TextEditingValue value = _controller.value;
                  final int start = value.selection.baseOffset;
                  final int end = value.selection.extentOffset;
                  final String newText =
                      value.text.replaceRange(start, end, '  ');
                  _controller.value = TextEditingValue(
                    text: newText,
                    selection: TextSelection.collapsed(offset: start + 2),
                  );
                  return;
                } else {
                  widget.onType(_controller.text);
                }
              }
              return;
            },
            child: CodeTheme(
              data: CodeThemeData(styles: vsTheme),
              child: CodeField(
                key: _codeEditorKey,
                controller: _controller,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<Language> buildMenuItem(
      String title, IconData icon, String route) {
    return PopupMenuItem<Language>(
      value: Language.python,
      onTap: () {
        // GoRouter.of(context).go(route);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Icon(icon), const SizedBox(width: 5.0), Text(title)],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _controller = methodBuilder(widget.problem);
      widget.onType(_controller.text);
      setState(() {
        _controller = _controller;
      });
    });
  }

  onRun() {
    String code = _controller.text;
    widget.onRun(code);
  }
}
