// ignore_for_file: must_be_immutable

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

final routerConfig = GoRouter(
  initialLocation: '/landing',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/landing',
      name: AppScreens.landing.toString(),
      builder: (_, __) => const LandingScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) {
        return App(shell: shell);
      },
      branches: routes,
    ),
    // StatefulShellRoute.indexedStack(
    //     builder: (context, state, shell) {
    //       return App(shell: shell);
    //     },
    //     branches: [
    //       StatefulShellBranch(
    //         navigatorKey: navigatorKeyB,
    //         routes: [
    //           GoRoute(
    //             path: '/landing',
    //             name: AppScreens.landing.toString(),
    //             builder: (_, __) => const LandingScreen(),
    //           ),
    //         ],
    //       )
    //     ]),
  ],
);

class App extends StatefulWidget {
  final Widget? screen;
  final StatefulNavigationShell? shell;
  const App({super.key, this.shell, this.screen});
  @override
  State<App> createState() => _AppState();
}

class RootNavigator extends StatefulWidget {
  Widget screen;
  RootNavigator({super.key, required this.screen});

  @override
  State<RootNavigator> createState() => _RootNavigatorState();
}

class _AppState extends State<App> {
  late bool _isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    final themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final colors = _isDarkMode
        ? <Color>[Colors.black, Colors.black87]
        : <Color>[Colors.blue[900]!, Colors.lightBlue];

    return MaterialApp(
      scaffoldMessengerKey: snackKey,
      themeMode: themeMode,
      theme: Style.lightTheme,
      darkTheme: Style.darkTheme,
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: drawerKey,
        body: RootNavigator(
          screen: SizedBox(
            height: height,
            child: widget.screen ?? widget.shell,
          ),
        ),
        drawer: const MyDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: SizedBox(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors),
              ),
              child: AppBarContent(toggleTheme: toggleTheme),
            ),
          ),
        ),
      ),
    );
  }

  getStoredTheme() async {
    final storedTheme = await Storage.instance.getTheme();
    if (storedTheme != _isDarkMode) {
      setState(() {
        _isDarkMode = storedTheme;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getStoredTheme();
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    Style.instance.updateBrightness(context);
    Storage.instance.setTheme();
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
