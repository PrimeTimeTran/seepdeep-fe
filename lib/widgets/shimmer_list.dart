// ignore_for_file: must_be_immutable

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatefulWidget {
  int? count;
  ShimmerList({super.key, this.count = 25});

  @override
  State<ShimmerList> createState() => _ShimmerListState();
}

class _ShimmerListState extends State<ShimmerList> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const BannerPlaceholder(),
            SizedBox(
              height: getHeight(),
              width: double.infinity,
              child: ListView.builder(
                itemCount: widget.count,
                itemBuilder: (context, index) {
                  return const ShimmerPost();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
