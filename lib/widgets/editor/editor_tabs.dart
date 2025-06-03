import 'package:app/all.dart';
import 'package:flutter/material.dart';

class EditorTabs extends StatelessWidget {
  final TabController tabController;
  final List<String> tabTitles;
  final List<Widget> tabContents;
  final List<Submission> selectedSubmissions;

  const EditorTabs({
    super.key,
    required this.tabController,
    required this.tabTitles,
    required this.tabContents,
    required this.selectedSubmissions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: tabController,
          isScrollable: true,
          tabs: tabTitles.map((title) => Tab(text: title)).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: tabContents,
          ),
        ),
      ],
    );
  }
}
