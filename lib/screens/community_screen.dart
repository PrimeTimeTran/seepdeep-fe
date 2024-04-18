import 'package:app/widgets/shimmers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:shimmer/shimmer.dart';

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

class LoadingList extends StatefulWidget {
  const LoadingList({super.key});

  @override
  State<LoadingList> createState() => _LoadingListState();
}

class PathItem {
  String title;
  int depth;
  PathItem(this.title, this.depth);
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return const LoadingList();
  }
}

class _LoadingListState extends State<LoadingList> {
  List<String> path = ['Home'];
  bool isLoaded = true;

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
      );
    }

    return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BannerPlaceholder(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
            ShimmerPost(),
          ],
        ),
      ),
    );
  }

  buildCategory(category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [Text(category)],
        ),
        GestureDetector(
          onTap: () {
            path.add(category);
            setState(() {
              path = path;
            });
          },
          child: SizedBox(
            width: 925,
            height: 450,
            child: ListView.builder(
                itemCount: 7,
                itemBuilder: (BuildContext context, int idx) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text('Title $idx'),
                        subtitle: Text('Subtitle $idx'),
                      )
                    ],
                  );
                }),
          ),
        )
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
