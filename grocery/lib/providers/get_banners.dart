import 'package:flutter/foundation.dart';
import 'package:grocery/services/firebase_api.dart';

class GetBanners extends ChangeNotifier {
  List<String> _banners = List();
  List<String> get banners => _banners;

  bool _loadingoffers;
  bool get loadingoffers => _loadingoffers;

  void loading(bool status) {
    _loadingoffers = status;
    notifyListeners();
  }

  Future<void> getBanners() async {
    if (_banners.length == 0) {
      _banners = await FAPI().banners();
      loading(false);
    }
  }
}
