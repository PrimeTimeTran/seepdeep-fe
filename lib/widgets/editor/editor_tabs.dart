import 'package:app/all.dart';
import 'package:flutter/material.dart';

class EditorTabs extends StatelessWidget {
  final TabController tabController;
  final List<Widget> tabTitles;
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
          tabs: tabTitles,
          isScrollable: true,
          controller: tabController,
          tabAlignment: TabAlignment.start,
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
