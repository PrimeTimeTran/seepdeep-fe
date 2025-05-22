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
  Language? lang;
  Editor({
    super.key,
    required this.onRun,
    required this.onType,
    required this.problem,
    this.lang,
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
                      buildMenuItem('Ruby', Icons.keyboard, Language.ruby),
                      buildMenuItem(
                          'Javascript', Icons.note_alt_outlined, Language.js),
                      buildMenuItem(
                          'Typescript', Icons.bug_report, Language.ts),
                      buildMenuItem('Dart', Icons.bug_report, Language.dart),
                      buildMenuItem('C++', Icons.bug_report, Language.cpp),
                      buildMenuItem('Java', Icons.bug_report, Language.java),
                      buildMenuItem('Go', Icons.bug_report, Language.go),
                      // buildMenuItem('SQL', Icons.bug_report, Language.sql),
                    ],
                    child: TextButton.icon(
                        onPressed: null,
                        icon: const Icon(
                            size: 20, Icons.code, color: Colors.green),
                        label: AppText(
                          text: selectedLanguageName(selectedLang),
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  // TODO: Format code
                  IconButton(
                    icon: const Icon(
                      Icons.format_indent_increase,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                  // TODO: Reset
                  IconButton(
                    icon: const Icon(
                      Icons.restart_alt_rounded,
                      size: 20,
                    ),
                    onPressed: () {
                      setController();
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.keyboard,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                  Tooltip(
                    message: 'Submit Code (CTRL + ENTER)',
                    child: IconButton(
                      icon: const Icon(
                        Icons.play_arrow,
                        size: 20,
                      ),
                      onPressed: () {
                        final RenderBox button =
                            context.findRenderObject() as RenderBox;
                        final RenderBox overlay = Overlay.of(context)
                            .context
                            .findRenderObject() as RenderBox;
                        final Offset position = button
                            .localToGlobal(Offset.zero, ancestor: overlay);
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.format_align_center,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          RawKeyboardListener(
            focusNode: focusNode,
            onKey: _handleKeyboardPress,
            child: CodeTheme(
              data: CodeThemeData(
                // INFO: Themes
                // https://github.com/git-touch/highlight.dart/tree/master/flutter_highlight/lib/themes
                styles: Style.currentTheme(context) == Brightness.light
                    ? vsTheme
                    : atelierCaveDarkTheme,
                // Not so great
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
                height: widget.lang != null ? 400 : 900,
                width: double.infinity,
                child: CodeField(
                  textStyle: const TextStyle(
                    height: 1.5,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
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
    if (widget.lang != null) {
      Future.delayed(Duration.zero, () => setController(Language.sql));
      setState(() {
        selectedLang = Language.sql;
      });
    } else {
      Future.delayed(Duration.zero, setController);
    }
  }

  setController([Language? lang]) {
    _controller = selectCodeController(lang ?? selectedLang, widget.problem);
    widget.onType(_controller.text, lang ?? selectedLang);
    setState(() {
      _controller = _controller;
    });
  }

  _handleKeyboardPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.tab) {
      final selection = _controller.selection;
      final text = _controller.text;
      final newText = text.replaceRange(
        selection.start,
        selection.end,
        '    ',
      );
      _controller.text = newText;
      final newPosition = selection.start + 4;
      _controller.selection = TextSelection.collapsed(offset: newPosition);
    }
    if (event is RawKeyDownEvent) {
      if (event.isControlPressed &&
          event.logicalKey == LogicalKeyboardKey.enter) {
        _onShortcutRun();
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
        widget.onType(_controller.text, selectedLang);
      }
    }
    return;
  }

  _onShortcutRun() {
    String code = _controller.text;
    widget.onRun(code, selectedLang);
  }
}
