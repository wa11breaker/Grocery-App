import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

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
      Map<String, dynamic> tempBanners;

      await Firestore.instance
          .collection('container')
          .document('banners')
          .get()
          .then(
            (value) => tempBanners = value.data,
          );

      for (var i in tempBanners['bannerList']) {
        _banners.add(i);
      }

      loading(false);
    }
  }
}
