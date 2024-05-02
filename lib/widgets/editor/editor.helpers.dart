import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/sql.dart';

final dartController = CodeController(
  text: dartMain,
  language: dart,
);

var dartMain = """
void main() {
  print('Hello World');
}
""";

final sqlController = CodeController(
  text: sqlQuery,
  language: sql,
);

var sqlQuery = """
SELECT * FROM customers;
""";

String generateParameterString(Signature signature) {
  List<String> params = [];
  for (var parameter in signature.parameters) {
    params.add(parsePythonType(parameter));
  }
  return params.join(", ");
}

getController(selectedLang) {
  switch (selectedLang) {
    case Language.python:
      return methodBuilder();
    case Language.dart:
      return dartController;
    default:
      return sqlController;
  }
}

getLanguage(selectedLang) {
  switch (selectedLang) {
    case Language.python:
      return python;
    case 'dart':
      return dart;
    default:
      return sql;
  }
}

CodeController methodBuilder([Problem? problem]) {
  var pythonSort = """""";
  if (problem != null) {
    pythonSort = """
class Solution:
    def ${problem.title?.toCamelCase()}(self, ${generateParameterString(problem.signature!)}) -> ${parsePythonReturnType(problem.signature!.returnType)}:
""";
  }
  return CodeController(
    text: pythonSort,
    language: python,
    modifiers: [const TabModifier()],
  );
}

parsePythonReturnType(type) {
  if (type == 'string') {
    type = 'str';
  }
  return "$type";
}

parsePythonType(parameter) {
  String type = parameter['type'];
  if (type == 'string') {
    type = 'str';
  }
  String name = parameter['name'];
  return "$name: $type";
}

enum Language { python, cpp, js, ts, dart }

class TabModifier extends CodeModifier {
  const TabModifier() : super('\t');

  @override
  TextEditingValue? updateString(
      String text, TextSelection sel, EditorParams params) {
    final tmp = replace(text, sel.start, sel.end, " " * params.tabSpaces);
    return tmp;
  }
}
