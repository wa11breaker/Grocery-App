import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:grocery/models/category.dart';

class GetCategory extends ChangeNotifier {
  List<Categorys> _category = List();
  List<Categorys> get category => _category;

  bool _loadingCategory = true;
  bool get loadingCategory => _loadingCategory;

  void loading(bool status) {
    _loadingCategory = status;
    notifyListeners();
  }

  Future<void> getCategory() async {
    if (_category.length == 0) {
      await Firestore.instance
          .collection('container')
          .document('category')
          .get()
          .then((doc) {
        for (var i in doc.data['categoryList']) {
          _category.add(Categorys.fromMap(i));
        }
      });

      loading(false);
    }
  }
}
