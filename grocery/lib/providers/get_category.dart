import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:grocery/models/category.dart';

class GetCategory extends ChangeNotifier {
  List<Categorys> _category;
  List<Categorys> get category => _category;

  bool _loadingCategory;
  bool get loadingCategory => _loadingCategory;

  void loading(bool status) {
    _loadingCategory = status;
    notifyListeners();
  }

  Future<void> getCategory() async {
    loading(true);
    if (_category.length != 0) {
      Map<String, dynamic> tempBanners;
      await Firestore.instance
          .collection('container')
          .document('categorys')
          .get()
          .then(
            (value) => tempBanners = value.data,
          );

      for (var i in tempBanners['categoryList']) {
        _category.add(Categorys.fromMap(i));
      }

      loading(false);
    }
  }
}
