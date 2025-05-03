import 'package:bible_driller_app/screens/drill_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/selection_model.dart';
import 'screens/select_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SelectionModel(),
      child: BibleDrillerApp(),
    ),
  );
}

class RouteObserverProvider extends NavigatorObserver {
  String? currentRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    currentRoute = route.settings.name;
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    currentRoute = previousRoute?.settings.name;
    super.didPop(route, previousRoute);
  }
}

final RouteObserverProvider _routeObserver = RouteObserverProvider();

class BibleDrillerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bible Driller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [_routeObserver],
      routes: {
      '/': (context) => SelectScreen(),        // Your home screen
      '/selectScreen': (context) => SelectScreen(),
      '/drillScreen': (context) => DrillScreen(),
      },
    );
  }
}