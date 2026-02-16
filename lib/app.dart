import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

/// The root widget of the Dangshi application
class DangshiApp extends ConsumerStatefulWidget {
  const DangshiApp({super.key});

  @override
  ConsumerState<DangshiApp> createState() => _DangshiAppState();
}

class _DangshiAppState extends ConsumerState<DangshiApp> {
  @override
  Widget build(BuildContext context) {
    final routerAsync = ref.watch(routerProvider);

    return routerAsync.when(
      data: (router) => MaterialApp.router(
        title: '当时',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('zh', 'CN'),
          Locale('en', 'US'),
        ],
        locale: const Locale('zh', 'CN'),
      ),
      loading: () => MaterialApp(
        title: '当时',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (error, stack) => MaterialApp(
        title: '当时',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: Center(
            child: Text('Error: $error'),
          ),
        ),
      ),
    );
  }
}
