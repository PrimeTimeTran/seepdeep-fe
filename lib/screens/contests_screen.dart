import 'package:app/all.dart';
import 'package:flutter/material.dart';

class ContestsScreen extends StatefulWidget {
  const ContestsScreen({super.key});

  @override
  State<ContestsScreen> createState() => _ContestsScreenState();
}

class _ContestsScreenState extends State<ContestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: SizedBox(
          height: getHeight() * 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.red,
                child: SizedBox(
                  height: 300,
                  width: getWidth(),
                  child: const Center(child: Text('CSGems Contest')),
                ),
              ),
              const SizedBox(height: 10),
              Transform.translate(
                offset: const Offset(0, -50),
                child: SizedBox(
                  width: 1000,
                  height: 300,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.blue,
                            child: SizedBox(
                              width: getWidth() / 4,
                              height: 250,
                              child: const Text('Weekly'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            color: Colors.green,
                            child: SizedBox(
                              width: getWidth() / 4,
                              height: 250,
                              child: const Text('BiWeekly'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 300,
                        child: buildFeaturedContests(),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          color: Colors.green,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildContestHistory(700),
                              const SizedBox(width: 10),
                              buildContestHistory(400)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildContestHistory(width) {
    return Container(
      width: width,
      color: Colors.red,
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int) {
          return SizedBox(
            height: 40,
            width: 40,
            child: ListTile(
              title: Text('Context $int'),
            ),
          );
        },
      ),
    );
  }

  buildFeaturedContests() {
    return Container(
      color: Colors.pink,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.blue,
                  child: SizedBox(
                    width: 600,
                    height: 200,
                    child: Text('Contest $int'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
