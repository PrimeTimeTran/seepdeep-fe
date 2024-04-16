import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';

import 'setups.dart';

// ignore: must_be_immutable
class CodeEditorScreen extends StatefulWidget {
  Function onRun;
  CodeEditorScreen({super.key, required this.onRun});

  @override
  State<CodeEditorScreen> createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  String selectedLang = 'sql';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          CodeTheme(
            data: CodeThemeData(styles: vsTheme),
            child: CodeField(
              controller: getController(selectedLang),
            ),
          ),
          TextButton.icon(
            onPressed: onRun,
            icon: const Icon(Icons.play_circle_outline),
            label: const Text('Run'),
          ),
        ],
      ),
    );
  }

  onRun() {
    String code = getController(selectedLang).text;
    widget.onRun(code);
  }
}
