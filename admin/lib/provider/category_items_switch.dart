import 'package:flutter/foundation.dart';

class CategoryItemSwitch extends ChangeNotifier {
  bool _isItems = false;
  bool get isItems => _isItems;

  update(bool value) {
    _isItems = value;
    notifyListeners();
  }
}
