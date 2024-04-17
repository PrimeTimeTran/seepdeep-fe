import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';

class AppBarContent extends StatefulWidget {
  const AppBarContent({super.key});

  @override
  State<AppBarContent> createState() => _AppBarContentState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _AppBarContentState extends State<AppBarContent> {
  SampleItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                onPressed: () => GoRouter.of(context).go('/'),
                icon: const Icon(Icons.home),
                label: const Text(
                  'CSGems',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go('/explore');
                      },
                      label: const Text('Explore',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(Icons.explore, color: Colors.white),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go('/problems');
                        // openDrawer();
                      },
                      label: const Text('Problems',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(Icons.school_outlined,
                          color: Colors.white),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go('/community');
                      },
                      label: const Text('Community',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(Icons.groups_2_outlined,
                          color: Colors.white),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go('/contests');
                      },
                      label: const Text('Contests',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(Icons.sports_score_outlined,
                          color: Colors.white),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go('/leaderboards');
                      },
                      label: const Text('Leaderboards',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(Icons.leaderboard_outlined,
                          color: Colors.white),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go('/news');
                      },
                      label: const Text('News',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(Icons.newspaper, color: Colors.white),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go('/jobs');
                      },
                      label: const Text('Jobs',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(Icons.work_outline_outlined,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                color: Colors.white,
                onPressed: () {
                  GoRouter.of(context).go('/search');
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.fireplace_outlined,
                  size: 20,
                ),
                color: Colors.white,
                onPressed: () {
                  GoRouter.of(context).go('/streak');
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.notifications_active,
                  size: 20,
                ),
                color: Colors.white,
                onPressed: () {
                  GoRouter.of(context).go('/notifications');
                },
              ),
              PopupMenuButton<SampleItem>(
                icon: const Icon(
                  Icons.help_center_outlined,
                  size: 20,
                  color: Colors.white,
                ),
                initialValue: selectedItem,
                onSelected: (SampleItem item) {
                  setState(() {
                    selectedItem = item;
                  });
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<SampleItem>>[
                  buildMenuItem('Shortcuts', Icons.keyboard, "/explore"),
                  buildMenuItem('Feature Requests', Icons.note_alt_outlined,
                      "/feature-requests"),
                  buildMenuItem('Report Bug', Icons.bug_report, "/bug-reports"),
                ],
              ),
              PopupMenuButton<SampleItem>(
                icon: const Icon(
                  Icons.more_vert,
                  size: 20,
                  color: Colors.white,
                ),
                initialValue: selectedItem,
                onSelected: (SampleItem item) {
                  setState(() {
                    selectedItem = item;
                  });
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<SampleItem>>[
                  buildMenuItem('Profile', Icons.person, "/profile"),
                  buildMenuItem('Settings', Icons.settings, "/settings"),
                  buildMenuItem('Report Bug', Icons.bug_report, "/bug-reports"),
                  buildMenuItem('Logout', Icons.exit_to_app, "/bug-reports"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  PopupMenuItem<SampleItem> buildMenuItem(
      String title, IconData icon, String route) {
    return PopupMenuItem<SampleItem>(
      value: SampleItem.itemOne,
      onTap: () {
        GoRouter.of(context).go(route);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Icon(icon), const SizedBox(width: 5.0), Text(title)],
      ),
    );
  }

  void openDrawer() {
    drawerKey.currentState?.openDrawer();
  }
}
