import 'package:app/all.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import './giffy_modal.dart';

Future<void> dialogBig(BuildContext context, String title, String body,
    [Widget? content]) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      bool isChecked = false;
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            content: content ?? Text(body),
            actions: <Widget>[
              Column(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const Text('Don\'t show again'),
                ],
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: Button(
                  title: 'Ok',
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                  outlined: true,
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> dialogBuilder(BuildContext context, title, body) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          body,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class Modal extends StatefulWidget {
  final GiffyType type;
  final String? title;
  final Widget? content;

  const Modal({super.key, required this.type, this.title, this.content});

  @override
  State<Modal> createState() => _ModalState();
}

class TestPage extends StatelessWidget {
  final _controller = PageController();
  TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: const [
                Center(
                  child: Text(
                      'You\'re about make it to another world with your SQL skills.'),
                ),
                Center(
                  child: Text(
                      'On this page you\'re going to write progressively more challenging SQL queries which\'ll develop your mastery.'),
                ),
                Center(
                  child: Text(
                    'The tables will reflect & their relationships will reflect resources you\'ll undoubtedly see in your career.',
                  ),
                ),
                Center(
                  child: Text(
                      'So don\'t rush through the exercises, try to deeply understand them; because once you do, they\'ll start to feel like art.'),
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            count: 5,
            controller: _controller,
            axisDirection: Axis.horizontal,
            effect: const SlideEffect(
              activeDotColor: Colors.white54,
              dotHeight: 10,
              dotColor: Colors.blue,
              dotWidth: 10,
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _ModalState extends State<Modal> {
  late GiffyModel rive;
  late GiffyModel image;
  bool isChecked = false;
  late GiffyModel lottie;
  late bool useMaterial3;
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 36);
  }

  Widget buildBottomSheet() {
    return widget.type.when(
      image: () {
        return GiffyBottomSheet.image(
          image.giffy as Image,
          title: image.title,
          content: image.content,
          actions: image.actions,
        );
      },
      rive: () {
        return GiffyBottomSheet.rive(
          rive.giffy as RiveAnimation,
          giffyBuilder: (context, rive) {
            return ClipRRect(
              borderRadius: useMaterial3
                  ? const BorderRadius.all(Radius.circular(16))
                  : const BorderRadius.all(Radius.circular(4)),
              child: SizedBox(height: 200, child: rive),
            );
          },
          title: rive.title,
          content: rive.content,
          actions: rive.actions,
        );
      },
      lottie: () {
        return GiffyBottomSheet.lottie(
          lottie.giffy as LottieBuilder,
          title: lottie.title,
          content: lottie.content,
          actions: lottie.actions,
        );
      },
    );
  }

  Widget buildDialog() {
    return widget.type.when(
      image: () {
        return GiffyDialog.image(
          image.giffy as Image,
          title: image.title,
          content: image.content,
          actions: image.actions,
        );
      },
      rive: () {
        return GiffyDialog.rive(
          rive.giffy as RiveAnimation,
          giffyBuilder: (context, rive) {
            return ClipRRect(
              borderRadius: useMaterial3
                  ? const BorderRadius.all(Radius.circular(16))
                  : const BorderRadius.all(Radius.circular(4)),
              child: SizedBox(height: 200, child: rive),
            );
          },
          title: rive.title,
          content: rive.content,
          actions: rive.actions,
        );
      },
      lottie: () {
        return GiffyDialog.lottie(
          lottie.giffy as LottieBuilder,
          title: lottie.title,
          content: lottie.content,
          actions: lottie.actions,
        );
      },
    );
  }

  buildGuides() {
    return SizedBox(
      width: getWidth() / 1.25,
      height: getHeight() / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              children: [
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/img/carousels/SQL-01.svg',
                        width: 800,
                        height: 400,
                      ),
                      const Gap(20),
                      Text(
                          'You\'re about make it to another world with your SQL skills.',
                          style: Style.headlineL,
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/img/carousels/SQL-02.svg',
                        width: 800,
                        height: 400,
                      ),
                      const Gap(20),
                      Text(
                          'On this page you\'re going to write progressively more challenging SQL queries which\'ll develop your mastery.',
                          style: Style.headlineL,
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/img/carousels/SQL-03.svg',
                        width: 800,
                        height: 400,
                      ),
                      const Gap(20),
                      Text(
                          'The tables will reflect & their relationships will reflect resources you\'ll undoubtedly see in your career.',
                          style: Style.headlineL,
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/img/carousels/SQL-04.svg',
                        width: 800,
                        height: 400,
                      ),
                      const Gap(20),
                      Text(
                          'So don\'t rush through the exercises, try to deeply understand them; because once you do, they\'ll start to feel like art.',
                          style: Style.headlineL,
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          SmoothPageIndicator(
            controller: controller,
            count: 4,
            axisDirection: Axis.horizontal,
            effect: const SlideEffect(
              activeDotColor: Colors.white54,
              dotHeight: 10,
              dotColor: Colors.blue,
              dotWidth: 10,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setup();
      if (kDebugMode) {
        if (widget.content != null) {
          dialogBig(context, 'SQL Screen', 'soso', buildGuides());
        } else {
          onLoad();
        }
      }
    });
  }

  onLoad() {
    showDialog(
      context: context,
      builder: (_) {
        return buildDialog();
      },
    );
  }

  setup() {
    image = GiffyModel.image(context);
    rive = GiffyModel.rive(context);
    lottie = GiffyModel.lottie(context);
    useMaterial3 = Theme.of(context).useMaterial3;
    setState(() {
      image = image;
      rive = rive;
      lottie = lottie;
      useMaterial3 = useMaterial3;
    });
  }
}
