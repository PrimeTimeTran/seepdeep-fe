import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';

import 'setups.dart';

// ignore: must_be_immutable
class CodeEditorScreen extends StatefulWidget {
  Function onRun;
  Languages selectedLang;
  CodeEditorScreen(
      {super.key, required this.onRun, required this.selectedLang});

  @override
  State<CodeEditorScreen> createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  final GlobalKey _codeEditorKey = GlobalKey();
  var step = 1;
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
                  IconButton(
                    icon: const Icon(
                      Icons.code,
                      size: 20,
                    ),
                    color: Colors.black54,
                    onPressed: () {},
                  ),
                  const Text('Code')
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
                ],
              ),
            ],
          ),
          // ignore: deprecated_member_use
          RawKeyboardListener(
            focusNode: FocusNode(),
            // ignore: deprecated_member_use
            onKey: (RawKeyEvent event) {
              // ignore: deprecated_member_use
              if (event is RawKeyDownEvent) {
                // ignore: deprecated_member_use
                // setState(() {
                //   step = 2;
                // });
                if (event.isControlPressed &&
                    event.logicalKey == LogicalKeyboardKey.enter) {
                  onRun();
                }
              }
            },
            child: CodeTheme(
              data: CodeThemeData(styles: vsTheme),
              child: CodeField(
                key: _codeEditorKey,
                controller: getController(widget.selectedLang),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onRun() {
    String code = getController(widget.selectedLang).text;
    widget.onRun(code);
  }
}
