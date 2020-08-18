import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class BannerProvider extends ChangeNotifier {
  List<String> _bannerList = List();
  List<String> get bannerList => _bannerList;

  getBannerList() async {
    if (_bannerList.length == 0) {
      var list = await Firestore.instance
          .collection('store')
          .document('banners')
          .get();
      list.data['bannerList'].forEach((e) => _bannerList.add(e));
      notifyListeners();
    }
  }

  addNewBanner(String image) async {
    await Firestore.instance.collection('store').document('banners').updateData(
      {
        'bannerList': FieldValue.arrayUnion(
          [image],
        )
      },
    ).then((value) {
      _bannerList.add(image);
      notifyListeners();
    });
  }

  removeBanner(String image) async {
    await Firestore.instance.collection('store').document('banners').updateData(
      {
        'bannerList': FieldValue.arrayRemove(
          [image],
        )
      },
    ).then((value) {
      _bannerList.removeWhere((element) => element == image);
      notifyListeners();
    });
// todo Delete file for bucket
    /*   String filePath =
        "https://firebasestorage.googleapis.com/v0/b/capital-supply-6dee7.appspot.com/o/banners%2F4d3f8240-e098-11ea-9301-d71db30947ff.png?alt=media&token=a0412919-5fb5-4735-81c5-95db86a15dd6";
    filePath = filePath.substring(79, filePath.length);
    filePath = filePath.replaceFirst(RegExp(r'%2F'), '/');
    filePath = filePath.split('?').first;

    StorageReference storageReferance = FirebaseStorage.instance.ref();

    await storageReferance
        .child(filePath)
        .delete()
        .then((_) => print('Successfully deleted $filePath storage item')); */
  }
}
