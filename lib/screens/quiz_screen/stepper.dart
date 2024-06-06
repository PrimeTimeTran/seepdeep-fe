// ignore_for_file: avoid_web_libraries_in_flutter, must_be_immutable
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StepperDemo extends StatefulWidget {
  int problemsLength;
  int activeStep;
  Function setStep;
  StepperDemo({
    super.key,
    required this.activeStep,
    required this.setStep,
    required this.problemsLength,
  });

  @override
  State<StepperDemo> createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: widget.activeStep,
      lineStyle: const LineStyle(
        lineSpace: 1,
        lineWidth: 10,
        lineLength: 50,
        lineThickness: 3,
        lineType: LineType.normal,
        unreachedLineType: LineType.dashed,
      ),
      borderThickness: 2,
      // internalPadding: 10,
      stepBorderRadius: 15,
      stepShape: StepShape.circle,
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      stepRadius: 14,
      showLoadingAnimation: false,
      activeStepIconColor: Colors.greenAccent,
      finishedStepTextColor: Colors.greenAccent,
      finishedStepBorderColor: Colors.greenAccent,
      finishedStepBackgroundColor: Colors.greenAccent,
      steps: buildSteps(),
      onStepReached: (index) {
        widget.setStep(index - 1);
        // setState(() => widget.activeStep = index + 1);
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
    for (var i = 1; i <= widget.problemsLength; i++) {
      vals.add(EasyStep(
        customStep: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Opacity(
            opacity: widget.activeStep >= 0 ? 1 : 0.3,
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
}
