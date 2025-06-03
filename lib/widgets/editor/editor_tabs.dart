import 'package:app/all.dart';
import 'package:flutter/material.dart';

class EditorTabs extends StatelessWidget {
  final List<String> tabTitles;
  final List<Widget> tabContents;
  final List<Submission> selectedSubmissions;

  const EditorTabs({
    super.key,
    required this.tabTitles,
    required this.tabContents,
    required this.selectedSubmissions,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            tabs: [
              const Tab(text: 'Editor'),
              ...selectedSubmissions
                  .map((submission) => const Tab(text: 'Accepted')),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: tabContents,
            ),
          ),
        ],
      ),
    );
  }
}
