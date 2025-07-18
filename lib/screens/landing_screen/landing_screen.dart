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

class ThemeWrapper extends StatefulWidget {
  const ThemeWrapper({super.key});

  @override
  State<ThemeWrapper> createState() => _ThemeWrapperState();
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

  bool light1 = true;
  late bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return MaterialApp(
      themeMode: themeMode,
      theme: Style.lightTheme,
      darkTheme: Style.darkTheme,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: buildNavbar(),
            body: buildDesktop(),
          );
        },
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
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.outline),
              )
            ],
          ),
          const Gap(20),
          Text(
            point['description'],
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }

  buildDesktop() {
    return Builder(builder: (context) {
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
    });
  }

  Container buildFAQs() {
    return Container(
      key: _sectionEKey,
      height: getHeight() * .75,
      color: Theme.of(context).colorScheme.surfaceContainer,
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
                              style: Theme.of(context).textTheme.headlineSmall),
                        ],
                      ),
                      const Gap(25),
                      Text('Frequently \nAsked Questions',
                          style: Theme.of(context).textTheme.displayMedium),
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
      title: Text(
        question,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: followup == null
          ? null
          : Text(
              followup,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
      children: <Widget>[
        ListTile(
          title: Text(
            answer ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
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
                        'WHO ARE YOU?',
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ],
                  ),
                  const Gap(50),
                  const Gap(100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(100),
                      Column(
                        children: [
                          Text('Learners',
                              style: Theme.of(context).textTheme.headlineSmall),
                          SizedBox(
                            height: 250,
                            width: 250,
                            child: Text(
                              "You love learning or you're determined to succeed in your educational journey.",
                              style: Theme.of(context).textTheme.displaySmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const Gap(100),
                      Column(
                        children: [
                          Text('Teachers',
                              style: Theme.of(context).textTheme.headlineSmall),
                          SizedBox(
                            height: 250,
                            width: 250,
                            child: Text(
                              "You're managing a ever increasing list \nof things to do. You need help \ndelivering on the mission.",
                              style: Theme.of(context).textTheme.displaySmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const Gap(100),
                      Column(
                        children: [
                          Text('Businesses',
                              style: Theme.of(context).textTheme.headlineSmall),
                          SizedBox(
                            height: 250,
                            width: 250,
                            child: Text(
                              "You're inundated with candidates. Your're training new members.",
                              style: Theme.of(context).textTheme.displaySmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
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
      height: 800,
      color: themeColor(context, 'surface'),
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
                    Row(
                      children: [
                        Icon(
                          Icons.category_outlined,
                          color: themeColor(
                            context,
                            'outline',
                          ),
                        ),
                        const Gap(10),
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
                      ],
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
                        launchUrl(Uri.parse('https://seepdeep.com/maths'));
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
                    TextButton(
                      onPressed: () {
                        // launchUrl(Uri.parse('https://seepdeep.com/math'));
                      },
                      child: const Text(
                        'Home Work',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // launchUrl(Uri.parse('https://seepdeep.com/math'));
                      },
                      child: const Text(
                        'Play Book',
                      ),
                    ),
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
                    TextButton(
                      onPressed: () {
                        // launchUrl(Uri.parse('https://seepdeep.com/math'));
                      },
                      child: const Text(
                        'Applicant Screener',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // launchUrl(Uri.parse('https://seepdeep.com/math'));
                      },
                      child: const Text(
                        'Team Developer',
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.business,
                          color: themeColor(
                            context,
                            'outline',
                          ),
                        ),
                        const Gap(10),
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
                      ],
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
                    TextButton(
                      onPressed: () async {},
                      child: const Text(
                        'Careers',
                      ),
                    ),
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
                    TextButton(
                      onPressed: () async {
                        final url = Uri.parse('mailto:contact@seepdeep.com');
                        if (await canLaunchUrl(url)) {
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: const Text(
                        'contact@seepdeep.com',
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.content_paste_search_outlined,
                          color: themeColor(
                            context,
                            'outline',
                          ),
                        ),
                        const Gap(10),
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
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            launchUrl(Uri.parse(
                                'https://www.facebook.com/profile.php?id=61559652654746'));
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
                            launchUrl(Uri.parse(
                                'https://www.linkedin.com/company/seep-deep'));
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
                          'FLY HIGHER',
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ],
                    ),
                    const Gap(50),
                    Text(
                      'Next Generation Learning Platform. \nDeveloped to help students achieve, \nteachers deliver & businesses succeed.',
                      style: Theme.of(context).textTheme.displayLarge,
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
      color: Theme.of(context).colorScheme.surface,
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
                      'OUR MISSION',
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  ],
                ),
                const Gap(50),
                Text(
                  'Helping you master yourself',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const Gap(50),
                Text(
                    'Were about helping people become \nthe best version of themselves. \nWe\'re about enabling',
                    style: Theme.of(context).textTheme.headlineMedium),
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
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
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
          label: Text('Our Mission',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        ),
        const Gap(50),
        TextButton.icon(
          icon: const Icon(Icons.directions_outlined),
          onPressed: () => scrollToSection(_sectionCKey),
          label: Text('Our Approach',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        ),
        const Gap(50),
        TextButton.icon(
          icon: const Icon(Icons.category_outlined),
          onPressed: () => scrollToSection(_sectionGKey),
          label: Text('Technologies',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        ),
        const Gap(50),
        TextButton.icon(
          icon: const Icon(Icons.supervised_user_circle_outlined),
          onPressed: () => scrollToSection(_sectionDKey),
          label: Text('Ideal Customers',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        ),
        const Gap(50),
        TextButton.icon(
          icon: const Icon(Icons.business),
          onPressed: () => scrollToSection(_sectionFKey),
          label: Text('Partners',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        ),
        const Gap(50),
        TextButton.icon(
          icon: const Icon(Icons.help),
          onPressed: () => scrollToSection(_sectionEKey),
          label: Text('FAQs',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        ),
        AnimatedSwitch(
          value: light1,
          onChanged: (bool? value) {
            Storage.instance.setTheme();
            setState(() {
              _isDarkMode = !_isDarkMode;
              light1 = value!;
            });
          },
        ),
        const Gap(150),
      ],
    );
  }

  Container buildPartners() {
    return Container(
      key: _sectionFKey,
      color: Theme.of(context).colorScheme.surface,
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
              Text('TRUSTED BY',
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const Gap(50),
          Text('Companies Working Smarter',
              style: Theme.of(context).textTheme.headlineLarge),
          const Gap(100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(50),
              // getImg('logos/adobe-partner.svg'),
              const Gap(100),
              getImg('logos/airbnb-partner.svg'),
              const Gap(100),
              getImg('logos/coinbase-partner.svg'),
              const Gap(50),
            ],
          ),
          const Gap(25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(50),
              getImg('logos/facebook-partner.svg'),
              const Gap(100),
              // getImg('logos/github-partner.svg'),
              const Gap(100),
              getImg('logos/google-partner.svg'),
              const Gap(50),
            ],
          ),
          const Gap(25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(50),
              // getImg('logos/ibm-partner.svg'),
              const Gap(100),
              getImg('logos/linkedin-partner.svg'),
              const Gap(100),
              getImg('logos/microsoft-partner.svg'),
              const Gap(50),
            ],
          ),
          const Gap(25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(50),
              getImg('logos/netflix-partner.svg', 100),
              const Gap(100),
              // getImg('logos/salesforce-partner.svg', 100),
              const Gap(100),
              getImg('logos/stripe-partner.svg', 100),
              const Gap(50),
            ],
          ),
        ],
      ),
    );
  }

  buildPhotoBox(title, size, [u, cover, content, contentBody]) {
    if (content != null) {
      return Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(
            height: size,
            width: size,
            child: Text(contentBody),
          ),
        ],
      );
    }
    return Column(
      children: [
        Text(u != null ? u['name'] : title,
            style: Theme.of(context).textTheme.headlineSmall),
        Container(
          height: size,
          width: size,
          child: u != null ? getImg(u['file'], 500, true, true) : null,
          decoration: BoxDecoration(
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
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.chrome_reader_mode_outlined, size: 35),
              const Gap(35),
              Text('THEIR REVIEWS',
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const Gap(50),
          Text(
            'Incredible',
            style: Theme.of(context).textTheme.displayMedium,
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
                  Text('Learners',
                      style: Theme.of(context).textTheme.headlineSmall)
                ],
              ),
              const Gap(150),
              Column(
                children: [
                  const Icon(SDIcon.professional, size: 50),
                  const Gap(35),
                  Text('Teachers',
                      style: Theme.of(context).textTheme.headlineSmall)
                ],
              ),
              const Gap(150),
              Column(
                children: [
                  const Icon(SDIcon.company, size: 50),
                  const Gap(35),
                  Text('Businesses',
                      style: Theme.of(context).textTheme.headlineSmall)
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
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.directions_outlined, size: 35),
                const Gap(35),
                Text(
                  'OUR APPROACH',
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ],
            ),
            const Gap(50),
            Row(
              children: [
                const Icon(SDIcon.curated_content, size: 35),
                const Gap(20),
                Text('The Seep Deep Meaning',
                    style: Theme.of(context).textTheme.displayMedium)
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
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.groups_rounded, size: 35),
              const Gap(35),
              Text(
                'OUR EARLY ADOPTERS',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const Gap(50),
          Text('You\'ve found the right spot. These people know it',
              style: Theme.of(context).textTheme.displayMedium),
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
      color: Theme.of(context).colorScheme.surface,
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
                'THE BEST TECHNOLOGIES',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const Gap(50),
          Text('Languages Supported & Incoming',
              style: Theme.of(context).textTheme.displayMedium),
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

class _ThemeWrapperState extends State<ThemeWrapper> {
  late bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return MaterialApp(
      themeMode: themeMode,
      theme: Style.lightTheme,
      darkTheme: Style.darkTheme,
      home: const LandingScreen(),
    );
  }

  getStoredTheme() async {
    final storedTheme = await Storage.instance.getTheme();
    if (storedTheme != _isDarkMode) {
      setState(() {
        _isDarkMode = storedTheme;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getStoredTheme();
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    Storage.instance.setTheme();
  }
}
