import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/models/product.dart';
import 'package:grocery/services/firebase_api.dart';

class FilterProvider extends ChangeNotifier {
  List<Product> _filterRestult = List();
  List<Product> get filterResult => _filterRestult;

  bool _loading = true;
  bool get loading => _loading;

  DocumentSnapshot _lastDoc;

  getFilterResult(String filterId) async {
    QuerySnapshot res = await FAPI().filter(categoryId: filterId);
    if (res.docs.length > 0) {
      for (var i in res.docs) {
        _filterRestult.add(Product.formDocument(i));
      }
      _lastDoc = res.docs.last;
    }
    _loading = false;
    notifyListeners();
  }

  fetchMore(String filterId) async {
    QuerySnapshot res =
        await FAPI().fetchMoreFilter(categoryId: filterId, lastDoc: _lastDoc);
    for (var i in res.docs) {
      _filterRestult.add(Product.formDocument(i));
    }
    _lastDoc = res.docs.last;
    notifyListeners();
  }

  clearFliter() {
    _loading = true;
    _filterRestult.clear();
    notifyListeners();
  }
}
