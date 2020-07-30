import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScreenIndex extends ChangeNotifier {
  int _index=0;
  int get index => _index;
  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
