import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  buildBox(title) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 450,
        maxWidth: 450,
        minHeight: 250,
        maxHeight: 250,
      ),
      child: Text(title, style: Style.headlineS),
    );
  }

  SingleChildScrollView buildDesktop() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: getHeight(),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Wanna be a better you?', style: Style.headlineL),
                Text(
                  'Seeking the skills \nto compete with the \nworld\'s best?',
                  style: Style.displayL,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'See why youre at the right place',
                  style: Style.headlineS,
                  textAlign: TextAlign.center,
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
                      const Gap(50),
                      buildPhotoBox('Students', 400),
                      const Gap(50),
                      buildPhotoBox('Professionals', 400),
                      const Gap(50),
                      buildPhotoBox('Knowledge Geeks', 400),
                      const Gap(50),
                      buildPhotoBox('Knowledge Geeks', 400),
                      const Gap(50),
                      buildPhotoBox('Knowledge Geeks', 400),
                      const Gap(50),
                      buildPhotoBox('Knowledge Geeks', 400),
                      const Gap(50),
                      buildPhotoBox('Knowledge Geeks', 400),
                      const Gap(50),
                      buildPhotoBox('Knowledge Geeks', 400),
                      const Gap(50),
                      buildPhotoBox('Knowledge Geeks', 400),
                      const Gap(50),
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
                          buildBox('Spaced Repetition'),
                          const Gap(150),
                          buildBox('Problem Library'),
                        ],
                      ),
                      Column(
                        children: [
                          buildBox('Guided Learning'),
                          const Gap(150),
                          buildBox('Industry Insiders'),
                        ],
                      ),
                      Column(
                        children: [
                          buildBox('Curated Content'),
                          const Gap(150),
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
                    buildLogo('cpp-favicon.svg'),
                    const Gap(50),
                    buildLogo('dart-favicon.svg'),
                    const Gap(50),
                    buildLogo('java-favicon.svg'),
                    const Gap(50),
                    buildLogo('js-favicon.svg'),
                    const Gap(50),
                    buildLogo('python-favicon.svg'),
                    const Gap(50),
                    buildLogo('sql-favicon.svg'),
                    const Gap(50),
                    buildLogo('ts-favicon.svg'),
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
                    buildLogo('scanlab-favicon.jpg', 200),
                    const Gap(100),
                    buildLogo('data-annotation-favicon.svg'),
                    const Gap(100),
                    buildLogo('adapt-health-favicon.png'),
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

  buildLogo(title, [size = 300]) {
    List<String> parts = title.split('.');
    String lastElement = parts.last;
    switch (lastElement) {
      case 'svg':
        return SvgPicture.asset(
          'assets/icons/logos/$title',
          width: 48,
          height: 48,
        );
      default:
        return Image.asset(
          'assets/icons/logos/$title',
          width: size,
          height: size,
        );
    }
  }

  buildPhotoBox(title, size) {
    return Column(
      children: [
        Text(title, style: Style.headlineS),
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              color: Colors.blue[300]!,
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.elliptical(20, 20))),
        )
      ],
    );
  }
}
