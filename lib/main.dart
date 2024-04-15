import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'screens/editor.dart';
import 'screens/home.dart';
// import 'database/sql_editor.dart';
import 'screens/maze.dart';
import 'screens/sort.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) =>
            const MyHomePage(title: 'Data Structures & Algorithms'),
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
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int currentPageIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('DSA Visualizer'),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Container(
          // color: Colors.red,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavigationRail(
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
                    icon: Icon(Icons.table_chart_outlined),
                    label: Text('SQL'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.code),
                    label: Text('Code'),
                  )
                ],
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
                    children: [
                      [
                        const SortPage(),
                        const MatrixPage(),
                        const HomePage(),
                        const CodeEditor()
                        // const CodeEditor(),
                      ][currentPageIndex]
                    ],
                  ),
                ),
              ),
              // const Expanded(child: CodeEditor()),
            ],
          ),
        ),
      ),
    );
  }
}
