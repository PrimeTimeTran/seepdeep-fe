import 'package:app/navigation/root.dart';
import 'package:app/providers/problem_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            title: 'CSGems',
            routerConfig: routerConfig,
            debugShowCheckedModeBanner: false,
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
