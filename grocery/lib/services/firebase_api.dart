import 'package:cloud_firestore/cloud_firestore.dart';

class FAPI {
  banners() async {
    List<String> _banners = List();
    Map tempBanners;
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

    return _banners;
  }

  category() {}
}
