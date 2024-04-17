import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootNavigator extends StatefulWidget {
  Widget screen;
  RootNavigator({super.key, required this.screen});

  @override
  State<RootNavigator> createState() => _RootNavigatorState();
}

class _RootNavigatorState extends State<RootNavigator> {
  int currentPageIndex = 0;

  NavigationRailLabelType labelType = NavigationRailLabelType.all;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NavigationRail(
          labelType: labelType,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.code),
              label: Text('Code'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.sort_by_alpha),
              label: Text('Sorting'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.grid_on),
              label: Text('Matrix'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.table_chart_rounded),
              label: Text('SQL'),
            ),
          ],
          useIndicator: true,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            if (index == 0) {
              GoRouter.of(context).go('/problems');
            } else if (index == 1) {
              GoRouter.of(context).go('/sort');
            } else if (index == 2) {
              GoRouter.of(context).go('/maze');
            } else if (index == 3) {
              GoRouter.of(context).go('/sql');
            }
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
        Expanded(
          child: widget.screen,
        )
        // Expanded(
        //   child: SingleChildScrollView(
        //     physics: const NeverScrollableScrollPhysics(),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         SizedBox(
        //           width: getWidth(),
        //           height: getHeight(),
        //           child: [
        //             widget.screen,
        //             // const ProblemScreen(),
        //             // const SortScreen(),
        //             // const MazeScreen(),
        //             // const SQLScreen(),
        //           ][currentPageIndex],
        //         )
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }
}
