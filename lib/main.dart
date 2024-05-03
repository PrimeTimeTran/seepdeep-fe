import 'package:app/all.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as stateProvider;
import 'package:url_strategy/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  runApp(
    stateProvider.MultiProvider(
      providers: [
        stateProvider.ChangeNotifierProvider(create: (_) => AuthProvider()),
        stateProvider.ChangeNotifierProvider(create: (_) => ProblemProvider()),
      ],
      child: MyApp(),
    ),
  );
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
          );
        },
      ),
    );
  }
}
