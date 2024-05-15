import 'package:app/all.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import './giffy_modal.dart';

Future<void> dialogBig(BuildContext c, String title, String body,
    [Widget? content]) async {
  final isHide = await Storage.instance.getSqlIntroHide();
  if (isHide) return;
  return showDialog<void>(
    context: c,
    builder: (BuildContext context) {
      bool isChecked = false;
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            content: content ?? Text(body),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: Button(
                          title: 'Start Learning',
                          onPress: () {
                            if (isChecked) {
                              Storage.instance.setSqlIntroHide();
                            }
                            Navigator.of(context).pop();
                          },
                          outlined: true,
                        ),
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> dialogBugReport(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Bug Report',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        content: SizedBox(
          height: getHeight() / 5,
          width: getWidth() / 2,
          child: Center(
            child: Expanded(
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.headlineLarge,
                      hintText: 'Problem changing...',
                      labelText: 'Title',
                    ),
                  ),
                  const Gap(30),
                  TextFormField(
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.headlineLarge,
                      hintText: 'On the...',
                      labelText: 'Description',
                    ),
                  ),
                  const Gap(30),
                  TextFormField(
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.headlineLarge,
                      helperText:
                          'We can update you if you provide your contact.',
                      hintText: 'john@email.com',
                      labelText: 'Email',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FilledButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Report'),
            onPressed: () {
              Navigator.of(context).pop();
              Glob.showSnack('Thank you for your report!');
            },
          ),
        ],
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

Future<void> dialogFeatureRequest(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Feature Request',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        content: SizedBox(
          height: getHeight() / 5,
          width: getWidth() / 2,
          child: Center(
            child: Expanded(
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.headlineLarge,
                      // helperText: 'Which screen are you referring to?',
                      hintText: 'Data Structures...',
                      labelText: 'Title',
                    ),
                  ),
                  const Gap(30),
                  TextFormField(
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.headlineLarge,
                      // helperText: 'Helper Text',
                      hintText: 'It would great if...',
                      labelText: 'Description',
                    ),
                  ),
                  const Gap(30),
                  TextFormField(
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.headlineLarge,
                      helperText:
                          'We can update you if you provide your contact.',
                      hintText: 'john@email.com',
                      labelText: 'Email',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FilledButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Request'),
            onPressed: () {
              Glob.showSnack('Thank you for your request!');
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
      width: getWidth() / 1.5,
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
                      const Gap(30),
                      SvgPicture.asset(
                        'assets/img/carousels/SQL-01.svg',
                        width: 800,
                        height: 400,
                      ),
                      const Gap(60),
                      Text(
                        'Your SQL skills are about to be out of this world better. ',
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
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
                        'On this page you\'re going to write progressively \nmore challenging SQL queries \nwhich\'ll develop your mastery.',
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
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
                        'The tables will reflect & their \nrelationships will reflect resources you\'ll \nundoubtedly see in your career.',
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
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
                        'So don\'t rush through the exercises, try \nto deeply understand them; because \nonce you do, they\'ll start to feel like art.',
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
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
      if (!kDebugMode) {
        if (widget.content != null) {
          dialogBig(context, 'SQL Screen', '', buildGuides());
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
