import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlighter/themes/atelier-cave-dark.dart';
import 'package:highlight/languages/python.dart';

const pythonCode = """
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        store = {}

        for i, n in enumerate(nums):
            remainder = target - n
            if store.get(remainder) != None:
                return [store.get(remainder), i]
            else:
                store[n] = i
""";

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final GlobalKey _codeEditorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // return const GetItRepositoryScreen();
    // return const BlocScreen();
    // return const CubitScreen();

    final controller = CodeController(
      text: pythonCode,
      language: python,
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        return SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Test Screen'),
                CodeTheme(
                  data: CodeThemeData(
                    styles: Style.currentTheme(context) == Brightness.light
                        ? vsTheme
                        : atelierCaveDarkTheme,
                  ),
                  child: SizedBox(
                    height: 900,
                    width: double.infinity,
                    child: CodeField(
                      textStyle: const TextStyle(
                        height: 1.5,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                      key: _codeEditorKey,
                      controller: controller,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
