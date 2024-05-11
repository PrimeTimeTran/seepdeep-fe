import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

MarkdownStyleSheet myStyleSheet = MarkdownStyleSheet(
  h1: const TextStyle(
      fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
  h2: const TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
  h3: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  h2Padding: const EdgeInsets.only(top: 20),
  p: const TextStyle(fontSize: 16, color: Colors.black),
  a: const TextStyle(color: Colors.blue),
  listBullet: const TextStyle(fontSize: 16, color: Colors.grey),
  // code: TextStyle(
  //   fontSize: 16,
  //   decorationThickness: 10,
  //   backgroundColor: Colors.blue.shade200,
  // ),
  // codeblockDecoration: BoxDecoration(
  //   color: Colors.grey.shade200,
  //   borderRadius: BorderRadius.circular(4),
  // ),
);

MarkdownStyleSheet myStyleSheetDark = MarkdownStyleSheet(
  h1: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
  h2: const TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
  h3: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  h2Padding: const EdgeInsets.only(top: 20),
  p: const TextStyle(
    fontSize: 16,
    color: Colors.white,
  ),
  a: const TextStyle(
    color: Colors.blue,
  ),
  listBullet: const TextStyle(
    fontSize: 16,
    color: Colors.grey,
  ).copyWith(
    color: Colors.white,
  ),
  // code: TextStyle(
  //   fontSize: 16,
  //   backgroundColor: Colors.blue.shade900,
  // ),
  // codeblockDecoration: BoxDecoration(
  //   color: Colors.grey.shade200,
  //   borderRadius: BorderRadius.circular(4),
  // ),
);
