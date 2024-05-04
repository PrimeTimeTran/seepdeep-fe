// ignore_for_file: avoid_web_libraries_in_flutter, must_be_immutable
import 'dart:async';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StepperDemo extends StatefulWidget {
  Stream<int> problemStream;
  Function setStep;
  StepperDemo({super.key, required this.problemStream, required this.setStep});

  @override
  State<StepperDemo> createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int activeStep = 1;
  late StreamSubscription<int> _streamSubscription;
  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: activeStep,
      lineStyle: const LineStyle(
        lineSpace: 1,
        lineWidth: 10,
        lineLength: 50,
        lineThickness: 3,
        lineType: LineType.normal,
        unreachedLineType: LineType.dashed,
      ),
      borderThickness: 2,
      internalPadding: 10,
      stepBorderRadius: 15,
      stepShape: StepShape.rRectangle,
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      stepRadius: 28,
      showLoadingAnimation: false,
      activeStepIconColor: Colors.greenAccent,
      finishedStepTextColor: Colors.greenAccent,
      finishedStepBorderColor: Colors.greenAccent,
      finishedStepBackgroundColor: Colors.greenAccent,
      steps: buildSteps(),
      onStepReached: (index) {
        print(index);
        widget.setStep(index + 1);
        setState(() => activeStep = index + 1);
      },
    );
  }

  buildSteps() {
    final images = [
      'ic_bar_chart',
      'ic_line_chart',
      'ic_pie_chart',
      'ic_radar_chart',
      'ic_scatter_chart',
    ];
    List<EasyStep> vals = [];
    for (var i = 1; i <= 10; i++) {
      vals.add(EasyStep(
        customStep: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Opacity(
            opacity: activeStep >= 0 ? 1 : 0.3,
            child: SvgPicture.asset(
              'assets/icons/${images[i % images.length]}.svg',
              width: 48,
              height: 48,
            ),
          ),
        ),
        customTitle: Text(
          'Problem $i',
          textAlign: TextAlign.center,
        ),
      ));
    }
    return vals.toList();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _streamSubscription = widget.problemStream.listen((index) {
      setState(() {
        activeStep = index;
      });
    });
  }
}
