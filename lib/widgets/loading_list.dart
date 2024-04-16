import 'package:app/screens/community_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'shimmers.dart';

class LoadingList extends StatefulWidget {
  const LoadingList({super.key});

  @override
  State<LoadingList> createState() => _LoadingListState();
}

class _LoadingListState extends State<LoadingList> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: const SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
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
}
