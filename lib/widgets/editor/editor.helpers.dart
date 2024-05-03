import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/highlight_core.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/sql.dart';
import 'package:highlight/languages/typescript.dart';

String generateParameterString(Signature signature) {
  List<String> params = [];
  for (var parameter in signature.parameters) {
    params.add(parsePythonType(parameter));
  }
  return params.join(", ");
}

CodeController methodBuilder([Problem? problem]) {
  String code = "";
  if (problem != null) {
    code = selectInitialCode(Language.python, problem);
  }
  return CodeController(
    text: code,
    language: python,
    modifiers: [const TabModifier()],
  );
}

String parsePythonReturnType(String type) {
  if (type == 'string') {
    type = 'str';
  }
  return type;
}

String parsePythonType(parameter) {
  String type = parameter['type'];
  if (type == 'string') {
    type = 'str';
  }
  String name = parameter['name'];
  return "$name: $type";
}

CodeController selectCodeController(Language lang, Problem problem) {
  return CodeController(
    language: selectLanguage(lang),
    text: selectInitialCode(lang, problem),
  );
}

String selectInitialCode(Language lang, Problem problem) {
  final functionName = problem.title?.toCamelCase();
  final returnType = parsePythonReturnType(problem.signature!.returnType);

  switch (lang) {
    case Language.python:
      return """
class Solution:
    def $functionName(self, ${generateParameterString(problem.signature!)}) -> $returnType:

""";
    case Language.js:
      return """
/**
 * @param {string} version1
 * @param {string} version2
 * @return {$returnType}
 */
var $functionName = function(version1, version2) {

};
""";
    case Language.ts:
      return """
function $functionName(version1: string, version2: string): $returnType {
    
};
""";
    case Language.dart:
      return """
class Solution {
  $returnType $functionName(String version1, String version2) {
    
  }
}
""";
    case Language.cpp:
      return """
class Solution {
public:
    $returnType $functionName(string version1, string version2) {
        
    }
};
""";
    case Language.java:
      return """
class Solution {
    public $returnType $functionName(String version1, String version2) {
        
    }
}
""";
    case Language.sql:
      return "";
    default:
      return "";
  }
}

Mode selectLanguage(Language lang) {
  switch (lang) {
    case Language.python:
      return python;
    case Language.js:
      return javascript;
    case Language.ts:
      return typescript;
    case Language.dart:
      return dart;
    case Language.cpp:
      return cpp;
    case Language.java:
      return java;
    case Language.sql:
      return sql;
    default:
      return sql;
  }
}

class TabModifier extends CodeModifier {
  const TabModifier() : super('\t');

  @override
  TextEditingValue? updateString(
      String text, TextSelection sel, EditorParams params) {
    final tmp = replace(text, sel.start, sel.end, " " * params.tabSpaces);
    return tmp;
  }
}
