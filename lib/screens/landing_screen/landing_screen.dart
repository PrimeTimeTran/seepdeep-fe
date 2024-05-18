// ignore_for_file: depend_on_referenced_packages

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import './landing.helpers.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _sectionAKey = GlobalKey();
  final GlobalKey _sectionBKey = GlobalKey();
  final GlobalKey _sectionCKey = GlobalKey();
  final GlobalKey _sectionDKey = GlobalKey();
  final GlobalKey _sectionEKey = GlobalKey();
  final GlobalKey _sectionFKey = GlobalKey();
  final GlobalKey _sectionGKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AppHead(
      title: "Seep Deep - Your one stop shop for skills acquisition",
      description:
          "Mastery skills crucial to success in the information age. Develop real mastery with spaced repetition, games, curated content & and more.",
      child: Scaffold(
        appBar: buildNavbar(),
        body: buildDesktop(),
      ),
    );
  }

  buildBox(point) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 400,
        maxWidth: 400,
        minHeight: 250,
        maxHeight: 250,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              point['icon'],
              const Gap(20),
              Text(
                point['title'],
                style: Style.headlineL,
              )
            ],
          ),
          const Gap(20),
          Text(point['description'], style: Style.headlineS),
        ],
      ),
    );
  }

  SingleChildScrollView buildDesktop() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        key: _sectionAKey,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildJumbotron(),
          buildMission(),
          buildFilter(),
          buildSocialProof(),
          buildSellingPoints(),
          buildTechnologies(),
          buildReferrals(),
          buildPartners(),
          buildFAQs(),
          buildFooter(),
        ],
      ),
    );
  }

  Container buildFAQs() {
    return Container(
      key: _sectionEKey,
      height: getHeight(),
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 200),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(SDIcon.trusted),
                          const Gap(5),
                          Text('FAQ\'S',
                              style: Style.headlineS.copyWith(
                                color: Colors.lightBlue[700],
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      const Gap(25),
                      Text('Frequently \nAsked Questions',
                          style: Style.displayM),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: getHeight() / 2,
                    width: getWidth(),
                    child: Column(
                      children: [
                        buildFAQTile('Is Seep Deep free?', null,
                            'While were still in beta we\'re completely free to use.'),
                        buildFAQTile('Will my profile be public?', null,
                            'Your profile is private until you choose to make it publicly available'),
                        buildFAQTile(
                            'Im not a programmer, is it ok for me?',
                            null,
                            'We have a lot more than coding problems! Our material covers maths & data science as well(with more on the way)'),
                        buildFAQTile(
                            'Can I use Seep Deep to train my students?',
                            null,
                            'Of course. Although at the time of writing we\'re not yet focusing on beginner topics(variables, conditionals, functions, algebra, trigonometry, etc)'),
                        buildFAQTile(
                            'Can I use Seep Deep for my company?',
                            null,
                            'Please email us at info@seepdeep.com if there\'s something more you\'d like to see implemented.'),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  buildFAQTile(question, [followup, answer]) {
    return ExpansionTile(
      title: Text(question, style: Style.headlineS),
      subtitle:
          followup == null ? null : Text(followup, style: Style.headlineS),
      children: <Widget>[
        ListTile(title: Text(answer ?? '')),
      ],
    );
  }

  Stack buildFilter() {
    return Stack(
      children: [
        SizedBox(
          width: getWidth(),
          height: getHeight(),
          child: SvgPicture.asset(
            'assets/img/bgs/bg-2.svg',
            fit: BoxFit.fill,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 200),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person),
                      const Gap(5),
                      Text(
                        'Who are you',
                        style: Style.headlineS.copyWith(
                          color: Colors.lightBlue[700],
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const Gap(50),
                  Text(
                    'Does this sound like you? \nCan you relate to these?',
                    style: Style.displayM,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(100),
                      buildPhotoBox('Learners', 250),
                      const Gap(300),
                      buildPhotoBox('Teachers', 250),
                      const Gap(300),
                      buildPhotoBox('Businesses', 250),
                      const Gap(100),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container buildFooter() {
    return Container(
      height: 700,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 200, right: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product',
                      style: TextStyle(
                        fontSize: 30,
                        color: themeColor(
                          context,
                          'primary',
                        ),
                      ),
                    ),
                    const Gap(20),
                    Text(
                      'For Learners',
                      style: TextStyle(
                        fontSize: 25,
                        color: themeColor(
                          context,
                          'primary',
                        ),
                      ),
                    ),
                    const Gap(10),
                    TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse('https://seepdeep.com/math'));
                      },
                      child: const Text(
                        'Maths',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse('https://seepdeep.com/problems'));
                      },
                      child: const Text(
                        'Data Structures & Algorithms',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse('https://seepdeep.com/sql'));
                      },
                      child: const Text(
                        'Databases',
                      ),
                    ),
                    const Gap(20),
                    Text(
                      'For Teachers',
                      style: TextStyle(
                        fontSize: 25,
                        color: themeColor(
                          context,
                          'primary',
                        ),
                      ),
                    ),
                    const Gap(10),
                    const Text('Home Work'),
                    const Text('Cheat Sheet'),
                    const Gap(20),
                    Text(
                      'For Employers',
                      style: TextStyle(
                        fontSize: 25,
                        color: themeColor(
                          context,
                          'primary',
                        ),
                      ),
                    ),
                    const Text('Applicant Screener'),
                    const Text('Team Developer'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Company',
                      style: TextStyle(
                        fontSize: 30,
                        color: themeColor(
                          context,
                          'primary',
                        ),
                      ),
                    ),
                    const Gap(20),
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 25,
                        color: themeColor(
                          context,
                          'primary',
                        ),
                      ),
                    ),
                    const Text('Careers'),
                    const Gap(20),
                    Text(
                      'Contact',
                      style: TextStyle(
                        fontSize: 25,
                        color: themeColor(
                          context,
                          'primary',
                        ),
                      ),
                    ),
                    const Gap(10),
                    const Text('contact@seepdeep.com'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Socials',
                      style: TextStyle(
                        fontSize: 30,
                        color: themeColor(
                          context,
                          'primary',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            launchUrl(Uri.parse('https://faceboook.com'));
                          },
                          icon: SvgPicture.asset(
                            'assets/img/logos/facebook.svg',
                            height: 35,
                            width: 35,
                          ),
                        ),
                        const Gap(25),
                        IconButton(
                          onPressed: () {
                            launchUrl(Uri.parse('https://linkedin.com'));
                          },
                          icon: SvgPicture.asset(
                            'assets/img/logos/linkedin.svg',
                            height: 35,
                            width: 35,
                          ),
                        ),
                        const Gap(25),
                        IconButton(
                          onPressed: () {
                            launchUrl(Uri.parse('https://youtube.com'));
                          },
                          icon: SvgPicture.asset(
                            'assets/img/logos/youtube.svg',
                            height: 35,
                            width: 35,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ],
            ),
            const Gap(250),
            Row(
              children: [
                const Spacer(),
                Text('Seep Deep © ${currentYear()} All rights reserved ',
                    style: TextStyle(color: themeColor(context, 'outline'))),
              ],
            )
          ],
        ),
      ),
    );
  }

  Stack buildJumbotron() {
    return Stack(
      children: [
        SizedBox(
          width: getWidth(),
          height: getHeight(),
          child: SvgPicture.asset(
            'assets/img/bgs/bg-1.svg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 100,
          right: 100,
          bottom: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.money),
                        const Gap(5),
                        Text(
                          'Fly Higher',
                          style: Style.headlineS.copyWith(
                            color: Colors.lightBlue[700],
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const Gap(50),
                    Text(
                      'Money back guarantee.\n\nA fresh take on learning.\n\nGain 21st century skills more \neasily with us',
                      style: TextStyle(
                        fontFamily: 'ObelixPro',
                        fontSize: 35,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(50),
                    SizedBox(
                      height: 75,
                      width: 300,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.start_outlined),
                        onPressed: () =>
                            GoRouter.of(context).go(AppScreens.sql.path),
                        label: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildMission() {
    return Container(
      key: _sectionBKey,
      height: getHeight(),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(SDIcon.ai_enabled),
                    const Gap(5),
                    Text(
                      'Our Mission',
                      style: Style.headlineS.copyWith(
                        color: Colors.lightBlue[700],
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const Gap(50),
                Text(
                  'Helping you master yourself',
                  style: Style.headlineL,
                ),
                const Gap(50),
                Text(
                    'Were about helping people become \nthe best version of themselves. \nWe\'re about enabling',
                    style: Style.headlineM),
              ],
            ),
            const Gap(50),
            Container(
              height: 600,
              width: 600,
              child: getImg('headshots/female-1.jpeg', 500, true, true),
              decoration: BoxDecoration(
                color: Colors.blue[300]!,
                border: Border.all(),
                borderRadius: const BorderRadius.all(
                  Radius.elliptical(20, 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildNavbar() {
    return AppBar(
      actions: [
        const Gap(150),
        IconButton(
          icon: SvgPicture.asset(
            'assets/img/favicon.svg',
            width: 48,
            height: 48,
          ),
          onPressed: () => scrollToSection(_sectionAKey),
        ),
        const Spacer(),
        TextButton.icon(
          icon: const Icon(Icons.directions_run_rounded),
          onPressed: () => scrollToSection(_sectionBKey),
          label: const Text('Our Mission'),
        ),
        const Gap(50),
        TextButton.icon(
          icon: const Icon(Icons.alt_route_outlined),
          onPressed: () => scrollToSection(_sectionCKey),
          label: const Text('Our Approach'),
        ),
        const Gap(50),
        TextButton.icon(
          icon: const Icon(Icons.category_outlined),
          onPressed: () => scrollToSection(_sectionGKey),
          label: const Text('Technologies'),
        ),
        const Gap(50),
        TextButton.icon(
          icon: const Icon(Icons.supervised_user_circle_outlined),
          onPressed: () => scrollToSection(_sectionDKey),
          label: const Text('Ideal Customers'),
        ),
        const Gap(50),
        TextButton.icon(
          icon: const Icon(Icons.business),
          onPressed: () => scrollToSection(_sectionFKey),
          label: const Text('Partners'),
        ),
        const Gap(50),
        TextButton.icon(
          icon: const Icon(Icons.help),
          onPressed: () => scrollToSection(_sectionEKey),
          label: const Text('FAQs'),
        ),
        const Gap(150),
      ],
    );
  }

  Container buildPartners() {
    return Container(
      key: _sectionFKey,
      color: Colors.white,
      height: getHeight() / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(SDIcon.trusted, size: 25),
              const Gap(35),
              Text('Trusted By',
                  style: Style.headlineS.copyWith(
                    color: Colors.lightBlue[700],
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          const Gap(50),
          Text('Companies Leveraging Our Technology', style: Style.headlineL),
          const Gap(100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(50),
              getImg('logos/scanlab-favicon.jpg', 200),
              const Gap(100),
              getImg('logos/data-annotation-favicon.svg'),
              const Gap(100),
              getImg('logos/adapt-health-favicon.png'),
              const Gap(50),
            ],
          )
        ],
      ),
    );
  }

  buildPhotoBox(title, size, [u, cover]) {
    return Column(
      children: [
        Text(u != null ? u['name'] : title, style: Style.headlineS),
        Container(
          height: size,
          width: size,
          child: u != null ? getImg(u['file'], 500, true, true) : null,
          decoration: BoxDecoration(
              // color: Colors.blue[300]!,
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.elliptical(20, 20))),
        ),
      ],
    );
  }

  Container buildReferrals() {
    return Container(
      key: _sectionDKey,
      height: getHeight(),
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.chrome_reader_mode_outlined, size: 35),
              const Gap(35),
              Text('Heres what they have to say',
                  style: Style.headlineS.copyWith(
                    color: Colors.lightBlue[700],
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          const Gap(50),
          Text(
            'Incredible',
            style: Style.displayM,
            textAlign: TextAlign.center,
          ),
          const Gap(50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Icon(SDIcon.student, size: 50),
                  const Gap(35),
                  Text('Learners', style: Style.headlineS)
                ],
              ),
              const Gap(150),
              Column(
                children: [
                  const Icon(SDIcon.professional, size: 50),
                  const Gap(35),
                  Text('Teachers', style: Style.headlineS)
                ],
              ),
              const Gap(150),
              Column(
                children: [
                  const Icon(SDIcon.company, size: 50),
                  const Gap(35),
                  Text('Businesses', style: Style.headlineS)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Container buildSellingPoints() {
    return Container(
      key: _sectionCKey,
      height: getHeight(),
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(50),
            Text('Our approach',
                style: Style.headlineS.copyWith(
                  color: Colors.lightBlue[700],
                  fontWeight: FontWeight.bold,
                )),
            const Gap(50),
            Row(
              children: [
                const Icon(SDIcon.curated_content, size: 35),
                const Gap(20),
                Text('The Seep Deep Meaning', style: Style.displayM)
              ],
            ),
            const Gap(100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    buildBox(zKeyPoints[0]),
                    const Gap(150),
                    buildBox(zKeyPoints[1]),
                  ],
                ),
                Column(
                  children: [
                    buildBox(zKeyPoints[2]),
                    const Gap(150),
                    buildBox(zKeyPoints[3]),
                  ],
                ),
                Column(
                  children: [
                    buildBox(zKeyPoints[4]),
                    const Gap(150),
                    buildBox(zKeyPoints[5]),
                  ],
                ),
                const Gap(50),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildSocialProof() {
    return Container(
      height: getHeight(),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(50),
          Text('Our Early Adopters',
              style: Style.headlineS.copyWith(
                color: Colors.lightBlue[700],
                fontWeight: FontWeight.bold,
              )),
          const Gap(50),
          Text('You\'ve found the right spot. These people know it',
              style: Style.displayM),
          const Gap(100),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: getWidth(),
                    maxWidth: getWidth(),
                    minHeight: 500,
                    maxHeight: 500,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: users.length,
                    itemExtentBuilder: (index, dimensions) => 600,
                    itemBuilder: (BuildContext context, int idx) {
                      final u = users[idx];
                      return buildPhotoBox('Students', 400, u, true);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildTechnologies() {
    return Container(
      key: _sectionGKey,
      height: getHeight(),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(SDIcon.best_tech, size: 35),
              const Gap(35),
              Text(
                'The best technologies',
                style: Style.headlineS.copyWith(
                  color: Colors.lightBlue[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gap(50),
          Text('Languages Supported & Incoming', style: Style.displayM),
          const Gap(100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(50),
              getImg('logos/python-favicon.svg'),
              const Gap(50),
              getImg('logos/ruby.svg'),
              const Gap(50),
              getImg('logos/js-favicon.svg'),
              const Gap(50),
              getImg('logos/ts-favicon.svg'),
              const Gap(50),
              getImg('logos/dart-favicon.svg'),
              const Gap(50),
              getImg('logos/java-favicon.svg'),
              const Gap(50),
              getImg('logos/go.svg'),
              const Gap(50),
              getImg('logos/cpp-favicon.svg'),
              const Gap(50),
              getImg('logos/sql-favicon.svg'),
              const Gap(50),
            ],
          )
        ],
      ),
    );
  }

  getImg(path, [size = 300, cover, borderRadius]) {
    List<String> parts = path.split('.');
    String lastElement = parts.last;
    Widget imageWidget;

    switch (lastElement) {
      case 'svg':
        imageWidget = SvgPicture.asset(
          'assets/img/$path',
          width: 64,
          height: 64,
        );
        break;
      default:
        imageWidget = Image.asset(
          'assets/img/$path',
          width: size,
          height: size,
          fit: cover != null ? BoxFit.cover : null,
        );
    }
    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: imageWidget,
      );
    }
    return imageWidget;
  }

  void scrollToSection(GlobalKey key) {
    final RenderObject? renderObject = key.currentContext?.findRenderObject();
    if (renderObject != null && renderObject is RenderBox) {
      final offset =
          renderObject.localToGlobal(Offset.zero).dy + _scrollController.offset;
      _scrollController.animateTo(
        offset,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}
