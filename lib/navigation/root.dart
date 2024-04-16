import 'package:app/screens/maze_screen.dart';
import 'package:app/screens/problem_screen.dart';
import 'package:app/screens/sort_screen.dart';
import 'package:app/screens/sql_screen.dart';
import 'package:app/utils.dart';
import 'package:flutter/material.dart';

class RootNavigator extends StatefulWidget {
  const RootNavigator({super.key});

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
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: getWidth(),
                  height: getHeight(),
                  child: [
                    const ProblemScreen(),
                    const SortScreen(),
                    const MazeScreen(),
                    const SQLScreen(),
                  ][currentPageIndex],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
