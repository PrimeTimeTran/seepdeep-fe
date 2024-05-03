// ignore_for_file: must_be_immutable, depend_on_referenced_packages, deprecated_member_use, duplicate_ignore
import 'dart:async';

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlighter/themes/atelier-cave-dark.dart';

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

class _EditorState extends State<Editor> {
  int step = 1;
  FocusNode focusNode = FocusNode();

  Language selectedLang = Language.python;
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
                    initialValue: selectedLang,
                    onSelected: (Language item) {
                      setState(() {
                        selectedLang = item;
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<Language>>[
                      buildMenuItem('Python', Icons.keyboard, Language.python),
                      buildMenuItem(
                          'Javascript', Icons.note_alt_outlined, Language.js),
                      buildMenuItem(
                          'Typescript', Icons.bug_report, Language.ts),
                      buildMenuItem('Dart', Icons.bug_report, Language.dart),
                      buildMenuItem('C++', Icons.bug_report, Language.cpp),
                      buildMenuItem('Java', Icons.bug_report, Language.java),
                      buildMenuItem('TS', Icons.bug_report, Language.ts),
                    ],
                    child: TextButton.icon(
                      onPressed: null,
                      icon:
                          const Icon(size: 20, Icons.code, color: Colors.green),
                      label: Text(
                        selectedLanguageName(selectedLang),
                        style: Style.bodyS.copyWith(color: Style.textColor),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Todo: Format code
                  IconButton(
                    icon: const Icon(
                      Icons.format_indent_increase,
                      size: 20,
                    ),
                    color: Colors.black54,
                    onPressed: () {},
                  ),
                  // Todo: Reset
                  IconButton(
                    icon: const Icon(
                      Icons.restart_alt_rounded,
                      size: 20,
                    ),
                    color: Colors.black54,
                    onPressed: () {
                      setController();
                    },
                  ),
                  // Todo: Shortcut Prompt
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
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          RawKeyboardListener(
            focusNode: focusNode,
            onKey: (RawKeyEvent event) {
              if (event is RawKeyDownEvent) {
                if (event.isControlPressed &&
                    event.logicalKey == LogicalKeyboardKey.enter) {
                  onRun();
                } else if (event.logicalKey == LogicalKeyboardKey.tab) {
                  TextEditingValue value = _controller.value;
                  int start = value.selection.baseOffset;
                  int end = value.selection.extentOffset;
                  String newText = value.text.replaceRange(start, end, '    ');
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
              data: CodeThemeData(
                // Info: Themes
                // https://github.com/git-touch/highlight.dart/tree/master/flutter_highlight/lib/themes
                styles: Style.currentTheme(context) == Brightness.light
                    ? vsTheme
                    : atelierCaveDarkTheme,
                // : vs2015Theme,
                // : a11yDarkTheme,
                // : atelierEstuaryDarkTheme,
                // : atelierForestDarkTheme,
                // : atelierSeasideDarkTheme,
                // : kimbieDarkTheme,
                // : obsidianTheme,
                // : schoolBookTheme,
                // : solarizedDarkTheme,
                // : paraisoDarkTheme,
                // : darkTheme,
              ),
              child: SizedBox(
                height: 900,
                width: double.infinity,
                child: CodeField(
                  textStyle: const TextStyle(
                      height: 1.5,
                      // decoration: TextDecoration.underline,
                      leadingDistribution: TextLeadingDistribution.even),
                  key: _codeEditorKey,
                  controller: _controller,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<Language> buildMenuItem(
      String title, IconData icon, Language lang) {
    return PopupMenuItem<Language>(
      value: lang,
      onTap: () {
        setController(lang);
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
    Future.delayed(Duration.zero, setController);
  }

  onRun() {
    String code = _controller.text;
    widget.onRun(code);
  }

  setController([Language? lang]) {
    _controller = selectCodeController(lang ?? selectedLang, widget.problem);
    widget.onType(_controller.text);
    setState(() {
      _controller = _controller;
    });
  }
}
