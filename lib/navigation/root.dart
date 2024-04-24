import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

final navigatorKeyA = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final navigatorKeyB = GlobalKey<NavigatorState>(debugLabel: 'shellB');

final routerConfig = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
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
                path: AppScreens.home.path,
                name: AppScreens.home.name,
                builder: (_, __) => const ProblemsScreen(),
              ),
              GoRoute(
                path: AppScreens.problems.path,
                name: AppScreens.problems.name,
                builder: (_, __) => const ProblemsScreen(),
              ),
              GoRoute(
                path: AppScreens.problem.path,
                name: AppScreens.problem.name,
                builder: (_, __) => const ProblemScreen(),
              ),
              GoRoute(
                path: AppScreens.sort.path,
                name: AppScreens.sort.name,
                builder: (_, __) => const SortScreen(),
              ),
              GoRoute(
                path: AppScreens.maze.path,
                name: AppScreens.maze.name,
                builder: (_, __) => const MazeScreen(),
              ),
              GoRoute(
                path: AppScreens.sql.path,
                name: AppScreens.sql.name,
                builder: (_, __) => const SQLScreen(),
              ),
              GoRoute(
                path: AppScreens.news.path,
                name: AppScreens.news.name,
                builder: (_, __) => const NewsScreen(),
              ),
              GoRoute(
                path: AppScreens.explore.path,
                name: AppScreens.explore.name,
                builder: (_, __) => const ExploreScreen(),
              ),
              GoRoute(
                path: AppScreens.leaderboards.path,
                name: AppScreens.leaderboards.name,
                builder: (_, __) => const LeaderboardsScreen(),
              ),
              GoRoute(
                path: AppScreens.community.path,
                name: AppScreens.community.name,
                builder: (_, __) => const CommunityScreen(),
              ),
              GoRoute(
                path: AppScreens.contests.path,
                name: AppScreens.contests.name,
                builder: (_, __) => const ContestsScreen(),
              ),
              GoRoute(
                path: AppScreens.jobs.path,
                name: AppScreens.jobs.name,
                builder: (_, __) => const JobsScreen(),
              ),
              GoRoute(
                path: AppScreens.profile.path,
                name: AppScreens.profile.name,
                builder: (_, __) => const ProfileScreen(),
              ),
              GoRoute(
                path: AppScreens.notifications.path,
                name: AppScreens.notifications.name,
                builder: (_, __) => const NotificationScreen(),
              ),
              GoRoute(
                path: AppScreens.settings.path,
                name: AppScreens.settings.name,
                builder: (_, __) => const SettingsScreen(),
              ),
              GoRoute(
                path: AppScreens.featureRequests.path,
                name: AppScreens.featureRequests.name,
                builder: (_, __) => const FeatureRequestScreen(),
              ),
              GoRoute(
                path: AppScreens.bugReports.path,
                name: AppScreens.bugReports.name,
                builder: (_, __) => const BugReportScreen(),
              ),
              GoRoute(
                path: AppScreens.search.path,
                name: AppScreens.search.name,
                builder: (_, __) => const SearchScreen(),
              ),
              GoRoute(
                path: AppScreens.streak.path,
                name: AppScreens.streak.name,
                builder: (_, __) => const StreakScreen(),
              ),
              GoRoute(
                path: AppScreens.auth.path,
                name: AppScreens.auth.name,
                builder: (_, __) => const AuthScreen(),
              ),
              GoRoute(
                path: AppScreens.mastery.path,
                name: AppScreens.mastery.name,
                builder: (_, __) => const MasteryScreen(),
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
                name: AppScreens.landing.toString(),
                builder: (_, __) => const LandingScreen(),
              ),
            ],
          )
        ]),
  ],
);

class App extends StatefulWidget {
  final StatefulNavigationShell? shell;
  final Widget? screen;
  const App({super.key, this.shell, this.screen});
  @override
  State<App> createState() => _AppState();
}

enum AppScreens {
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
  streak,
  auth,
  mastery
}

// ignore: must_be_immutable
class RootNavigator extends StatefulWidget {
  Widget screen;
  RootNavigator({super.key, required this.screen});

  @override
  State<RootNavigator> createState() => _RootNavigatorState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: Scaffold(
        key: drawerKey,
        body: RootNavigator(
          screen: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight,
            color: Colors.black.lighten(75),
            child: widget.screen ?? widget.shell,
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
      ),
    );
  }
}

class _RootNavigatorState extends State<RootNavigator> {
  int currentPageIndex = 0;

  NavigationRailLabelType labelType = NavigationRailLabelType.all;

  @override
  Widget build(BuildContext context) {
    final path = GoRouter.of(context).routeInformationProvider.value.uri;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (!path.toString().startsWith('/problem?'))
          SizedBox(
            height: double.infinity,
            child: NavigationRail(
              useIndicator: true,
              labelType: labelType,
              selectedIndex: currentPageIndex,
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

extension AppPageX on AppScreens {
  String get name {
    switch (this) {
      case AppScreens.problems:
        return 'PROBLEMS';
      case AppScreens.problem:
        return 'PROBLEM';
      case AppScreens.explore:
        return 'EXPLORE';
      case AppScreens.leaderboards:
        return 'LEADERBOARDS';
      case AppScreens.jobs:
        return 'JOBS';
      case AppScreens.news:
        return 'NEWS';
      case AppScreens.community:
        return 'COMMUNITY';
      case AppScreens.featureRequests:
        return 'FEATURE_REQUESTS';
      case AppScreens.bugReports:
        return 'BUG_REPORTS';
      case AppScreens.landing:
        return 'LANDING';
      case AppScreens.notifications:
        return 'NOTIFICATIONS';
      case AppScreens.maze:
        return 'MAZE';
      case AppScreens.sort:
        return 'SORT';
      case AppScreens.sql:
        return 'SQL';
      case AppScreens.contests:
        return 'CONTESTS';
      case AppScreens.profile:
        return 'PROFILE';
      case AppScreens.settings:
        return 'SETTINGS';
      case AppScreens.search:
        return 'SEARCH';
      case AppScreens.streak:
        return 'STREAK';
      case AppScreens.auth:
        return 'AUTH';
      case AppScreens.mastery:
        return 'MASTERY';
      default:
        return 'HOME';
    }
  }

  String get path {
    switch (this) {
      case AppScreens.home:
        return '/';
      case AppScreens.problems:
        return '/problems';
      case AppScreens.problem:
        return '/problem';
      case AppScreens.explore:
        return '/explore';
      case AppScreens.news:
        return '/news';
      case AppScreens.notifications:
        return '/notifications';
      case AppScreens.leaderboards:
        return '/leaderboards';
      case AppScreens.community:
        return '/community';
      case AppScreens.settings:
        return '/settings';
      case AppScreens.profile:
        return '/profile';
      case AppScreens.bugReports:
        return '/bugReports';
      case AppScreens.featureRequests:
        return '/featureRequests';
      case AppScreens.search:
        return '/search';
      case AppScreens.streak:
        return '/streak';
      case AppScreens.landing:
        return '/landing';
      case AppScreens.sql:
        return '/sql';
      case AppScreens.maze:
        return '/maze';
      case AppScreens.sort:
        return '/sort';
      case AppScreens.contests:
        return '/contests';
      case AppScreens.jobs:
        return '/jobs';
      case AppScreens.auth:
        return '/auth';
      case AppScreens.mastery:
        return '/mastery';

      default:
        return '/';
    }
  }
}
