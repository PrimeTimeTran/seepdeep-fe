import 'package:flutter/material.dart';
import 'package:seo/seo.dart';

class AppText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextTagStyle? tagStyle;

  const AppText({
    super.key,
    this.style,
    this.tagStyle,
    required this.text,
  });

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  @override
  Widget build(BuildContext context) {
    return Seo.text(
      text: widget.text,
      style: widget.tagStyle ?? TextTagStyle.p,
      child: Text(
        widget.text,
        style: widget.style,
      ),
    );
  }
}
