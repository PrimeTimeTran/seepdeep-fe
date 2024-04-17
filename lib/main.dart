import 'package:app/navigation/app_bar_content.dart';
import 'package:app/navigation/drawer.dart';
import 'package:app/navigation/root.dart';
import 'package:app/providers/problem_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' as stateProvider;

import './constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(stateProvider.MultiProvider(
    providers: [
      stateProvider.ChangeNotifierProvider(create: (_) => ProblemProvider()),
    ],
    child: MyApp(),
  ));
}

class App extends StatefulWidget {
  final StatefulNavigationShell shell;
  const App({super.key, required this.shell});
  @override
  State<App> createState() => _AppState();
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget
    with ChangeNotifier, DiagnosticableTreeMixin {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ValueListenableBuilder<bool>(
        valueListenable: material3Notifier,
        builder: (BuildContext context, bool value, Widget? child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'CSGems',
            routerConfig: routerConfig,
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

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      body: RootNavigator(
          screen: Container(
        color: Colors.blue,
        child: widget.shell,
      )),
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
