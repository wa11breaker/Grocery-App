import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery/models/account_details.dart';

class FAPI {
  Future<List<String>> banners() async {
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

  Future<bool> checkUserDetail(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await Firestore.instance.collection("customers").document(uid).get();
      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future getUserDetail(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await Firestore.instance.collection("customers").document(uid).get();
      return documentSnapshot.data;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> saveUserDetail(
      {AccountDetails accountDetails, String uid}) async {
    try {
      await Firestore.instance
          .collection('customers')
          .document(uid)
          .setData(accountDetails.toJson(), merge: true);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> saveAddress({Address newAddress, String uid}) async {
    try {
      await Firestore.instance
          .collection('customers')
          .document(uid)
          .updateData({
        "addresses": FieldValue.arrayUnion([newAddress.toJson()])
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
