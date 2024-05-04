// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:app/all.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:markdown/markdown.dart' as md;

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

class StepperDemo extends StatefulWidget {
  const StepperDemo({super.key});

  @override
  State<StepperDemo> createState() => _StepperDemoState();
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
                  const Gap(5),
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
                  const TextField(
                    decoration: InputDecoration(
                      hintText: '5',
                    ),
                  )
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
        const StepperDemo()
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

class _StepperDemoState extends State<StepperDemo> {
  int activeStep = 0;
  int activeStep2 = 0;
  int reachedStep = 0;
  int upperBound = 5;
  double progress = 0.2;
  Set<int> reachedSteps = <int>{0, 2, 4, 5};
  final dashImages = [
    'assets/librarian-svgrepo-com.svg',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: activeStep,
      lineStyle: const LineStyle(
        lineLength: 50,
        lineType: LineType.normal,
        lineThickness: 3,
        lineSpace: 1,
        lineWidth: 10,
        unreachedLineType: LineType.dashed,
      ),
      stepShape: StepShape.rRectangle,
      stepBorderRadius: 15,
      borderThickness: 2,
      internalPadding: 10,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      stepRadius: 28,
      finishedStepBorderColor: Colors.deepOrange,
      finishedStepTextColor: Colors.deepOrange,
      finishedStepBackgroundColor: Colors.deepOrange,
      activeStepIconColor: Colors.deepOrange,
      showLoadingAnimation: false,
      steps: [
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 0 ? 1 : 0.3,
              child: SvgPicture.asset(
                'assets/icons/ic_scatter_chart.svg',
                width: 48,
                height: 48,
              ),
            ),
          ),
          customTitle: const Text(
            'Problem 1',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 1 ? 1 : 0.3,
              child: SvgPicture.asset(
                'assets/icons/ic_bar_chart.svg',
                width: 48,
                height: 48,
              ),
            ),
          ),
          customTitle: const Text(
            'Problem 2',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 2 ? 1 : 0.3,
              child: SvgPicture.asset(
                'assets/icons/ic_line_chart.svg',
                width: 48,
                height: 48,
              ),
            ),
          ),
          customTitle: const Text(
            'Problem 3',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 3 ? 1 : 0.3,
              child: SvgPicture.asset(
                'assets/icons/ic_pie_chart.svg',
                width: 48,
                height: 48,
              ),
            ),
          ),
          customTitle: const Text(
            'Problem 4',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 4 ? 1 : 0.3,
              child: SvgPicture.asset(
                'assets/icons/ic_radar_chart.svg',
                width: 48,
                height: 48,
              ),
            ),
          ),
          customTitle: const Text(
            'Problem 5',
            textAlign: TextAlign.center,
          ),
        ),
      ],
      onStepReached: (index) => setState(() => activeStep = index),
    );
  }

  void increaseProgress() {
    if (progress < 1) {
      setState(() => progress += 0.2);
    } else {
      setState(() => progress = 0);
    }
  }
}
