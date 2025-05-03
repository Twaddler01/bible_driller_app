import 'package:flutter/foundation.dart';

class SelectionModel with ChangeNotifier {
  String _version = 'KJV';
  String _color = 'Red';

  String get version => _version;
  String get color => _color;

  void setVersion(String newVersion) {
    _version = newVersion;
    notifyListeners();
  }

  void setColor(String newColor) {
    _color = newColor;
    notifyListeners();
  }
}