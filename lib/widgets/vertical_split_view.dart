// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:app/all.dart';
import 'package:flutter/material.dart';

class HorizontalSplitView extends StatefulWidget {
  final Widget top;
  final Widget bottom;
  final double ratio;

  const HorizontalSplitView({
    super.key,
    required this.top,
    required this.bottom,
    this.ratio = .55,
  })  : assert(ratio >= 0),
        assert(ratio <= 1);

  @override
  _HorizontalSplitViewState createState() => _HorizontalSplitViewState();
}

class HoverableContainer extends StatefulWidget {
  final Widget child;
  final width;
  final height;

  const HoverableContainer(
      {super.key, required this.child, this.width, this.height});

  @override
  _HoverableContainerState createState() => _HoverableContainerState();
}

class VerticalSplitView extends StatefulWidget {
  final Widget left;
  final Widget right;
  final double ratio;

  const VerticalSplitView(
      {super.key, required this.left, required this.right, this.ratio = 0.3})
      : assert(ratio >= 0),
        assert(ratio <= 1);

  @override
  _VerticalSplitViewState createState() => _VerticalSplitViewState();
}

class _HorizontalSplitViewState extends State<HorizontalSplitView> {
  double _ratio = 1;
  double _maxHeight = 100;
  final _dividerHeight = 14.0;
  double get _height1 => _ratio * _maxHeight;
  double get _height2 => (1 - _ratio) * _maxHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        assert(_ratio <= 1);
        assert(_ratio >= 0);
        if (_maxHeight != constraints.maxHeight) {
          _maxHeight = constraints.maxHeight - _dividerHeight;
        }

        return Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                width: 1,
              ),
            ),
          ),
          child: SizedBox(
            height: constraints.maxHeight + 33,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _height1,
                  child: widget.top,
                ),
                HoverableContainer(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: SizedBox(
                        height: _dividerHeight,
                        child: const Icon(Icons.drag_handle),
                      ),
                    ),
                    onPanUpdate: (DragUpdateDetails details) {
                      setState(() {
                        _ratio += details.delta.dy / _maxHeight;
                        if (_ratio > 1) {
                          _ratio = 1;
                        } else if (_ratio < 0.0) {
                          _ratio = 0.0;
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: _height2,
                  width: double.infinity,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1,
                        ),
                      ),
                    ),
                    child: widget.bottom,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _ratio = widget.ratio;
  }
}

class _HoverableContainerState extends State<HoverableContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? 5,
        decoration: BoxDecoration(
          color: _isHovered ? Colors.grey.lighten(80) : null,
        ),
        child: widget.child,
      ),
    );
  }
}

class _VerticalSplitViewState extends State<VerticalSplitView> {
  double _ratio = 1;
  double _maxWidth = 100;
  final _dividerWidth = 8.0;
  get _width1 => _ratio * _maxWidth;
  get _width2 => (1 - _ratio) * _maxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      assert(_ratio <= 1);
      assert(_ratio >= 0);
      if (_maxWidth != constraints.maxWidth) {
        _maxWidth = constraints.maxWidth - _dividerWidth;
      }
      return SizedBox(
        width: constraints.maxWidth,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: _width1,
              child: widget.left,
            ),
            HoverableContainer(
              width: _dividerWidth,
              height: constraints.maxHeight,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SizedBox(
                    width: _dividerWidth,
                    height: constraints.maxHeight,
                    child: const RotationTransition(
                      turns: AlwaysStoppedAnimation(0.25),
                      child: Icon(Icons.drag_handle),
                    ),
                  ),
                ),
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _ratio += details.delta.dx / _maxWidth;
                    if (_ratio > 1) {
                      _ratio = 1;
                    } else if (_ratio < 0.0) _ratio = 0.0;
                  });
                },
              ),
            ),
            SizedBox(width: _width2, child: widget.right),
          ],
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _ratio = widget.ratio;
  }
}
