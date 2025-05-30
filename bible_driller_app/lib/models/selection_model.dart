// selection_model.dart
import 'package:flutter/foundation.dart';

class SelectionModel with ChangeNotifier {
  String _version = 'kjv';
  String _color = 'red';
  bool _drillStarted = false;

  String get version => _version;
  String get color => _color;
  bool get drillStarted => _drillStarted;

  void setVersion(String newVersion) {
    _version = newVersion;
    notifyListeners();
  }

  void setColor(String newColor) {
    _color = newColor;
    notifyListeners();
  }

  void startDrill() {
    _drillStarted = true;
    notifyListeners();
  }

  void resetDrill() {
    _drillStarted = false;
    notifyListeners();
  }
}