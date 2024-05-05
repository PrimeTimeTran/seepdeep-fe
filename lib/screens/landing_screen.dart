import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// Emma
// Olivia
// Sophia
// Ava
// Isabella
// Mia
// Amelia
// Charlotte
// Harper
// Ella

// Liam
// Noah
// James
// Elijah
// Oliver
// Benjamin
// Lucas
// William
// Ethan
// Alexander

final users = [
  {
    'name': 'Emma',
    'caption': '',
    'quote': '',
    'title': '',
    'url': '',
    'file': 'headshots/female-2.jpeg',
  },
  {
    'name': 'Liam',
    'caption': '',
    'quote': '',
    'title': '',
    'url': '',
    'file': 'headshots/male-1.jpeg',
  },
  {
    'name': 'Olivia',
    'caption': '',
    'quote': '',
    'title': '',
    'url': '',
    'file': 'headshots/female-3.jpeg',
  },
  {
    'name': 'Noah',
    'caption': '',
    'quote': '',
    'title': '',
    'url': '',
    'file': 'headshots/male-2.jpeg',
  },
  {
    'name': 'Sophia',
    'caption': '',
    'quote': '',
    'title': '',
    'url': '',
    'file': 'headshots/female-4.jpeg',
  },
  {
    'name': 'James',
    'caption': '',
    'quote': '',
    'title': '',
    'url': '',
    'file': 'headshots/male-3.jpeg',
  },
  {
    'name': 'Ava',
    'caption': '',
    'quote': '',
    'title': '',
    'url': '',
    'file': 'headshots/female-5.jpeg',
  },
  {
    'name': 'Isabella',
    'caption': '',
    'quote': '',
    'title': '',
    'url': '',
    'file': 'headshots/female-6.jpeg',
  },
  {
    'name': 'Charlotte',
    'caption': '',
    'quote': '',
    'title': '',
    'url': '',
    'file': 'headshots/female-7.jpeg',
  },
];

