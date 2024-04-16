import 'package:app/utils.dart';
import 'package:app/widgets/shimmers.dart';
import 'package:flutter/material.dart';
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
