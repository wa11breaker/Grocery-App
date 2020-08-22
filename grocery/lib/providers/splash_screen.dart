import 'package:flutter/material.dart';

class SplashScreenProvider extends ChangeNotifier {
  bool _finish = false;
  bool get finish => _finish;
  void showSplash() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      _finish = true;
      notifyListeners();
    });
  }
}