final zKeyPoints = [
  {
    "title": "Spaced Repetition",
    "description":
        "Time-tested educational practice, supported by over 80 years of research data.",
    "source": "",
    "icon": ""
  },
  {
    "title": "Problem Library",
    "description": "A collection of the industries most popular problems",
    "icon": "",
    "source": "",
  },
  {
    "title": "Guided Learning",
    "description":
        "A roadmap on what to focus on and how much time to spend on it.",
    "icon": "",
    "source": "",
  },
  {
    "title": "Industry Insiders",
    "description": "Created by Silicon Valley insiders so you know it works.",
    "icon": "",
    "source": "",
  },
  {
    "title": "Curated Content",
    "description":
        "Quality material instead of the hit or miss nature of social media & fan pages",
    "icon": "",
    "source": "",
  },

  // We'll collect their submissions and then submit to AI and ask for room for improvement.
  {
    "title": "AI Enabled",
    "description":
        "Leveraging state of the art technology for feedback on your work.",
    "icon": "",
    "source": "",
  },
];

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return AppHead(
      title: "Seep Deep - Your one stop shop for skills acquisition",
      description:
          "Mastery skills crucial to success in the information age. Develop real mastery with spaced repetition, games, curated content & and more.",
      child: Scaffold(
        appBar: AppBar(
          actions: [
            const Gap(150),
            SvgPicture.asset(
              'assets/icons/favicon.svg',
              width: 48,
              height: 48,
            ),
            const Spacer(),
            const Text('Our mission'),
            const Gap(150),
            const Text('Our Approach'),
            const Gap(150),
            const Text('Testimonials'),
            const Gap(150),
            const Text('FAQs'),
            const Gap(150),
            const Text('Blog'),
            const Gap(150),
          ],
        ),
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
          Text(
            point['title'],
            style: Style.headlineL,
          ),
          Text(point['description'], style: Style.headlineS),
        ],
      ),
    );
  }

  SingleChildScrollView buildDesktop() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: getHeight(),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: getHeight(),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('img/landing-cover.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.1),
                        BlendMode.srcATop,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont fly solo', style: Style.headlineS),
                      const Gap(50),
                      Text(
                        'Money back guarantee.\n\nA fresh take on learning.\n\nnGain 21st century skills more \neasily with us',
                        style: Style.displayM,
                        textAlign: TextAlign.center,
                      ),
                      const Gap(50),
                      SizedBox(
                        height: 75,
                        width: 300,
                        child: OutlinedButton(
                            onPressed: () {
                              GoRouter.of(context).go(AppScreens.auth.path);
                            },
                            child: Text(
                              'Create Account',
                              style: Style.headlineS,
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: getHeight(),
            color: Colors.grey[100],
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 200, vertical: 200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Our Mission', style: Style.headlineS),
                      const Gap(50),
                      Text('Helping you master yourself',
                          style: Style.headlineL),
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
          ),
          Container(
            height: getHeight(),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 200),
              child: Column(
                children: [
                  Text('Who are you?', style: Style.headlineS),
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
                      buildPhotoBox('Students', 250),
                      const Gap(300),
                      buildPhotoBox('Professionals', 250),
                      const Gap(300),
                      buildPhotoBox('Knowledge Geeks', 250),
                      const Gap(100),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: getHeight(),
            color: Colors.grey[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(50),
                Text('Our Early Adopters', style: Style.headlineS),
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
          ),
          Container(
            height: getHeight(),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(50),
                  Text('Our approach', style: Style.headlineS),
                  const Gap(50),
                  Text('The Seep Deep Meaning', style: Style.displayM),
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
          ),
          Container(
            height: getHeight(),
            color: Colors.grey[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(50),
                Text('Heres what they have to say', style: Style.headlineS),
                const Gap(50),
                Text('Incredible', style: Style.displayM),
                const Gap(100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(50),
                    Column(
                      children: [Text('Students', style: Style.headlineS)],
                    ),
                    const Gap(50),
                    Column(
                      children: [Text('Professionals', style: Style.headlineS)],
                    ),
                    const Gap(50),
                    Column(
                      children: [
                        Text('Knowledge geeks', style: Style.headlineS)
                      ],
                    ),
                    const Gap(50),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: getHeight(),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(50),
                Text('The best technologies', style: Style.headlineS),
                const Gap(50),
                Text('Languages Supported & Incoming', style: Style.displayM),
                const Gap(100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(50),
                    getImg('logos/cpp-favicon.svg'),
                    const Gap(50),
                    getImg('logos/dart-favicon.svg'),
                    const Gap(50),
                    getImg('logos/java-favicon.svg'),
                    const Gap(50),
                    getImg('logos/js-favicon.svg'),
                    const Gap(50),
                    getImg('logos/python-favicon.svg'),
                    const Gap(50),
                    getImg('logos/sql-favicon.svg'),
                    const Gap(50),
                    getImg('logos/ts-favicon.svg'),
                    const Gap(50),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: getHeight(),
            color: Colors.grey[100],
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 200, vertical: 200),
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
                            Text('FAQ\'S', style: Style.headlineS),
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
                              buildFAQTile('Is Seep Deep free?',
                                  'Trailing expansion arrow icon'),
                              ExpansionTile(
                                title: Text('Will my profile be public?',
                                    style: Style.headlineL),
                                subtitle: Text('Trailing expansion arrow icon',
                                    style: Style.headlineS),
                                children: const <Widget>[
                                  ListTile(
                                      title: Text('This is tile number 1')),
                                ],
                              ),
                              ExpansionTile(
                                title: Text(
                                    'Im not a programmer, is it ok for me?',
                                    style: Style.headlineL),
                                subtitle: Text('Trailing expansion arrow icon',
                                    style: Style.headlineS),
                                children: const <Widget>[
                                  ListTile(
                                      title: Text('This is tile number 1')),
                                ],
                              ),
                              ExpansionTile(
                                title: Text(
                                    'Can I use Seep Deep to train my students?',
                                    style: Style.headlineL),
                                subtitle: Text('Trailing expansion arrow icon',
                                    style: Style.headlineS),
                                children: const <Widget>[
                                  ListTile(
                                      title: Text('This is tile number 1')),
                                ],
                              ),
                              ExpansionTile(
                                title: Text(
                                    'Can I use Seep Deep for my company?',
                                    style: Style.headlineL),
                                subtitle: Text('Trailing expansion arrow icon',
                                    style: Style.headlineS),
                                children: const <Widget>[
                                  ListTile(
                                      title: Text('This is tile number 1')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: getHeight() / 1.5,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(50),
                Text('Trusted By', style: Style.headlineS),
                const Gap(50),
                Text('Companies Leveraging Our Technology',
                    style: Style.headlineL),
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
          ),
          Container(
            height: 500,
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 200, right: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Product'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Company'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Socials'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Socials'),
                        ],
                      ),
                    ],
                  ),
                  const Gap(250),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Spacer(),
                      Text('Seep Deep © ${currentYear()} All rights reserved '),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildFAQTile(question, answer) {
    return ExpansionTile(
      title: Text(question, style: Style.headlineL),
      subtitle: Text(answer, style: Style.headlineS),
      children: const <Widget>[
        ListTile(title: Text('This is tile number 1')),
      ],
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

  getImg(path, [size = 300, cover, borderRadius]) {
    List<String> parts = path.split('.');
    String lastElement = parts.last;
    Widget imageWidget;

    switch (lastElement) {
      case 'svg':
        imageWidget = SvgPicture.asset(
          'assets/img/$path',
          width: 48,
          height: 48,
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
}
