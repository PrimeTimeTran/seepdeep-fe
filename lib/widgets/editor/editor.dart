// ignore_for_file: must_be_immutable, depend_on_referenced_packages, deprecated_member_use, duplicate_ignore
import 'dart:async';

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

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
  Language selectedLang = Language.python;
  late CodeController _controller = methodBuilder();
  @override
  Widget build(BuildContext context) {
    return AceEditorScreen(
      key: ValueKey(widget.problem.id),
      onRun: widget.onRun,
      problem: widget.problem,
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

  void setController([Language? lang]) {
    _controller = selectCodeController(lang ?? selectedLang, widget.problem);
    setState(() {
      _controller = _controller;
    });
    setupPreviouslyTypedCode();
  }

  void setupPreviouslyTypedCode() {
    Storage.instance
        .getProblemCode(
      widget.problem.id,
      selectedLang,
    )
        .then((code) {
      if (code != null && code.isNotEmpty) {
        _controller.value = TextEditingValue(
          text: code,
          selection: TextSelection.collapsed(offset: code.length),
        );
        _controller.notifyListeners();
        setState(() {});
      }
    });
  }
}
