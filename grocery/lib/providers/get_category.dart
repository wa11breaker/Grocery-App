import 'package:flutter/foundation.dart';
import 'package:grocery/models/category.dart';
import 'package:grocery/services/firebase_api.dart';

class GetCategory extends ChangeNotifier {
  List<Categorys> _category = List();
  List<Categorys> get category => _category;

  bool _loading = true;
  bool get loading => _loading;

  void loadingStatus(bool status) {
    _loading = status;
    notifyListeners();
  }

  getCategory() async {
    if (_category.length == 0) {
      _category = await FAPI().category();
      loadingStatus(false);
    }
  }
}
