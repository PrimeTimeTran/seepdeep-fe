// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:app/all.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void openDrawer() {
  drawerKey.currentState?.openDrawer();
}

class AnimatedSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const AnimatedSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  _AnimatedSwitchState createState() => _AnimatedSwitchState();
}

class AppBarContent extends StatefulWidget {
  Function toggleTheme;
  AppBarContent({super.key, required this.toggleTheme});

  @override
  State<AppBarContent> createState() => _AppBarContentState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch> {
  late bool _value;

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.wb_sunny_outlined);
      }
      return const Icon(Icons.nightlight_outlined);
    },
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Switch(
        value: _value,
        activeTrackColor: Colors.yellowAccent.shade100,
        thumbIcon: thumbIcon,
        onChanged: (bool newValue) {
          setState(() {
            _value = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
      ),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }
}

class _AppBarContentState extends State<AppBarContent> {
  SampleItem? selectedItem;

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.wb_sunny_outlined);
      }
      return const Icon(Icons.nightlight_outlined);
    },
  );

  bool light1 = true;

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
                onPressed: () =>
                    GoRouter.of(context).go(AppScreens.problems.path),
                icon: SvgPicture.asset(
                  'assets/img/favicon.svg',
                  width: 48,
                  height: 48,
                ),
                label: Text(
                  'SeepDeep',
                  style: Style.of(context, 'bodyL').copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go('/math/test');
                    //   },
                    //   label: const Text(
                    //     'Test',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   icon: const Icon(Icons.calculate, color: Colors.white),
                    // ),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go(AppScreens.mathIndex.path);
                    //   },
                    //   label: const Text(
                    //     'Maths',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   icon: const Icon(Icons.calculate, color: Colors.white),
                    // ),
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go(AppScreens.problems.path);
                      },
                      label: const Text('Data Structures',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(
                        Icons.widgets_outlined,
                        color: Colors.white,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).go(AppScreens.sql.path);
                      },
                      label: const Text(
                        'Databases',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      icon: const Icon(Icons.table_chart_outlined,
                          color: Colors.white),
                    ),

                    // WIP: Top app bar links to different modules of Seep Deep
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go(AppScreens.assets.path);
                    //   },
                    //   label: const Text(
                    //     'Assets',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   icon: const Icon(Icons.table_chart_outlined,
                    //       color: Colors.white),
                    // ),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go(AppScreens.mastery.path);
                    //   },
                    //   label: const Text('Mastery',
                    //       style: TextStyle(color: Colors.white)),
                    //   icon: const Icon(Icons.auto_graph_outlined,
                    //       color: Colors.white),
                    // ),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go(AppScreens.explore.path);
                    //   },
                    //   label: const Text('Explore',
                    //       style: TextStyle(color: Colors.white)),
                    //   icon: const Icon(Icons.explore, color: Colors.white),
                    // ),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go(AppScreens.community.path);
                    //   },
                    //   label: const Text('Community',
                    //       style: TextStyle(color: Colors.white)),
                    //   icon: const Icon(Icons.groups_2_outlined,
                    //       color: Colors.white),
                    // ),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go(AppScreens.contests.path);
                    //   },
                    //   label: const Text('Contests',
                    //       style: TextStyle(color: Colors.white)),
                    //   icon: const Icon(Icons.sports_score_outlined,
                    //       color: Colors.white),
                    // ),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go(AppScreens.leaderboards.path);
                    //   },
                    //   label: const Text('Leaderboards',
                    //       style: TextStyle(color: Colors.white)),
                    //   icon: const Icon(Icons.leaderboard_outlined,
                    //       color: Colors.white),
                    // ),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go(AppScreens.news.path);
                    //   },
                    //   label: const Text('News',
                    //       style: TextStyle(color: Colors.white)),
                    //   icon: const Icon(Icons.newspaper, color: Colors.white),
                    // ),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go(AppScreens.jobs.path);
                    //   },
                    //   label: const Text('Jobs',
                    //       style: TextStyle(color: Colors.white)),
                    //   icon: const Icon(Icons.work_outline_outlined,
                    //       color: Colors.white),
                    // ),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     GoRouter.of(context).go(AppScreens.auth.path);
                    //   },
                    //   label: const Text('Auth',
                    //       style: TextStyle(color: Colors.white)),
                    //   icon: const Icon(Icons.work_outline_outlined,
                    //       color: Colors.white),
                    // ),
                  ],
                ),
              ),
              // IconButton(
              //   icon: const Icon(
              //     Icons.search,
              //     size: 20,
              //   ),
              //   color: Colors.white,
              //   onPressed: () {
              //     GoRouter.of(context).go(AppScreens.search.path);
              //   },
              // ),
              // IconButton(
              //   icon: const Icon(
              //     Icons.fireplace_outlined,
              //     size: 20,
              //   ),
              //   color: Colors.white,
              //   onPressed: () {
              //     GoRouter.of(context).go(AppScreens.streak.path);
              //   },
              // ),
              AnimatedSwitch(
                value: light1,
                onChanged: (bool? value) {
                  widget.toggleTheme();
                  setState(() {
                    light1 = value!;
                  });
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
                  Icons.help_outline_outlined,
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
                    'Shortcuts',
                    Icons.keyboard,
                    'shortcuts',
                  ),
                  buildMenuItem(
                    'Feature Requests',
                    Icons.note_alt_outlined,
                    AppScreens.featureRequests.path,
                  ),
                  buildMenuItem(
                    'Report Bug',
                    Icons.bug_report,
                    AppScreens.bugReports.path,
                  ),
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
                itemBuilder: (BuildContext context) => [
                  buildMenuItem(
                    'About US',
                    Icons.business,
                    AppScreens.landing.path,
                  ),
                  buildMenuItem(
                    'Profile',
                    Icons.person,
                    AppScreens.profile.path,
                  ),
                  buildMenuItem(
                    'Settings',
                    Icons.settings,
                    AppScreens.settings.path,
                  ),
                  // PopupMenuItem<SampleItem>(
                  //   value: SampleItem.itemOne,
                  //   child: InkWell(
                  //     onTap: () {},
                  //     child: AnimatedSwitch(
                  //       value: light1,
                  //       onChanged: (bool? value) {
                  //         widget.toggleTheme();
                  //         setState(() {
                  //           light1 = value!;
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // ),
                  buildMenuItem(
                    'Report Bug',
                    Icons.bug_report,
                    AppScreens.bugReports.path,
                  ),
                  buildMenuItem(
                    '',
                    Icons.exit_to_app,
                    'auth',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  PopupMenuItem<SampleItem> buildMenuItem(
    String title,
    IconData icon,
    String route,
  ) {
    return PopupMenuItem<SampleItem>(
      value: SampleItem.itemOne,
      onTap: () async {
        final auth = Provider.of<AuthProvider>(context, listen: false);
        if (auth.isAuthenticated) {
          if (route == 'auth') {
            auth.setUser(null);
            auth.setAuthenticated(false);
            Storage.instance.setUser(null);
            Storage.instance.setToken(null);
            return;
          }
        } else {
          if (route == 'auth') {
            dialogGetCode(context);
            return;
          }
        }
        if (route == AppScreens.featureRequests.path) {
          dialogFeatureRequest(context);
          await FirebaseAnalytics.instance.logEvent(
            name: "engage",
            parameters: {"type": "feature_request_create"},
          );
        } else if (route == AppScreens.bugReports.path) {
          await FirebaseAnalytics.instance.logEvent(
            name: "engage",
            parameters: {"type": "bug_report_create"},
          );
          dialogBugReport(context);
        } else if (route == 'shortcuts') {
          await FirebaseAnalytics.instance.logEvent(
            name: "engage",
            parameters: {"type": "shortcuts_research"},
          );
          dialogShortcuts(context);
          await FirebaseAnalytics.instance.logEvent(
            name: "engage",
            parameters: {"type": "navigate_site"},
          );
        } else {
          GoRouter.of(context).go(route);
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<AuthProvider>(
            builder: (context, auth, child) {
              if (route == 'auth') {
                if (auth.user?.email != null) {
                  return const Icon(Icons.exit_to_app);
                } else {
                  return const Icon(Icons.create);
                }
              }
              return Icon(icon);
            },
          ),
          const SizedBox(width: 5.0),
          Consumer<AuthProvider>(
            builder: (context, auth, child) {
              if (route == 'auth') {
                if (auth.user?.email != null) {
                  title = 'Log Out';
                  icon = Icons.exit_to_app;
                } else {
                  title = 'Sign Up';
                  icon = Icons.create;
                }
              }
              return Text(title);
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }
}
