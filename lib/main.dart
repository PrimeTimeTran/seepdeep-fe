import 'package:app/screens/code_editor/code_editor_screen.dart';
import 'package:app/screens/maze_screen.dart';
import 'package:app/screens/sort_screen.dart';
import 'package:app/screens/sql_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const MyHomePage(),
        routes: const [],
      ),
    ],
  );
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Data Structures & Algorithms',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int currentPageIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CS Toolkit'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavigationRail(
            labelType: labelType,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.sort),
                label: Text('Sorting'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.grid_on),
                label: Text('Matrix'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.code),
                label: Text('Code'),
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
                  [
                    const SortScreen(),
                    const MazeScreen(),
                    CodeEditorScreen(
                      onRun: () {},
                    ),
                    const SQLScreen(),
                  ][currentPageIndex]
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
