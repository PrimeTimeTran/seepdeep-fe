// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:markdown/markdown.dart' as md;

const _text = r"""
This is inline latex: $f(x) = \sum_{i=0}^{n} \frac{a_i}{1+x}$

This is block level latex:

$$
c = \pm\sqrt{a^2 + b^2}
$$

This is inline latex with displayMode: $$f(x) = \sum_{i=0}^{n} \frac{a_i}{1+x}$$

The relationship between the height and the side length of an equilateral triangle is:

\[ \text{Height} = \frac{\sqrt{3}}{2} \times \text{Side Length} \]

\[ \text{X} = \frac{1}{2} \times \text{Y} \times \text{Z} = \frac{1}{2} \times 9 \times \frac{\sqrt{3}}{2} \times 9 = \frac{81\sqrt{3}}{4} \]

The basic form of the Taylor series is:

\[f(x) = f(a) + f'(a)(x-a) + \frac{f''(a)}{2!}(x-a)^2 + \frac{f'''(a)}{3!}(x-a)^3 + \cdots\]

where \(f(x)\) is the function to be expanded, \(a\) is the expansion point, \(f'(a)\), \(f''(a)\), \(f'''(a)\), etc., are the first, second, third, and so on derivatives of the function at point \(a\), and \(n!\) denotes the factorial of \(n\).

In particular, when \(a=0\), this expansion is called the Maclaurin series.

""";

final questions = [
  {
    "title": "Problem 1.",
    "body":
        "An apartment complex has 250 apartments to rent. If they rent x apartments then their monthly profit, in dollars, is given by,",
    "equation": "P(x) = −8x^{2} + 3200x − 80,000",
    "prompt":
        "How many apartments should they rent in order to maximize their profit?",
    "solution": """
All that we’re really being asked to do here is to maximize the profit subject to the constraint that x must be in the range 0 ≤ x ≤ 250.

First, we’ll need the derivative and the critical point(s) that fall in the range 0 ≤ x ≤ 250.

P′(x)=−16x+3200⇒3200−16x=0,⇒x=320016=200

Since the profit function is continuous and we have an interval with finite bounds we can find the maximum value by simply plugging in the only critical point that we have (which nicely enough in the range of acceptable answers) and the end points of the range.

P(0)=−80,000P(200)=240,000P(250)=220,000

So, it looks like they will generate the most profit if they only rent out 200 of the apartments instead of all 250 of them.
"""
  }
];

class MathScreen extends StatefulWidget {
  const MathScreen({super.key});

  @override
  State<MathScreen> createState() => _MathScreenState();
}

class _MathScreenState extends State<MathScreen> {
  IFrameElement webView = IFrameElement();
  @override
  Widget build(BuildContext context) {
    setSubscription();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(questions[0]["title"]!, style: Style.displayM),
                  Text(questions[0]["body"]!, style: Style.bodyL),
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Markdown(
                      selectable: true,
                      data: questions[0]["equation"]!,
                      builders: {
                        'latex': LatexElementBuilder(
                          textStyle: const TextStyle(
                            // color: Colors.blue,
                            fontWeight: FontWeight.w100,
                          ),
                          textScaleFactor: 1.2,
                        ),
                      },
                      extensionSet: md.ExtensionSet(
                        [LatexBlockSyntax()],
                        [LatexInlineSyntax()],
                      ),
                    ),
                  ),
                  Text(questions[0]["prompt"]!, style: Style.bodyL),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 750,
                  width: 1025,
                  child: HtmlElementView(
                    viewType: 'index',
                    onPlatformViewCreated: (int id) {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  setSubscription() {
    ui.platformViewRegistry.registerViewFactory('index', (int viewId) {
      webView = IFrameElement()
        ..src = 'assets/index.html'
        ..style.border = 'none';
      window.onMessage.listen((msg) {
        if (msg.data?.startsWith("onMsg Success:")) {
        } else {}
      }, onError: (e) {
        Glob.logI(e);
      }, onDone: () {
        Glob.logI('Done');
      });
      return webView;
    }, isVisible: false);
  }
}
