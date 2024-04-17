import 'package:app/utils.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: getWidth() / 2, child: const LoadingList()),
      ],
    );
  }
}

class _LoadingListState extends State<LoadingList> {
  List<String> path = ['Home'];
  bool isLoaded = true;

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    buildCategory('AI'),
                    buildCategory('Problems'),
                    buildCategory('Maths'),
                    buildCategory('Business'),
                    buildCategory('Companies'),
                    buildCategory('Reviews'),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
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
          ],
        ),
      ),
    );
  }

  buildCategory(category) {
    return GestureDetector(
      onTap: () {
        path.add(category);
        setState(() {
          path = path;
        });
      },
      child: Column(
        children: [
          Row(
            children: [Text(category)],
          ),
          SizedBox(
            width: 925,
            height: 450,
            child: ListView.builder(
                itemCount: 7,
                itemBuilder: (BuildContext context, int idx) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text('Title $idx'),
                        subtitle: Text('Subtitle $idx'),
                      )
                    ],
                  );
                }),
          )
        ],
      ),
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
