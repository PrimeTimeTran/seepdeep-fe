import 'package:app/all.dart';
import 'package:flutter/material.dart';
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
        actions: const [
          Gap(150),
          Text('Our mission'),
          Spacer(),
          Text('Our mission'),
          Gap(150),
          Text('Our Approach'),
          Gap(150),
          Text('Testimonials'),
          Gap(150),
          Text('FAQs'),
          Gap(150),
          Text('Blog'),
          Gap(150),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: getHeight(),
              color: Colors.red,
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
                    style: Style.bodyL,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              height: getHeight(),
              color: Colors.blue,
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
                            style: Style.headlineL),
                      ],
                    ),
                    const Gap(50),
                    Container(color: Colors.green, height: 600, width: 500)
                  ],
                ),
              ),
            ),
            Container(
              height: getHeight(),
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 200),
                child: Column(
                  children: [
                    Text('Who should join us?', style: Style.headlineS),
                    const Gap(50),
                    Text(
                        'We want to make sure you know \nwhat you wanna do with your life',
                        style: Style.displayM),
                    const Gap(100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Gap(100),
                        Column(
                          children: [Text('Students', style: Style.headlineL)],
                        ),
                        const Gap(300),
                        Column(
                          children: [
                            Text('Professionals', style: Style.headlineL)
                          ],
                        ),
                        const Gap(300),
                        Column(
                          children: [
                            Text('Knowledge geeks', style: Style.headlineL)
                          ],
                        ),
                        const Gap(100),
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
                  Text('Who has already joined us?', style: Style.headlineS),
                  const Gap(50),
                  Text('You\'ve found the right spot. These people know it',
                      style: Style.headlineL),
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
              color: Colors.orange,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(50),
                  Text('Heres what they have to say', style: Style.headlineS),
                  const Gap(50),
                  Text('Incredible', style: Style.displayM),
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
              color: Colors.indigo,
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
                            child: const Column(
                              children: [
                                ExpansionTile(
                                  title: Text('Is Seep Deep free?'),
                                  subtitle:
                                      Text('Trailing expansion arrow icon'),
                                  children: <Widget>[
                                    ListTile(
                                        title: Text('This is tile number 1')),
                                  ],
                                ),
                                ExpansionTile(
                                  title: Text('Will my profile be public?'),
                                  subtitle:
                                      Text('Trailing expansion arrow icon'),
                                  children: <Widget>[
                                    ListTile(
                                        title: Text('This is tile number 1')),
                                  ],
                                ),
                                ExpansionTile(
                                  title: Text(
                                      'Im not a programmer, is it ok for me?'),
                                  subtitle:
                                      Text('Trailing expansion arrow icon'),
                                  children: <Widget>[
                                    ListTile(
                                        title: Text('This is tile number 1')),
                                  ],
                                ),
                                ExpansionTile(
                                  title: Text(
                                      'Can I use Seep Deep to train my students?'),
                                  subtitle:
                                      Text('Trailing expansion arrow icon'),
                                  children: <Widget>[
                                    ListTile(
                                        title: Text('This is tile number 1')),
                                  ],
                                ),
                                ExpansionTile(
                                  title: Text(
                                      'Can I use Seep Deep for my company?'),
                                  subtitle:
                                      Text('Trailing expansion arrow icon'),
                                  children: <Widget>[
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
              height: 500,
              color: Colors.yellow,
              child: const Padding(
                padding: EdgeInsets.only(top: 40, left: 200, right: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('sososo'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('sososo'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('sososo'),
                          ],
                        ),
                        Gap(50),
                      ],
                    ),
                    Gap(250),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('sososo'),
                        Text('sososo'),
                        Text('sososo'),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
      child: Text(title, style: Style.bodyL),
    );
  }
}
