import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigatorKeyA = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final navigatorKeyB = GlobalKey<NavigatorState>(debugLabel: 'shellB');

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, shell) {
          return App(shell: shell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: navigatorKeyA,
            routes: [
              GoRoute(
                path: '/',
                name: Routes.home.toString(),
                builder: (_, __) => const ProblemsScreen(),
              ),
              GoRoute(
                path: '/problems',
                name: Routes.problems.toString(),
                builder: (_, __) => const ProblemsScreen(),
              ),
              GoRoute(
                path: '/problem',
                name: Routes.problem.toString(),
                builder: (_, __) => const ProblemScreen(),
              ),
              GoRoute(
                path: '/sort',
                name: Routes.sort.toString(),
                builder: (_, __) => const SortScreen(),
              ),
              GoRoute(
                path: '/maze',
                name: Routes.maze.toString(),
                builder: (_, __) => const MazeScreen(),
              ),
              GoRoute(
                path: '/sql',
                name: Routes.sql.toString(),
                builder: (_, __) => const SQLScreen(),
              ),
              GoRoute(
                path: '/news',
                name: Routes.news.toString(),
                builder: (_, __) => const NewsScreen(),
              ),
              GoRoute(
                path: '/explore',
                name: Routes.explore.toString(),
                builder: (_, __) => const ExploreScreen(),
              ),
              GoRoute(
                path: '/leaderboards',
                name: Routes.leaderboards.toString(),
                builder: (_, __) => const LeaderboardsScreen(),
              ),
              GoRoute(
                path: '/community',
                name: Routes.community.toString(),
                builder: (_, __) => const CommunityScreen(),
              ),
              GoRoute(
                path: '/contests',
                name: Routes.contests.toString(),
                builder: (_, __) => const ContestsScreen(),
              ),
              GoRoute(
                path: '/jobs',
                name: Routes.jobs.toString(),
                builder: (_, __) => const JobsScreen(),
              ),
              GoRoute(
                path: '/profile',
                name: Routes.profile.toString(),
                builder: (_, __) => const ProfileScreen(),
              ),
              GoRoute(
                path: '/notifications',
                name: Routes.notifications.toString(),
                builder: (_, __) => const NotificationScreen(),
              ),
              GoRoute(
                path: '/settings',
                name: Routes.settings.toString(),
                builder: (_, __) => const SettingsScreen(),
              ),
              GoRoute(
                path: '/feature-requests',
                name: Routes.featureRequests.toString(),
                builder: (_, __) => const FeatureRequestScreen(),
              ),
              GoRoute(
                path: '/bug-reports',
                name: Routes.bugReports.toString(),
                builder: (_, __) => const BugReportScreen(),
              ),
              GoRoute(
                path: '/search',
                name: Routes.search.toString(),
                builder: (_, __) => const SearchScreen(),
              ),
              GoRoute(
                path: '/streak',
                name: Routes.streak.toString(),
                builder: (_, __) => const StreakScreen(),
              ),
            ],
          )
        ]),
    StatefulShellRoute.indexedStack(
        builder: (context, state, shell) {
          return App(shell: shell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: navigatorKeyB,
            routes: [
              GoRoute(
                path: '/landing',
                name: Routes.landing.toString(),
                builder: (_, __) => const ProblemsScreen(),
              ),
            ],
          )
        ]),
  ],
);

class App extends StatefulWidget {
  final StatefulNavigationShell shell;
  const App({super.key, required this.shell});
  @override
  State<App> createState() => _AppState();
}

// ignore: must_be_immutable
class RootNavigator extends StatefulWidget {
  Widget screen;
  RootNavigator({super.key, required this.screen});

  @override
  State<RootNavigator> createState() => _RootNavigatorState();
}

enum Routes {
  landing,
  problem,
  problems,
  sort,
  sql,
  maze,
  news,
  home,
  jobs,
  leaderboards,
  contests,
  community,
  explore,
  profile,
  settings,
  featureRequests,
  bugReports,
  notifications,
  search,
  streak
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      body: RootNavigator(
        screen: Container(
          height: getHeight(),
          color: Colors.black.lighten(75),
          child: widget.shell,
        ),
      ),
      drawer: const MyDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: SizedBox(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Colors.blue[900]!, Colors.lightBlue],
              ),
            ),
            child: const AppBarContent(),
          ),
        ),
      ),
    );
  }
}

class _RootNavigatorState extends State<RootNavigator> {
  int currentPageIndex = 0;

  NavigationRailLabelType labelType = NavigationRailLabelType.all;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: double.infinity,
          child: NavigationRail(
            labelType: labelType,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.code),
                label: Text('Code'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.topic),
                label: Text('Topics'),
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
                openDrawer();
              } else if (index == 2) {
                GoRouter.of(context).go('/sort');
              } else if (index == 3) {
                GoRouter.of(context).go('/maze');
              } else if (index == 4) {
                GoRouter.of(context).go('/sql');
              }
              setState(() {
                currentPageIndex = index;
              });
            },
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: widget.screen,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
