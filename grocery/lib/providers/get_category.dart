import 'package:flutter/foundation.dart';
import 'package:grocery/models/category.dart';
import 'package:grocery/services/firebase_api.dart';

class GetCategory extends ChangeNotifier {
  List<Categorys> _category = List();
  List<Categorys> get category => _category;

  bool _loadingCategory = true;
  bool get loadingCategory => _loadingCategory;

  void loading(bool status) {
    _loadingCategory = status;
    notifyListeners();
  }

  getCategory() async {
    if (_category.length == 0) {
      _category = await FAPI().category();
      loading(false);
    }
  }
}
