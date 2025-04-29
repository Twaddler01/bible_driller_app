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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bible Driller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SelectScreen(),
    );
  }
}