import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';

// ignore: must_be_immutable
class Editor extends StatefulWidget {
  Function onRun;
  Function onType;
  // Languages selectedLang;
  Editor({super.key, required this.onRun, required this.onType});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
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
                // widget.onType(getController(Languages.python).text);
                if (event.isControlPressed &&
                    event.logicalKey == LogicalKeyboardKey.enter) {
                  onRun();
                } else {
                  widget.onType(getController(Languages.python).text);
                }
              }
            },
            child: CodeTheme(
              data: CodeThemeData(styles: vsTheme),
              child: CodeField(
                key: _codeEditorKey,
                controller: getController(Languages.python),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onRun() {
    String code = getController(Languages.python).text;
    widget.onRun(code);
  }

  updateCode() {}
}
