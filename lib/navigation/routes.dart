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
  math,
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
      case AppScreens.math:
        return 'MATH';
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
      case AppScreens.math:
        return '/math';
      case AppScreens.mastery:
        return '/mastery';

      default:
        return '/';
    }
  }
}
