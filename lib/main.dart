// ignore_for_file: must_be_immutable

import 'package:app/all.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:seo/seo.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  runApp(
    provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(create: (_) => AuthProvider()),
        provider.ChangeNotifierProvider(create: (_) => ProblemProvider()),
        provider.ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget
    with ChangeNotifier, DiagnosticableTreeMixin {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Style.instance.initialize(context);

    return ProviderScope(
      child: ValueListenableBuilder<bool>(
        valueListenable: material3Notifier,
        builder: (BuildContext context, bool value, Widget? child) {
          return SeoController(
            enabled: true,
            tree: WidgetTree(context: context),
            child: MaterialApp.router(
              title: 'SeepDeep',
              routerConfig: routerConfig,
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
