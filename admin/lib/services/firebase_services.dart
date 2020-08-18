import 'package:admin/models/item_model.dart';
import 'package:admin/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FAPI {
  Future<List<String>> banners() async {
    List<String> _banners = List();
    Map tempBanners;
    try {
      await Firestore.instance
          .collection('store')
          .document('banners')
          .get()
          .then(
            (value) => tempBanners = value.data,
          );
      for (var i in tempBanners['bannerList']) {
        _banners.add(i);
      }
    } catch (e) {
      print(e);
    }
    return _banners;
  }

  // Future<List<Categorys>> category() async {
  //   List<Categorys> _category = List<Categorys>();

  //   await Firestore.instance
  //       .collection('store')
  //       .document('category')
  //       .get()
  //       .then(
  //     (doc) {
  //       for (var i in doc.data['categoryList']) {
  //         _category.add(Categorys.fromMap(i));
  //       }
  //     },
  //   );

  //   return _category;
  // }

  Future<List<ItemModle>> filter({String categoryId}) async {
    List<ItemModle> _category = List<ItemModle>();

    await Firestore.instance
        .collection('items')
        .where('categoryId', isEqualTo: categoryId)
        .getDocuments()
        .then(
      (doc) {
        for (var i in doc.documents) {
          _category.add(ItemModle.formDocument(i));
        }
      },
    );

    return _category;
  }

  Future<List<ItemModle>> featuredProduct() async {
    List<ItemModle> _category = List<ItemModle>();

    await Firestore.instance
        .collection('items')
        .where('featured', isEqualTo: true)
        .getDocuments()
        .then(
      (doc) {
        for (var i in doc.documents) {
          _category.add(ItemModle.formDocument(i));
        }
      },
    );

    return _category;
  }

  Stream<List<OrderModel>> orders() {
    var ref = Firestore.instance
        .collection('orders')
        .where('orderStatus', isEqualTo: 'ORDER-PLACES');
    return ref.snapshots().map((list) =>
        list.documents.map((doc) => OrderModel.fromFirestore(doc)).toList());
  }
  /* Future<bool> checkUserDetail(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await Firestore.instance.collection("customers").document(uid).get();
      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
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
  } */
}
