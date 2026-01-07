import 'dart:async';
import 'dart:html' as html;
import 'dart:js_util' as js_util;
import 'dart:ui_web' as ui;

import 'package:app/all.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AceEditorScreen extends StatefulWidget {
  final Function onRun;
  final Problem problem;

  const AceEditorScreen({
    super.key,
    required this.onRun,
    required this.problem,
  });

  @override
  State<AceEditorScreen> createState() => _AceEditorScreenState();
}

class _AceEditorScreenState extends State<AceEditorScreen> {
  late final String _viewType;

  html.IFrameElement? _iframe;

  String? _cachedCode;
  bool _iframeLoaded = false;
  bool _editorReady = false;
  bool _codeSent = false;

  late final StreamSubscription<html.MessageEvent> _msgSub;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HtmlElementView(
        key: ValueKey(_viewType), // 🔥 forces iframe recreation
        viewType: _viewType,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant AceEditorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.problem.id != widget.problem.id) {
      _iframeLoaded = false;
      _editorReady = false;
      _codeSent = false;
      _iframe = null;

      _cachedCode = selectInitialCode(Language.python, widget.problem);
    }
  }

  @override
  void dispose() {
    _msgSub.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _viewType =
        'ace-editor-${widget.problem.id}-${DateTime.now().millisecondsSinceEpoch}';

    _cachedCode = selectInitialCode(Language.python, widget.problem);

    _registerFactory();
    _loadCode();

    _msgSub = html.window.onMessage.listen(_handleMessage);
  }

  void _handleMessage(html.MessageEvent event) {
    if (event.data == null) return;

    // ✅ Convert JS object → Dart Map safely
    final data = js_util.dartify(event.data);

    if (data is! Map) return;

    final type = data['type'];
    final messageProblemId = data['problemId'];

    if (messageProblemId != null && messageProblemId != widget.problem.id) {
      return;
    }

    switch (type) {
      case 'ace-ready':
        _editorReady = true;
        _trySendCode();
        break;

      case 'ace-change':
        Storage.instance.setProblemCode(
          widget.problem.id,
          'python',
          data['value'] ?? '',
        );
        break;

      case 'ace-run':
        debugPrint('Run');
        widget.onRun(data['value'] ?? '', Language.python);
        break;

      case 'ace-submit':
        debugPrint('Submit');
        widget.onRun(data['value'] ?? '', Language.python);
        break;
    }
  }

  Future<void> _loadCode() async {
    final saved = await Storage.instance.getProblemCode(
      widget.problem.id,
      'python',
    );

    if (!mounted) return;

    _cachedCode = saved?.isNotEmpty == true
        ? saved
        : selectInitialCode(Language.python, widget.problem);

    _trySendCode();
  }

  void _registerFactory() {
    ui.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId) {
        final iframe = html.IFrameElement()
          ..id = 'iframe-${widget.problem.id}'
          ..src = '/ace/index.html?problemId=${widget.problem.id}'
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';

        iframe.onLoad.listen((_) {
          _iframe = iframe;
          _iframeLoaded = true;
          _trySendCode();
        });

        return iframe;
      },
    );
  }

  void _trySendCode() {
    if (_codeSent) return;
    if (!_iframeLoaded || !_editorReady) return;
    if (_cachedCode == null) return;

    _iframe!.contentWindow!.postMessage(
      {
        'type': 'set-code',
        'value': _cachedCode,
        'problemId': widget.problem.id,
      },
      '*',
    );

    _codeSent = true;
  }
}
