import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

MarkdownStyleSheet myStyleSheet = MarkdownStyleSheet(
  textScaler: const TextScaler.linear(1.75),
  h1: const TextStyle(
      fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
  h2: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  h3: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  h2Padding: const EdgeInsets.only(top: 20),
  a: const TextStyle(color: Colors.blue),
  listBullet: const TextStyle(fontSize: 16, color: Colors.grey),
);

MarkdownStyleSheet myStyleSheetDark = MarkdownStyleSheet(
  textScaler: const TextScaler.linear(1.75),
  h1: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
  h2: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  h3: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  h2Padding: const EdgeInsets.only(top: 20),
  a: const TextStyle(
    color: Colors.blue,
  ),
  listBullet: const TextStyle(
    fontSize: 16,
    color: Colors.grey,
  ).copyWith(
    color: Colors.white,
  ),
);
