import 'package:flutter/foundation.dart';
import 'package:grocery/services/firebase_api.dart';

class GetBanners extends ChangeNotifier {
  List<String> _banners = List();
  List<String> get banners => _banners;

  // set loading to true by default
  bool _loading = true;
  bool get loading => _loading;

  Future<void> getBanners() async {
    if (_banners.length == 0) {
      _banners = await FAPI().banners();
      _loading = false;
      notifyListeners();
    }
  }
}
