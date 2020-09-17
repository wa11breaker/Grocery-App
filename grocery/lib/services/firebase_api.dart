import 'package:grocery/models/account_details.dart';
import 'package:grocery/models/category.dart';
import 'package:grocery/models/order.dart';
import 'package:grocery/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FAPI {
  //
  Future<List<String>> banners() async {
    List<String> _banners = List();
    Map tempBanners;
    try {
      await FirebaseFirestore.instance
          .collection('store')
          .doc('banners')
          .get()
          .then(
            (value) => tempBanners = value.data(),
          );
      for (var i in tempBanners['bannerList']) {
        _banners.add(i);
      }
    } catch (e) {
      print(e);
    }
    return _banners;
  }

  //
  Future<List<Categorys>> category() async {
    List<Categorys> _category = List<Categorys>();

    await FirebaseFirestore.instance
        .collection('store')
        .doc('category')
        .get()
        .then(
      (doc) {
        for (var i in doc.data()['category']) {
          _category.add(Categorys.fromMap(i));
        }
      },
    );

    return _category;
  }

  //
  Future<QuerySnapshot> filter({String categoryId}) async {
    QuerySnapshot _category;

    _category = await FirebaseFirestore.instance
        .collection('product')
        .where('categoryId', isEqualTo: categoryId)
        .limit(10)
        .get();

    return _category;
  }

  Future<QuerySnapshot> fetchMoreFilter(
      {String categoryId, DocumentSnapshot lastDoc}) async {
    QuerySnapshot _category;

    try {
      _category = await FirebaseFirestore.instance
          .collection('product')
          .where('categoryId', isEqualTo: categoryId)
          .startAfterDocument(lastDoc)
          .limit(10)
          .get();
    } catch (e) {
      print(e);
    }

    return _category;
  }

  //
  Future<List<Product>> featuredProduct() async {
    List<Product> _category = List<Product>();

    await FirebaseFirestore.instance
        .collection('product')
        .where('isFeatured', isEqualTo: true)
        .get()
        .then(
      (doc) {
        for (var i in doc.docs) {
          _category.add(Product.formDocument(i));
        }
      },
    );

    return _category;
  }

  // return false if their is no use data
  Future<bool> checkUserDetail(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("customers")
          .doc(uid)
          .get();
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

  // fetch all user details
  Future getUserDetail(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("customers")
          .doc(uid)
          .get();
      return documentSnapshot.data();
    } catch (e) {
      print(e);
    }
  }

  // save user data to the corresponding user auth id doc
  Future<bool> saveUserDetail(
      {AccountDetails accountDetails, String uid}) async {
    try {
      await FirebaseFirestore.instance.collection('customers').doc(uid).set(
            accountDetails.toJson(),
          );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // add new address to the user doc
  // return true if adding new address is successfull
  Future<bool> saveAddress({Address newAddress, String uid}) async {
    try {
      await FirebaseFirestore.instance.collection('customers').doc(uid).update({
        "addresses": FieldValue.arrayUnion([newAddress.toJson()])
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteAddress({Address newAddress, String uid}) async {
    try {
      await FirebaseFirestore.instance.collection('customers').doc(uid).update({
        "addresses": FieldValue.arrayRemove([newAddress.toJson()])
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> placeOrder({OrderModel order}) async {
    try {
      await FirebaseFirestore.instance.collection('orders').add(order.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
