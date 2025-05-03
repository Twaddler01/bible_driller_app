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

class BibleDrillerApp extends StatelessWidget {
  const BibleDrillerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bible Driller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
      '/': (context) => SelectScreen(),        // Your home screen
      '/selectScreen': (context) => SelectScreen(),
      '/drillScreen': (context) => DrillScreen(),
      },
    );
  }
}