import 'package:app/navigation/app_bar_content.dart';
import 'package:app/navigation/drawer.dart';
import 'package:app/screens/bug_report_screen.dart';
import 'package:app/screens/community_screen.dart';
import 'package:app/screens/contests_screen.dart';
import 'package:app/screens/explore_screen.dart';
import 'package:app/screens/feature_request_screen.dart';
import 'package:app/screens/jobs_screen.dart';
import 'package:app/screens/leaderboards_screen.dart';
import 'package:app/screens/maze_screen.dart';
import 'package:app/screens/notification_screen.dart';
import 'package:app/screens/problem_screen.dart';
import 'package:app/screens/problems_screen.dart';
import 'package:app/screens/profile_screen.dart';
import 'package:app/screens/search_screen.dart';
import 'package:app/screens/settings_screen.dart';
import 'package:app/screens/sort_screen.dart';
import 'package:app/screens/sql_screen.dart';
import 'package:app/screens/streak_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import './constants.dart';
import './screens/news_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, shell) {
          return App(shell: shell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: '/',
                name: Routes.home.toString(),
                builder: (_, __) => const ProblemScreen(),
                routes: [
                  GoRoute(
                    path: 'problem',
                    name: Routes.problem.toString(),
                    builder: (_, __) => const ProblemScreen(),
                    routes: const [],
                  ),
                  GoRoute(
                    path: 'problems',
                    name: Routes.problems.toString(),
                    builder: (_, __) => const ProblemsScreen(),
                    routes: const [],
                  ),
                  GoRoute(
                    path: 'sort',
                    name: Routes.sort.toString(),
                    builder: (_, __) => const SortScreen(),
                  ),
                  GoRoute(
                    path: 'maze',
                    name: Routes.maze.toString(),
                    builder: (_, __) => const MazeScreen(),
                  ),
                  GoRoute(
                    path: 'sql',
                    name: Routes.sql.toString(),
                    builder: (_, __) => const SQLScreen(),
                  ),
                  GoRoute(
                    path: 'news',
                    name: Routes.news.toString(),
                    builder: (_, __) => const NewsScreen(),
                  ),
                  GoRoute(
                    path: 'explore',
                    name: Routes.explore.toString(),
                    builder: (_, __) => const ExploreScreen(),
                  ),
                  GoRoute(
                    path: 'leaderboards',
                    name: Routes.leaderboards.toString(),
                    builder: (_, __) => const LeaderboardsScreen(),
                  ),
                  GoRoute(
                    path: 'community',
                    name: Routes.community.toString(),
                    builder: (_, __) => const CommunityScreen(),
                  ),
                  GoRoute(
                    path: 'contests',
                    name: Routes.contests.toString(),
                    builder: (_, __) => const ContestsScreen(),
                  ),
                  GoRoute(
                    path: 'jobs',
                    name: Routes.jobs.toString(),
                    builder: (_, __) => const JobsScreen(),
                  ),
                  GoRoute(
                    path: 'profile',
                    name: Routes.profile.toString(),
                    builder: (_, __) => const ProfileScreen(),
                  ),
                  GoRoute(
                    path: 'notifications',
                    name: Routes.notifications.toString(),
                    builder: (_, __) => const NotificationScreen(),
                  ),
                  GoRoute(
                    path: 'settings',
                    name: Routes.settings.toString(),
                    builder: (_, __) => const SettingsScreen(),
                  ),
                  GoRoute(
                    path: 'feature-requests',
                    name: Routes.featureRequests.toString(),
                    builder: (_, __) => const FeatureRequestScreen(),
                  ),
                  GoRoute(
                    path: 'bug-reports',
                    name: Routes.bugReports.toString(),
                    builder: (_, __) => const BugReportScreen(),
                  ),
                  GoRoute(
                    path: 'search',
                    name: Routes.search.toString(),
                    builder: (_, __) => const SearchScreen(),
                  ),
                  GoRoute(
                    path: 'streak',
                    name: Routes.streak.toString(),
                    builder: (_, __) => const StreakScreen(),
                  ),
                ],
              ),
            ],
          )
        ]),
  ],
);

final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');

class App extends StatefulWidget {
  final StatefulNavigationShell shell;
  const App({super.key, required this.shell});
  @override
  State<App> createState() => _AppState();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ValueListenableBuilder<bool>(
        valueListenable: material3Notifier,
        builder: (BuildContext context, bool value, Widget? child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'GemsOfCS',
            routerConfig: _router,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            ),
          );
        },
      ),
    );
  }
}

enum Routes {
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
      body: widget.shell,
      drawer: const DrawerContent(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Colors.blue[900]!, Colors.lightBlue],
            ),
          ),
          child: const AppBarContent(),
        ),
      ),
    );
  }
}
