// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class CurveClipper extends CustomClipper<Path> {
  final double animationValue;

  CurveClipper(this.animationValue);

  // @override
  // Path getClip(Size size) {
  //   final path = Path();
  //   final curveHeight =
  //       size.height * 5; // Adjust this value for the desired curve height
  //   final curveTop = (1.0 - animationValue) *
  //       size.height; // Calculate the top position of the curve

  //   path.lineTo(0, size.height);
  //   path.quadraticBezierTo(size.width / 2, curveTop, size.width, size.height);
  //   path.lineTo(size.width, 0);
  //   path.close();
  //   return path;
  // }

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, size.height,
        size.width * animationValue * 2, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  // Starts as triangle then moves to bottom right and disappears.
  // @override
  // Path getClip(Size size) {
  //   final path = Path();
  //   path.lineTo(0, size.height);
  //   path.quadraticBezierTo(size.width / 2, size.height,
  //       size.width * animationValue * 2, size.height);
  //   path.lineTo(size.width, 0);
  //   path.close();
  //   return path;
  // }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class StaggerAnimation extends StatelessWidget {
  final Animation<Color?> color;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<double> opacity;
  final Animation<double> controller;
  final Animation<EdgeInsets> padding;
  final Animation<BorderRadius?> borderRadius;
  StaggerAnimation({super.key, required this.controller})
      :

        // Each animation defined here transforms its value during the subset
        // of the controller's duration defined by the animation's interval.
        // For example the opacity animation transforms its value during
        // the first 10% of the controller's duration.

        opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.0,
              0.100,
              curve: Curves.ease,
            ),
          ),
        ),
        width = Tween<double>(
          begin: 50.0,
          end: 150.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.125,
              0.250,
              curve: Curves.ease,
            ),
          ),
        ),
        height = Tween<double>(begin: 50.0, end: 150.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.250,
              0.375,
              curve: Curves.ease,
            ),
          ),
        ),
        padding = EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 16),
          end: const EdgeInsets.only(bottom: 75),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.250,
              0.375,
              curve: Curves.ease,
            ),
          ),
        ),
        borderRadius = BorderRadiusTween(
          begin: BorderRadius.circular(4),
          end: BorderRadius.circular(75),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.375,
              0.500,
              curve: Curves.ease,
            ),
          ),
        ),
        color = ColorTween(
          begin: Colors.indigo[100],
          end: Colors.orange[400],
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.500,
              0.750,
              curve: Curves.ease,
            ),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      padding: padding.value,
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: opacity.value,
        child: Container(
          width: width.value,
          height: height.value,
          decoration: BoxDecoration(
            color: color.value,
            border: Border.all(
              color: Colors.indigo[300]!,
              width: 3,
            ),
            borderRadius: borderRadius.value,
          ),
        ),
      ),
    );
  }
}

class StaggerDemo extends StatefulWidget {
  const StaggerDemo({super.key});

  @override
  State<StaggerDemo> createState() => _StaggerDemoState();
}

class SwipeUpAnimation extends StatefulWidget {
  const SwipeUpAnimation({super.key});

  @override
  _SwipeUpAnimationState createState() => _SwipeUpAnimationState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  final enterAnimationMinHeight = 100.0;

  late ScrollController _scrollController;
  final listViewKey = GlobalKey();
  final animatedBoxKey = GlobalKey();
  final animatedBoxKey2 = GlobalKey();

  final scrollController = ScrollController();

  late AnimationController animatedBoxEnterAnimationController;
  late AnimationController animatedBoxEnterAnimationController2;

