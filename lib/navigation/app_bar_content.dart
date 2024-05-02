import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

void openDrawer() {
  drawerKey.currentState?.openDrawer();
}

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
                onPressed: () => GoRouter.of(context).go(AppScreens.home.path),
                icon: SvgPicture.asset(
                  'assets/icons/favicon.svg',
                  width: 48,
                  height: 48,
                ),
                label: const Text(
                  'SDeep',
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
                        GoRouter.of(context).go(AppScreens.mastery.path);
                      },
                      label: const Text('Mastery',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(Icons.terrain, color: Colors.white),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go(AppScreens.explore.path);
                      },
                      label: const Text('Explore',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(Icons.explore, color: Colors.white),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go(AppScreens.problems.path);
                        // openDrawer();
                      },
                      label: const Text('Problems',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(Icons.school_outlined,
                          color: Colors.white),
                    ),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go(AppScreens.community.path);
                    //   },
                    //   label: const Text('Community',
                    //       style: TextStyle(color: Colors.white)),
                    //   icon: const Icon(Icons.groups_2_outlined,
                    //       color: Colors.white),
                    // ),
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go(AppScreens.contests.path);
                      },
                      label: const Text('Contests',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(Icons.sports_score_outlined,
                          color: Colors.white),
                    ),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go(AppScreens.leaderboards.path);
                    //   },
                    //   label: const Text('Leaderboards',
                    //       style: TextStyle(color: Colors.white)),
                    //   icon: const Icon(Icons.leaderboard_outlined,
                    //       color: Colors.white),
                    // ),
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go(AppScreens.news.path);
                      },
                      label: const Text('News',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(Icons.newspaper, color: Colors.white),
                    ),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go(AppScreens.jobs.path);
                    //   },
                    //   label: const Text('Jobs',
                    //       style: TextStyle(color: Colors.white)),
                    //   icon: const Icon(Icons.work_outline_outlined,
                    //       color: Colors.white),
                    // ),
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go(AppScreens.auth.path);
                      },
                      label: const Text('Auth',
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
                  GoRouter.of(context).go(AppScreens.search.path);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.fireplace_outlined,
                  size: 20,
                ),
                color: Colors.white,
                onPressed: () {
                  GoRouter.of(context).go(AppScreens.streak.path);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.notifications_active,
                  size: 20,
                ),
                color: Colors.white,
                onPressed: () {
                  GoRouter.of(context).go(AppScreens.notifications.path);
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
                  buildMenuItem(
                      'Shortcuts', Icons.keyboard, AppScreens.explore.path),
                  buildMenuItem('Feature Requests', Icons.note_alt_outlined,
                      AppScreens.featureRequests.path),
                  buildMenuItem('Report Bug', Icons.bug_report,
                      AppScreens.bugReports.path),
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
                  buildMenuItem(
                      'Profile', Icons.person, AppScreens.profile.path),
                  buildMenuItem(
                      'Settings', Icons.settings, AppScreens.settings.path),
                  buildMenuItem('Report Bug', Icons.bug_report,
                      AppScreens.bugReports.path),
                  buildMenuItem(
                      'Logout', Icons.exit_to_app, AppScreens.bugReports.path),
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
}
