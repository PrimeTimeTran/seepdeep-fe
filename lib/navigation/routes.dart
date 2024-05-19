import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigatorKeyA = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final navigatorKeyB = GlobalKey<NavigatorState>(debugLabel: 'shellB');

final routes = [
  StatefulShellBranch(
    navigatorKey: navigatorKeyA,
    routes: [
      GoRoute(
        path: AppScreens.mastery.path,
        name: AppScreens.mastery.name,
        builder: (_, __) => const MasteryScreen(),
      ),
      GoRoute(
        path: AppScreens.problems.path,
        name: AppScreens.problems.name,
        builder: (_, __) => const ProblemsScreen(),
      ),
      GoRoute(
        path: '${AppScreens.problem.path}/:name',
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
        path: AppScreens.math.path,
        name: AppScreens.math.name,
        builder: (_, __) => const MathScreen(),
      ),
      GoRoute(
        path: AppScreens.mathIndex.path,
        name: AppScreens.mathIndex.name,
        builder: (_, __) => const MathScreen(),
      ),
      GoRoute(
        path: AppScreens.designKit.path,
        name: AppScreens.designKit.name,
        builder: (_, __) => const DesignKitScreen(),
      ),
      GoRoute(
        path: AppScreens.test.path,
        name: AppScreens.test.name,
        builder: (_, __) => const TestScreen(),
      ),
    ],
  )
];

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
  mastery,
  mathIndex,
  math,
  designKit,
  test
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
      case AppScreens.mathIndex:
        return 'MATHINDEX';
      case AppScreens.math:
        return 'MATH';
      case AppScreens.designKit:
        return 'DESIGN_KIT';
      case AppScreens.test:
        return 'TEST';
      default:
        return 'HOME';
    }
  }

  String get path {
    switch (this) {
      case AppScreens.mastery:
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
      case AppScreens.mathIndex:
        return '/maths';
      case AppScreens.math:
        return '/math';
      case AppScreens.designKit:
        return '/design-kit';
      case AppScreens.test:
        return '/test';
      default:
        return '/';
    }
  }
}