  @override
  Widget build(BuildContext context) {
    final boxOpacity = CurveTween(curve: Curves.easeOut)
        .animate(animatedBoxEnterAnimationController);
    final boxOpacity2 = CurveTween(curve: Curves.easeOut)
        .animate(animatedBoxEnterAnimationController2);

    final boxPosition = Tween(begin: const Offset(-1.0, 0.0), end: Offset.zero)
        .animate(animatedBoxEnterAnimationController);
    final boxPosition2 = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
        .animate(animatedBoxEnterAnimationController2);

    // return const SwipeUpAnimation();
    // return const StaggerDemo();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: getHeight(),
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Seeking the skills to build the future?',
                    style: Style.displayL)
              ],
            ),
          ),
          Container(
            height: getHeight(),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Helping you master yourself', style: Style.displayM),
                const Gap(50),
                Text('Helping you master yourself', style: Style.displayM),
              ],
            ),
          ),
          Container(
            height: getHeight(),
            color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(50),
                Text('Who should join us?', style: Style.bodyL),
                const Gap(50),
                Text(
                    'We want to make sure you know what you wanna do with your life',
                    style: Style.displayM),
                const Gap(100),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gap(50),
                    Column(
                      children: [Text('Students')],
                    ),
                    Gap(50),
                    Column(
                      children: [Text('Professionals')],
                    ),
                    Gap(50),
                    Column(
                      children: [Text('Knowledge geeks')],
                    ),
                    Gap(50),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: getHeight(),
            color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(50),
                  Text('Our approach', style: Style.bodyL),
                  const Gap(50),
                  Text('The Seep Deep Meaning', style: Style.displayM),
                  const Gap(100),
                  Row(
                    children: [
                      Column(
                        children: [
                          buildBox('Spaced Repetition'),
                          const Gap(50),
                          buildBox('Problem Library'),
                        ],
                      ),
                      Column(
                        children: [
                          buildBox('Guided Learning'),
                          const Gap(50),
                          buildBox('Industry Insiders'),
                        ],
                      ),
                      Column(
                        children: [
                          buildBox('Curated Content'),
                          const Gap(50),
                          buildBox('AI Enabled'),
                        ],
                      ),
                      const Gap(50),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: getHeight(),
            color: Colors.orange,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(50),
                Text('Who has already joined us?', style: Style.bodyL),
                const Gap(50),
                Text('These people have already pulled the trigger',
                    style: Style.displayM),
                const Gap(100),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gap(50),
                    Column(
                      children: [Text('Students')],
                    ),
                    Gap(50),
                    Column(
                      children: [Text('Professionals')],
                    ),
                    Gap(50),
                    Column(
                      children: [Text('Knowledge geeks')],
                    ),
                    Gap(50),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.red,
            child: const Text('sso'),
          )
        ],
      ),
    );

    return Scaffold(
      body: ListView(
        key: listViewKey,
        controller: scrollController,
        children: <Widget>[
          SizedBox(
            height: getHeight() / 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Container(
            color: Colors.amber,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FadeTransition(
                    opacity: boxOpacity,
                    child: SlideTransition(
                      position: boxPosition,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            key: animatedBoxKey,
                            height: 300.0,
                            color: Colors.green,
                            padding: const EdgeInsets.all(16.0),
                            child: const Text('Animated Box'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  color: Colors.red,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('sososos'),
                    ],
                  ),
                ))
              ],
            ),
          ),
          const Gap(500),
          Container(
            color: Colors.amber,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                  color: Colors.red,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('sososos'),
                    ],
                  ),
                )),
                Expanded(
                  child: FadeTransition(
                    opacity: boxOpacity2,
                    child: SlideTransition(
                      position: boxPosition2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            key: animatedBoxKey2,
                            height: 300.0,
                            color: Colors.green,
                            padding: const EdgeInsets.all(16.0),
                            child: const Text('Animated Box'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1000,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              scrollController.jumpTo(0.0);
              animatedBoxEnterAnimationController.reset();
            },
            child: const Text('Reset'),
          )
        ],
      ),
    );
  }

  buildBox(title) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 400,
        maxWidth: 400,
        minHeight: 250,
        maxHeight: 250,
      ),
      child: Text(title, style: Style.bodyL),
    );
  }

  buildSideAnimations() {
    return Column(
      children: [
        SizedBox(
          height: getHeight(),
          width: 1000,
          child: ListView(
            key: listViewKey,
            controller: _scrollController,
            children: [
              SizedBox(
                height: getHeight() / 2,
                child: Container(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('The real deal',
                              style: Style.displayL.copyWith(
                                fontWeight: FontWeight.bold,
                              ))
                          .animate()
                          .fadeIn(duration: 3000.ms)
                          .slide(
                              begin: const Offset(-1, 0),
                              end: const Offset(0, 0)),
                      const Text('hi yo')
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getHeight() / 2,
                child: Container(
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('hi yo'),
                      Text('The real deal',
                              style: Style.displayL.copyWith(
                                fontWeight: FontWeight.bold,
                              ))
                          .animate()
                          .fadeIn(duration: 3000.ms)
                          .slide(
                              begin: const Offset(1, 0),
                              end: const Offset(0, 0)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getHeight() / 2,
                child: Container(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('The real deal',
                              style: Style.displayL.copyWith(
                                fontWeight: FontWeight.bold,
                              ))
                          .animate()
                          .fadeIn(duration: 3000.ms)
                          .slide(
                              begin: const Offset(-1, 0),
                              end: const Offset(0, 0)),
                      const Text('hi yo')
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getHeight() / 2,
                child: Container(
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('hi yo'),
                      Text('The real deal',
                              style: Style.displayL.copyWith(
                                fontWeight: FontWeight.bold,
                              ))
                          .animate()
                          .fadeIn(duration: 3000.ms)
                          .slide(
                              begin: const Offset(1, 0),
                              end: const Offset(0, 0)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final boxOpacity = CurveTween(curve: Curves.easeOut)
  //       .animate(animatedBoxEnterAnimationController);

  //   final boxPosition = Tween(begin: const Offset(-1.0, 0.0), end: Offset.zero)
  //       .chain(CurveTween(curve: Curves.elasticOut))
  //       .animate(animatedBoxEnterAnimationController);
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         // Column(
  //         //   children: [
  //         //     const Text("Hello"),
  //         //     const Text("World"),
  //         //     const Text("Goodbye")
  //         //   ].animate(interval: 400.ms).fade(duration: 300.ms),
  //         // ),
  //         Text(
  //           'The real deal',
  //           style: Style.displayL.copyWith(
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         buildSideAnimations(),
  //       ],
  //     ),
  //   );
  // }

  @override
  void dispose() {
    animatedBoxEnterAnimationController.dispose();
    animatedBoxEnterAnimationController2.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    animatedBoxEnterAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    animatedBoxEnterAnimationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    scrollController.addListener(() {
      _updateAnimatedBoxEnterAnimation();
    });
  }

  _updateAnimatedBoxEnterAnimation() {
    if (animatedBoxEnterAnimationController.status !=
            AnimationStatus.dismissed &&
        animatedBoxEnterAnimationController2.status !=
            AnimationStatus.dismissed) {
      return; // animation already in progress/finished
    }

    RenderObject? listViewObject =
        listViewKey.currentContext!.findRenderObject();
    RenderObject? animatedBoxObject1 =
        animatedBoxKey.currentContext!.findRenderObject();
    RenderObject? animatedBoxObject2 =
        animatedBoxKey2.currentContext!.findRenderObject();

    final listViewHeight = listViewObject?.paintBounds.height;
    final animatedObjectTop1 =
        animatedBoxObject1?.getTransformTo(listViewObject).getTranslation().y;
    final animatedObjectTop2 =
        animatedBoxObject2?.getTransformTo(listViewObject).getTranslation().y;

    final animatedBoxVisible1 =
        (animatedObjectTop1! + enterAnimationMinHeight < listViewHeight!);
    final animatedBoxVisible2 =
        (animatedObjectTop2! + enterAnimationMinHeight < listViewHeight);

    if (animatedBoxVisible1) {
      animatedBoxEnterAnimationController.forward();
    }
    if (animatedBoxVisible2) {
      animatedBoxEnterAnimationController2.forward();
    }
  }
}

class _StaggerDemoState extends State<StaggerDemo>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    timeDilation = 10.0; // 1.0 is normal animation speed.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staggered Animation'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            child: StaggerAnimation(controller: _controller.view),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // The animation got canceled, probably because we were disposed.
    }
  }
}

class _SwipeUpAnimationState extends State<SwipeUpAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            children: [
              Container(
                color: Colors.blue,
              ),
              const Positioned(bottom: 0, right: 0, child: Text('sosos')),
              ClipPath(
                clipper: CurveClipper(_animation.value),
                child: Container(
                    color: Colors.green, // Color behind the curve
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: const Expanded(
                      flex: 1,
                      child:
                          Positioned(bottom: 0, right: 0, child: Text('sosos')),
                    )),
              ),
              const Positioned(bottom: 0, right: 0, child: Text('sosos')),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }
}
