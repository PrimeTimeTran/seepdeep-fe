// ignore_for_file: must_be_immutable

import 'package:app/all.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.0,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
    );
  }
}

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class PathItem {
  String title;
  int depth;
  PathItem(this.title, this.depth);
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool isLoaded = true;
  List<String> path = ['Home'];
  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: getWidth() / 2,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BreadCrumb(
                    items: <BreadCrumbItem>[
                      ...path.map((item) => BreadCrumbItem(
                          content: Text(item),
                          onTap: () {
                            final newIdx = path.indexOf(item);
                            path = path.take(newIdx + 1).toList();
                            setState(() {
                              path = path;
                            });
                          })),
                    ],
                    divider: const Icon(Icons.chevron_right),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildCategory('D.S.A.'),
                        buildCategory('Math'),
                        buildCategory('Companies'),
                        buildCategory('Startups'),
                        buildCategory('Green'),
                        buildCategory('Hardware'),
                        buildCategory('Finance'),
                        buildCategory('Automotive'),
                        buildCategory('Space'),
                        buildCategory('Education'),
                        buildCategory('AI'),
                        buildCategory('Social'),
                        buildCategory('Telecommunications'),
                        buildCategory('Business'),
                        buildCategory('Product Reviews'),
                        buildCategory('Misc'),
                        buildCategory('Systems'),
                        buildCategory('Entertainment'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return ShimmerList();
  }

  buildCategory(category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GFAccordion(
          titlePadding: const EdgeInsets.all(20),
          showAccordion: true,
          titleChild: Text(
            category,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          collapsedIcon: const Icon(Icons.keyboard_arrow_down_sharp),
          expandedIcon: const Icon(Icons.keyboard_arrow_up_sharp),
          contentChild: GestureDetector(
            onTap: () {
              path.add(category);
              setState(() {
                path = path;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: getWidth() / 2,
                height: 500,
                child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int idx) {
                    return const GFListTile(
                        titleText: 'Title',
                        color: Colors.lightBlueAccent,
                        description: Text('description'),
                        title: Text('title'),
                        enabled: true,
                        subTitleText:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing',
                        icon: Icon(Icons.favorite));
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!kDebugMode) {
        isLoaded = true;
      }
    });
  }
}
